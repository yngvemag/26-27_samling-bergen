# Normalisering av school-databasen

Dette dokumentet forklarer hva normalisering er, hvordan vi identifiserer et problem i en eksisterende database, og hvordan vi går frem for å løse det — illustrert med konkrete eksempler fra `database/` og `database-improved/`.

---

## Hva er normalisering?

Normalisering handler om å organisere en database slik at den samme informasjonen ikke lagres på flere steder, det er enkelt å endre og vedlikeholde data, og databasen ikke kan ende opp i en inkonsistent tilstand.

En rettesnor er at **én ting skal lagres på ett sted**. Hvis det samme finnes mange steder i databasen, er det et tegn på at noe kan forbedres.

---

## Steg 1: Identifiser problemet

Se på tabellen `students` i den opprinnelige versjonen (`database/1-setup-db.sql`):

```sql
CREATE TABLE students (
    student_id    INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    study_program VARCHAR(100) NOT NULL,   -- <-- her er problemet
    start_year    INT NOT NULL
);
```

Og se på dataene som ble satt inn (`database/2-insert-data.sql`):

```sql
INSERT INTO students (first_name, last_name, email, study_program, start_year)
VALUES
    ('Emma',   'Hansen',   'emma.hansen@example.com',     'Backend-utvikling', 2026),
    ('Oliver', 'Johansen', 'oliver.johansen@example.com', 'Backend-utvikling', 2026),
    ('Nora',   'Larsen',   'nora.larsen@example.com',     'Backend-utvikling', 2026),
    ('Jakob',  'Nilsen',   'jakob.nilsen@example.com',    'Backend-utvikling', 2026),
    ...
```

Legg merke til at tekststrengen `'Backend-utvikling'` gjentas for hver eneste Backend-student — ni ganger i dette tilfellet. Det samme gjelder `'Frontend-utvikling'` og `'Cybersikkerhet'`.

Slik ser tabellen ut med data:

| student_id | first_name | last_name   | study_program      | start_year |
|------------|------------|-------------|--------------------|------------|
| 1          | Emma       | Hansen      | Backend-utvikling  | 2026       |
| 2          | Oliver     | Johansen    | Backend-utvikling  | 2026       |
| 3          | Nora       | Larsen      | Backend-utvikling  | 2026       |
| 10         | Lucas      | Kristiansen | Frontend-utvikling | 2026       |
| 11         | Sara       | Moen        | Frontend-utvikling | 2026       |
| 16         | William    | Lie         | Cybersikkerhet     | 2026       |

### Hva er problemet konkret?

**1. Dataredundans**

Samme tekst lagres mange ganger. Det sløser plass, men det er ikke det verste.

**2. Oppdateringsanomali**

Hva skjer hvis skolen ønsker å endre navn fra `'Backend-utvikling'` til `'Backend- og serverutvikling'`? Da må vi oppdatere alle radene som inneholder den teksten:

```sql
-- Opprinnelig versjon: må oppdatere ALLE studenter på programmet
UPDATE students
SET study_program = 'Backend- og serverutvikling'
WHERE study_program = 'Backend-utvikling';
```

Hvis noen av radene har en skrivefeil (f.eks. `'Backend -utvikling'` med et mellomrom), vil de ikke bli oppdatert — og vi ender opp med inkonsistente data.

**3. Inkonsekvens**

Fordi programnavnet er fritekst, er det ingenting som hindrer dette:

```sql
INSERT INTO students (..., study_program, ...) VALUES (..., 'backend-utvikling', ...);
INSERT INTO students (..., study_program, ...) VALUES (..., 'Backend Utvikling', ...);
INSERT INTO students (..., study_program, ...) VALUES (..., 'Backend-utvikling', ...);
```

Alle tre ser ut som det samme programmet for et menneske, men databasen behandler dem som tre ulike verdier. Spørringer med `WHERE study_program = 'Backend-utvikling'` vil da ikke returnere alle studentene.

---

## Steg 2: Definer løsningen

Løsningen er å trekke ut studieprogrammet til en **egen tabell** og koble dem sammen med en **fremmednøkkel** (foreign key).

Prinsippet:

```
FØR:   students.study_program  = 'Backend-utvikling'  (tekst lagret direkte)

ETTER: study_programs.program_name = 'Backend-utvikling'  (lagret én gang)
       students.study_program_id   = 1                    (kun et tall, FK)
```

---

## Steg 3: Implementer løsningen

### 3a. Opprett den nye tabellen

I `database-improved/1-setup-db.sql` er det lagt til en ny tabell før `students`:

```sql
CREATE TABLE study_programs (
    study_program_id INT AUTO_INCREMENT PRIMARY KEY,
    program_name     VARCHAR(100) NOT NULL UNIQUE
);
```

`UNIQUE` på `program_name` sikrer at det samme programnavnet ikke kan registreres to ganger.

### 3b. Endre students-tabellen

Kolonnen `study_program VARCHAR(100)` er erstattet med `study_program_id INT` og en fremmednøkkel:

```sql
-- FØR (database/1-setup-db.sql)
CREATE TABLE students (
    ...
    study_program VARCHAR(100) NOT NULL,
    ...
);

-- ETTER (database-improved/1-setup-db.sql)
CREATE TABLE students (
    ...
    study_program_id INT NOT NULL,
    ...
    CONSTRAINT fk_students_study_program
        FOREIGN KEY (study_program_id)
        REFERENCES study_programs(study_program_id)
);
```

