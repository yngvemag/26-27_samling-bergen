# Oppgave: Filbehandling, divisjon og feilhåndtering

Lag et program som leser inn tall fra en CSV-fil, utfører divisjon og gir brukeren mulighet til å lagre resultatene.

## 1. Les inn tall fra fil

Programmet skal lese inn kommaseparerte tall fra filen `tall.csv`.

**Eksempel på filinnhold:**

```text
12, 15, 8.5, 20, 7
1, 235, 42.5, 20.4, 13, 2, 5, 87
63, 25, 81.1
55.2, 13.7, 83, 12, 31, 321
```

Alle tallene skal leses inn og lagres i en liste.

## 2. Be brukeren om en deler, hvilket tall som det skal deles på

Programmet skal be brukeren om å taste inn et tall kalt `deleren`.

Bruk feilhåndtering for å sikre at programmet ikke krasjer ved ugyldige verdier.

Dette inkluderer:
- Brukeren skriver inn noe som ikke er et tall.
- Brukeren forsøker å dele med null.

Ved ugyldige verdier skal programmet gi en passende feilmelding.

## 3. Utfør divisjon

For hvert tall i listen skal programmet:

1. Dele tallet med `deleren`.
2. Skrive ut resultatet.
3. Lagre resultatet i en ny liste.

## 4. Beregn gjennomsnitt

Etter at alle tallene er behandlet, skal programmet beregne og skrive ut gjennomsnittet av resultatene.

**Formel:**

Gjennomsnitt = Summen av alle resultatene / Antall resultater

## 5. Lagre resultatene til fil

Til slutt skal programmet spørre brukeren om de ønsker å lagre resultatene til en tekstfil.

Hvis brukeren svarer `ja`, skal programmet opprette en tekstfil som inneholder:

1. Resultatene fra divisjonene.
2. Gjennomsnittet av alle resultatene.

Hvis brukeren svarer `nei`, skal programmet avsluttes uten å lagre filen.

## Krav til løsningen

- Bruk filbehandling for å lese og skrive filer.
- Bruk `split()` for å dele opp kommaseparerte verdier.
- Bruk en liste for å lagre tallene og en liste for resultatene.
- Bruk løkker for å behandle tallene.
- Bruk `try` og `except` for feilhåndtering.
- Håndter divisjon med null.
- Beregn gjennomsnittet av resultatene.
- La brukeren velge om resultatene skal lagres til fil.