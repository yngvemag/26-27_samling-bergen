-- LØSNINGSFORSLAG – OPPGAVE 3 OG 4
-- Database: school (normalisert versjon med study_programs-tabell)
-- ============================================================

USE school;

-- ============================================================
-- OPPGAVE 3 – SELECT OG UTFORSKING AV DATA
--
-- Merk: study_program hentes nå via JOIN med study_programs,
-- ikke direkte fra students-tabellen.
-- ============================================================

-- 1. Studentoversikt
SELECT s.first_name, s.last_name, sp.program_name AS study_program, s.start_year
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
ORDER BY s.last_name;


-- 2. Backend-studenter
SELECT s.first_name, s.last_name, s.start_year
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE sp.program_name = 'Backend-utvikling';


-- 3. Studenter fra 2026
SELECT s.first_name, s.last_name, sp.program_name AS study_program, s.start_year
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE s.start_year = 2026
ORDER BY sp.program_name, s.last_name;


-- 4. Utvalgte studier
SELECT s.first_name, s.last_name, sp.program_name AS study_program
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE sp.program_name IN ('Frontend-utvikling', 'Cybersikkerhet')
ORDER BY sp.program_name, s.last_name;


-- 5. Antall studenter per studie
SELECT
    sp.program_name AS study_program,
    COUNT(*) AS number_of_students
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
GROUP BY sp.study_program_id, sp.program_name
ORDER BY number_of_students DESC;


-- 6. Karakterfordeling
SELECT
    grade,
    COUNT(*) AS number_of_grades
FROM grades
GROUP BY grade
ORDER BY grade;


-- 7. Studier med mange studenter
SELECT
    sp.program_name AS study_program,
    COUNT(*) AS number_of_students
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
GROUP BY sp.study_program_id, sp.program_name
HAVING COUNT(*) > 5
ORDER BY number_of_students DESC;


-- 8. Student og karakter
SELECT
    s.first_name,
    s.last_name,
    g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id
ORDER BY s.last_name;


-- 9. Full karakteroversikt
SELECT
    s.first_name,
    s.last_name,
    sp.program_name AS study_program,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s      ON g.student_id  = s.student_id
JOIN subjects sub    ON g.subject_id  = sub.subject_id
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
ORDER BY s.last_name, sub.subject_name;


-- 10. Karakterer i Databaser
SELECT
    s.first_name,
    s.last_name,
    sp.program_name AS study_program,
    g.grade
FROM grades g
JOIN students s      ON g.student_id  = s.student_id
JOIN subjects sub    ON g.subject_id  = sub.subject_id
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE sub.subject_name = 'Databaser'
ORDER BY g.grade;


-- 11. A-karakterer
SELECT
    s.first_name,
    s.last_name,
    sp.program_name AS study_program,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s      ON g.student_id  = s.student_id
JOIN subjects sub    ON g.subject_id  = sub.subject_id
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE g.grade = 'A'
ORDER BY s.last_name;


-- 12. Ikke bestått
SELECT
    s.first_name,
    s.last_name,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s   ON g.student_id = s.student_id
JOIN subjects sub ON g.subject_id = sub.subject_id
WHERE g.grade = 'F';


-- 13. Antall karakterer per emne
SELECT
    sub.subject_name,
    COUNT(*) AS number_of_grades
FROM grades g
JOIN subjects sub ON g.subject_id = sub.subject_id
GROUP BY sub.subject_id, sub.subject_name
ORDER BY number_of_grades DESC;


-- 14. Karakterfordeling i Databaser
SELECT
    g.grade,
    COUNT(*) AS number_of_grades
FROM grades g
JOIN subjects sub ON g.subject_id = sub.subject_id
WHERE sub.subject_name = 'Databaser'
GROUP BY g.grade
ORDER BY g.grade;


-- 15. Antall A per emne
SELECT
    sub.subject_name,
    COUNT(*) AS number_of_a
FROM grades g
JOIN subjects sub ON g.subject_id = sub.subject_id
WHERE g.grade = 'A'
GROUP BY sub.subject_id, sub.subject_name
ORDER BY number_of_a DESC;


-- 16. Karakterfordeling per studie
SELECT
    sp.program_name AS study_program,
    g.grade,
    COUNT(*) AS number_of_grades
FROM students s
JOIN grades g        ON s.student_id       = g.student_id
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
GROUP BY sp.study_program_id, sp.program_name, g.grade
ORDER BY sp.program_name, g.grade;


-- 17. Utforskingsoppgave – emnet med flest A-karakterer
SELECT
    sub.subject_name,
    COUNT(*) AS number_of_a
FROM grades g
JOIN subjects sub ON g.subject_id = sub.subject_id
WHERE g.grade = 'A'
GROUP BY sub.subject_id, sub.subject_name
ORDER BY number_of_a DESC
LIMIT 1;


-- 18. Studenter uten karakter i Cloud og containere
SELECT
    s.first_name,
    s.last_name,
    sp.program_name AS study_program
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
LEFT JOIN grades g
    ON s.student_id = g.student_id
    AND g.subject_id = (
        SELECT subject_id
        FROM subjects
        WHERE subject_name = 'Cloud og containere'
    )
WHERE g.grade_id IS NULL
ORDER BY s.last_name;


-- 19. Alle studenter og eventuell Cloud-karakter
SELECT
    s.first_name,
    s.last_name,
    g.grade
FROM grades g
RIGHT JOIN students s
    ON g.student_id = s.student_id
    AND g.subject_id = (
        SELECT subject_id
        FROM subjects
        WHERE subject_name = 'Cloud og containere'
    )
