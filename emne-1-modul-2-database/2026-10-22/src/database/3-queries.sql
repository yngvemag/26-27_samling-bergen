-- LØSNINGSFORSLAG – OPPGAVE 3 OG 4
-- Database: school
-- ============================================================

USE school;

-- ============================================================
-- OPPGAVE 3 – SELECT OG UTFORSKING AV DATA
-- ============================================================

-- 1. Studentoversikt
SELECT first_name, last_name, study_program, start_year
FROM students
ORDER BY last_name;


-- 2. Backend-studenter
SELECT first_name, last_name, start_year
FROM students
WHERE study_program = 'Backend-programmering';


-- 3. Studenter fra 2026
SELECT first_name, last_name, study_program, start_year
FROM students
WHERE start_year = 2026
ORDER BY study_program, last_name;


-- 4. Utvalgte studier
SELECT first_name, last_name, study_program
FROM students
WHERE study_program IN ('Frontend-utvikling', 'Cybersikkerhet')
ORDER BY study_program, last_name;


-- 5. Antall studenter per studie
SELECT
    study_program,
    COUNT(*) AS number_of_students
FROM students
GROUP BY study_program
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
    study_program,
    COUNT(*) AS number_of_students
FROM students
GROUP BY study_program
HAVING COUNT(*) > 5
ORDER BY number_of_students DESC;


-- 8. Student og karakter
SELECT
    s.first_name,
    s.last_name,
    g.grade
FROM students s
JOIN grades g
    ON s.student_id = g.student_id
ORDER BY s.last_name;


-- 9. Full karakteroversikt
SELECT
    s.first_name,
    s.last_name,
    s.study_program,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s
    ON g.student_id = s.student_id
JOIN subjects sub
    ON g.subject_id = sub.subject_id
ORDER BY s.last_name, sub.subject_name;


-- 10. Karakterer i Databaser
SELECT
    s.first_name,
    s.last_name,
    s.study_program,
    g.grade
FROM grades g
JOIN students s
    ON g.student_id = s.student_id
JOIN subjects sub
    ON g.subject_id = sub.subject_id
WHERE sub.subject_name = 'Databaser'
ORDER BY g.grade;


-- 11. A-karakterer
SELECT
    s.first_name,
    s.last_name,
    s.study_program,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s
    ON g.student_id = s.student_id
JOIN subjects sub
    ON g.subject_id = sub.subject_id
WHERE g.grade = 'A'
ORDER BY s.last_name;


-- 12. Ikke bestått
SELECT
    s.first_name,
    s.last_name,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s
    ON g.student_id = s.student_id
JOIN subjects sub
    ON g.subject_id = sub.subject_id
WHERE g.grade = 'F';


-- 13. Antall karakterer per emne
SELECT
    sub.subject_name,
    COUNT(*) AS number_of_grades
FROM grades g
JOIN subjects sub
    ON g.subject_id = sub.subject_id
GROUP BY sub.subject_id, sub.subject_name
ORDER BY number_of_grades DESC;


-- 14. Karakterfordeling i Databaser
SELECT
    g.grade,
    COUNT(*) AS number_of_grades
FROM grades g
JOIN subjects sub
    ON g.subject_id = sub.subject_id
WHERE sub.subject_name = 'Databaser'
GROUP BY g.grade
ORDER BY g.grade;


-- 15. Antall A per emne
SELECT
    sub.subject_name,
    COUNT(*) AS number_of_a
FROM grades g
JOIN subjects sub
    ON g.subject_id = sub.subject_id
WHERE g.grade = 'A'
GROUP BY sub.subject_id, sub.subject_name
ORDER BY number_of_a DESC;


-- 16. Karakterfordeling per studie
SELECT
    s.study_program,
    g.grade,
    COUNT(*) AS number_of_grades
FROM students s
JOIN grades g
    ON s.student_id = g.student_id
GROUP BY s.study_program, g.grade
ORDER BY s.study_program, g.grade;


-- 17. Utforskingsoppgave – emnet med flest A-karakterer
SELECT
    sub.subject_name,
    COUNT(*) AS number_of_a
FROM grades g
JOIN subjects sub
    ON g.subject_id = sub.subject_id
WHERE g.grade = 'A'
GROUP BY sub.subject_id, sub.subject_name
ORDER BY number_of_a DESC
LIMIT 1;


-- 18. Studenter uten karakter i Cloud og containere
SELECT
    s.first_name,
    s.last_name,
    s.study_program