Fremmednøkkelen garanterer at en student alltid peker på et studieprogram som faktisk finnes i `study_programs`. Det er ikke mulig å registrere en student med en `study_program_id` som ikke eksisterer.

---

## Steg 4: Oppdater INSERT-setningene

### Legg inn programmene først

Fordi `students` nå har en fremmednøkkel til `study_programs`, **må** programmene finnes i databasen før vi kan legge inn studenter.

```sql
-- database-improved/2-insert-data.sql

INSERT INTO study_programs (program_name)
VALUES
    ('Backend-utvikling'),    -- får study_program_id = 1
    ('Frontend-utvikling'),   -- får study_program_id = 2
    ('Cybersikkerhet');       -- får study_program_id = 3
```

### Bruk ID i stedet for tekst

```sql
-- FØR (database/2-insert-data.sql)
INSERT INTO students (first_name, last_name, email, study_program, start_year)
VALUES
    ('Emma',  'Hansen',      'emma.hansen@example.com',       'Backend-utvikling',  2026),
    ('Lucas', 'Kristiansen', 'lucas.kristiansen@example.com', 'Frontend-utvikling', 2026);

-- ETTER (database-improved/2-insert-data.sql)
INSERT INTO students (first_name, last_name, email, study_program_id, start_year)
VALUES
    ('Emma',  'Hansen',      'emma.hansen@example.com',       1, 2026),
    ('Lucas', 'Kristiansen', 'lucas.kristiansen@example.com', 2, 2026);
```

Slik ser tabellene ut med data etter normalisering:

**study_programs:**

| study_program_id | program_name       |
|------------------|--------------------|
| 1                | Backend-utvikling  |
| 2                | Frontend-utvikling |
| 3                | Cybersikkerhet     |

**students (utdrag):**

| student_id | first_name | last_name   | study_program_id | start_year |
|------------|------------|-------------|------------------|------------|
| 1          | Emma       | Hansen      | 1                | 2026       |
| 2          | Oliver     | Johansen    | 1                | 2026       |
| 10         | Lucas      | Kristiansen | 2                | 2026       |
| 16         | William    | Lie         | 3                | 2026       |

Programnavnet lagres nå **én gang** i `study_programs`. Studenttabellen inneholder bare et tall som peker dit.

---

## Steg 5: Oppdater SELECT-spørringene

Fordi programnavnet ikke lenger ligger i `students`, må vi bruke `JOIN` for å hente det frem.

```sql
-- FØR (database/3-queries.sql)
SELECT first_name, last_name, study_program, start_year
FROM students
ORDER BY last_name;

-- ETTER (database-improved/3-queries.sql)
SELECT s.first_name, s.last_name, sp.program_name AS study_program, s.start_year
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
ORDER BY s.last_name;
```

Det ser litt mer komplisert ut, men resultatene er de samme. `JOIN`-en kobler studenten med programnavnet via ID-en.

Tilsvarende for filtrering:

```sql
-- FØR
WHERE study_program = 'Backend-utvikling'

-- ETTER
WHERE sp.program_name = 'Backend-utvikling'
```

---

## Steg 6: Fordelen viser seg ved UPDATE

Her er det normaliserte designet virkelig nyttig. Skal skolen endre et programnavn, holder det å oppdatere **én rad** i `study_programs`:

```sql
-- Normalisert versjon: én enkelt UPDATE dekker alle studenter på programmet
UPDATE study_programs
SET program_name = 'Backend- og serverutvikling'
WHERE program_name = 'Backend-utvikling';
```

Alle studenter som peker på `study_program_id = 1` vil automatisk vise det nye navnet neste gang man gjør en `SELECT` med `JOIN`. Ingenting i `students`-tabellen trenger å røres.

### Mer komplekst tilfelle: dele opp et kull

I den forbedrede versjonen er det vist et tilfelle der bare Frontend-studentene fra 2025 skal flyttes til et nytt program, mens 2026-kullet beholder det gamle. Da legger vi til et nytt program og oppdaterer bare de aktuelle studentene:

```sql
-- Steg 1: Nytt program
INSERT INTO study_programs (program_name)
VALUES ('Frontend- og webutvikling');

-- Steg 2: Flytt bare 2025-studentene (anta at nytt program fikk ID = 4)
UPDATE students
SET study_program_id = 4
WHERE study_program_id = 2
  AND start_year = 2025;
```

Dette hadde vært mye vanskeligere å gjøre trygt i den opprinnelige versjonen med fritekst, fordi det ikke er noe som hindrer feil i tekststrengen.

---

## Oppsummering

| | Opprinnelig versjon | Forbedret versjon |
|---|---|---|
| Programnavn lagres | I hver student-rad | Én gang i `study_programs` |
| Endring av programnavn | UPDATE på mange rader | UPDATE på én rad |
| Risiko for skrivefeil | Høy (fritekst) | Ingen (kontrollert av FK) |
| SELECT trenger JOIN | Nei | Ja |
| Ugyldig program mulig | Ja | Nei (FK blokkerer) |

### Nøkkelbegreper

- **Dataredundans** — samme informasjon lagres på flere steder
- **Oppdateringsanomali** — en endring må gjøres mange steder og kan lett gå galt
- **Fremmednøkkel (FK)** — en kolonne som peker på primærnøkkelen i en annen tabell
- **Normalisering** — prosessen med å omstrukturere tabeller for å fjerne redundans og sikre datakonsistens