ORDER BY s.last_name;


-- ============================================================
-- OPPGAVE 4 – INSERT, UPDATE OG DELETE
-- ============================================================

-- 1. Registrer en ny student
--
-- study_program_id 1 = Backend-utvikling
INSERT INTO students
    (first_name, last_name, email, study_program_id, start_year)
VALUES
    ('Maria', 'Holm', 'maria.holm@example.com', 1, 2026);

-- Kontroller
SELECT s.*, sp.program_name
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE s.email = 'maria.holm@example.com';


-- 2. Registrer et nytt emne
INSERT INTO subjects
    (subject_name, credits)
VALUES
    ('Web API', 10);

-- Kontroller
SELECT * FROM subjects WHERE subject_name = 'Web API';


-- 3. Registrer en karakter

-- Finn student_id
SELECT student_id, first_name, last_name
FROM students
WHERE email = 'maria.holm@example.com';

-- Finn subject_id
SELECT subject_id, subject_name
FROM subjects
WHERE subject_name = 'Web API';

-- Registrer karakteren.
-- Dersom databasen er kjørt fra start uten andre endringer,
-- vil Maria normalt ha student_id = 21 og Web API subject_id = 7.
INSERT INTO grades (student_id, subject_id, grade)
VALUES (21, 7, 'B');

-- Kontroller
SELECT
    s.first_name,
    s.last_name,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s   ON g.student_id = s.student_id
JOIN subjects sub ON g.subject_id = sub.subject_id
WHERE s.email = 'maria.holm@example.com'
  AND sub.subject_name = 'Web API';


-- 4. Endre startår

-- Kontroller før UPDATE
SELECT * FROM students WHERE email = 'maria.holm@example.com';

UPDATE students
SET start_year = 2025
WHERE email = 'maria.holm@example.com';

-- Kontroller etter UPDATE
SELECT * FROM students WHERE email = 'maria.holm@example.com';


-- 5. Endre studiepoeng

-- Kontroller før UPDATE
SELECT * FROM subjects WHERE subject_name = 'Cloud og containere';

UPDATE subjects
SET credits = 15
WHERE subject_name = 'Cloud og containere';

-- Kontroller etter UPDATE
SELECT * FROM subjects WHERE subject_name = 'Cloud og containere';


-- 6. Endre studieprogram for Frontend-studenter fra 2025
--
-- I den normaliserte versjonen finnes det to måter:
--
-- ALTERNATIV A – Oppdater selve programnavnet i study_programs.
-- Dette endrer programnavnet for ALLE studenter på det programmet.
--
--   UPDATE study_programs
--   SET program_name = 'Frontend- og webutvikling'
--   WHERE program_name = 'Frontend-utvikling';
--
-- ALTERNATIV B – Opprett et nytt program og flytt bare 2025-studentene.
-- Dette beholder det opprinnelige programmet for 2026-studenter.

-- Steg 1: Opprett nytt program
INSERT INTO study_programs (program_name)
VALUES ('Frontend- og webutvikling');

-- Steg 2: Finn ID-en til det nye programmet
SELECT study_program_id FROM study_programs
WHERE program_name = 'Frontend- og webutvikling';

-- Steg 3: Flytt 2025-studentene (anta at nytt ID = 4)
-- Kontroller før UPDATE
SELECT s.*, sp.program_name
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE sp.program_name = 'Frontend-utvikling'
  AND s.start_year = 2025;

UPDATE students
SET study_program_id = 4
WHERE study_program_id = 2
  AND start_year = 2025;

-- Kontroller etter UPDATE
SELECT s.*, sp.program_name
FROM students s
JOIN study_programs sp ON s.study_program_id = sp.study_program_id
WHERE sp.program_name = 'Frontend- og webutvikling';


-- 7. Opprett og slett testdata

INSERT INTO students
    (first_name, last_name, email, study_program_id, start_year)
VALUES
    ('Test', 'Testesen', 'test@example.com', 1, 2026);

-- Kontroller
SELECT * FROM students WHERE email = 'test@example.com';

DELETE FROM students WHERE email = 'test@example.com';

-- Kontroller etter DELETE
SELECT * FROM students WHERE email = 'test@example.com';


-- 8. Test fremmednøkkel

INSERT INTO students
    (first_name, last_name, email, study_program_id, start_year)
VALUES
    ('Test', 'Student', 'test.student@example.com', 1, 2026);

-- Finn student_id
SELECT student_id FROM students WHERE email = 'test.student@example.com';

-- Registrer en karakter i Databaser (bytt <student_id> med riktig ID):
-- INSERT INTO grades (student_id, subject_id, grade) VALUES (<student_id>, 1, 'C');

-- Kontroller studenten
SELECT * FROM students WHERE email = 'test.student@example.com';

-- Denne DELETE-setningen skal gi feil fordi studenten har en karakter:
--
-- DELETE FROM students WHERE email = 'test.student@example.com';


-- 9. Slett relaterte data

-- Finn studenten
SELECT student_id FROM students WHERE email = 'test.student@example.com';

-- Kontroller karakterene
SELECT g.*
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE s.email = 'test.student@example.com';

-- Slett karakterene først
DELETE g
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE s.email = 'test.student@example.com';

-- Kontroller studenten
SELECT * FROM students WHERE email = 'test.student@example.com';

-- Slett studenten
DELETE FROM students WHERE email = 'test.student@example.com';

-- Kontroller at studenten er slettet
SELECT * FROM students WHERE email = 'test.student@example.com';