FROM students s
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
INSERT INTO students
    (first_name, last_name, email, study_program, start_year)
VALUES
    ('Maria', 'Holm', 'maria.holm@example.com',
     'Backend-programmering', 2026);

-- Kontroller
SELECT *
FROM students
WHERE email = 'maria.holm@example.com';


-- 2. Registrer et nytt emne
INSERT INTO subjects
    (subject_name, credits)
VALUES
    ('Web API', 10);

-- Kontroller
SELECT *
FROM subjects
WHERE subject_name = 'Web API';


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
-- Kontroller ID-ene med SELECT-spørringene over før INSERT.
INSERT INTO grades
    (student_id, subject_id, grade)
VALUES
    (21, 7, 'B');

-- Kontroller
SELECT
    s.first_name,
    s.last_name,
    sub.subject_name,
    g.grade
FROM grades g
JOIN students s
    ON g.student_id = s.student_id
JOIN subjects sub
    ON g.subject_id = sub.subject_id
WHERE s.email = 'maria.holm@example.com'
  AND sub.subject_name = 'Web API';


-- 4. Endre startår

-- Kontroller før UPDATE
SELECT *
FROM students
WHERE email = 'maria.holm@example.com';

UPDATE students
SET start_year = 2025
WHERE email = 'maria.holm@example.com';

-- Kontroller etter UPDATE
SELECT *
FROM students
WHERE email = 'maria.holm@example.com';


-- 5. Endre studiepoeng

-- Kontroller før UPDATE
SELECT *
FROM subjects
WHERE subject_name = 'Cloud og containere';

UPDATE subjects
SET credits = 15
WHERE subject_name = 'Cloud og containere';

-- Kontroller etter UPDATE
SELECT *
FROM subjects
WHERE subject_name = 'Cloud og containere';


-- 6. Endre flere studenter

-- Kontroller før UPDATE
SELECT *
FROM students
WHERE study_program = 'Frontend-utvikling'
  AND start_year = 2025;

UPDATE students
SET study_program = 'Frontend- og webutvikling'
WHERE study_program = 'Frontend-utvikling'
  AND start_year = 2025;

-- Kontroller etter UPDATE
SELECT *
FROM students
WHERE study_program = 'Frontend- og webutvikling';


-- 7. Opprett og slett testdata

INSERT INTO students
    (first_name, last_name, email, study_program, start_year)
VALUES
    ('Test', 'Testesen', 'test@example.com',
     'Backend-programmering', 2026);

-- Kontroller
SELECT *
FROM students
WHERE email = 'test@example.com';

-- Kontroller før DELETE
SELECT *
FROM students
WHERE email = 'test@example.com';

DELETE FROM students
WHERE email = 'test@example.com';

-- Kontroller etter DELETE
SELECT *
FROM students
WHERE email = 'test@example.com';


-- 8. Test fremmednøkkel

INSERT INTO students
    (first_name, last_name, email, study_program, start_year)
VALUES
    ('Test', 'Student', 'test.student@example.com',
     'Backend-programmering', 2026);

-- Finn student_id
SELECT student_id
FROM students
WHERE email = 'test.student@example.com';

-- Registrer en karakter i Databaser.
-- Bytt <student_id> med ID-en fra SELECT-spørringen over.
-- Eksempel:
-- INSERT INTO grades (student_id, subject_id, grade)
-- VALUES (22, 1, 'C');

-- Kontroller studenten før sletting
SELECT *
FROM students
WHERE email = 'test.student@example.com';

-- Denne DELETE-setningen skal gi feil når studenten har
-- en karakter registrert i grades:
--
-- DELETE FROM students
-- WHERE email = 'test.student@example.com';


-- 9. Slett relaterte data

-- Finn studenten
SELECT student_id
FROM students
WHERE email = 'test.student@example.com';

-- Kontroller karakterene
SELECT g.*
FROM grades g
JOIN students s
    ON g.student_id = s.student_id
WHERE s.email = 'test.student@example.com';

-- Slett karakterene først
DELETE g
FROM grades g
JOIN students s
    ON g.student_id = s.student_id
WHERE s.email = 'test.student@example.com';

-- Kontroller studenten før DELETE
SELECT *
FROM students
WHERE email = 'test.student@example.com';

-- Slett studenten
DELETE FROM students
WHERE email = 'test.student@example.com';

-- Kontroller at studenten er slettet
SELECT *
FROM students