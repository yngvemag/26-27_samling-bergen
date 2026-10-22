USE school2;

-- ============================================================
-- 1. LEGG INN STUDIEPROGRAMMER
--
-- study_program_id 1 = Backend-utvikling
-- study_program_id 2 = Frontend-utvikling
-- study_program_id 3 = Cybersikkerhet
-- ============================================================

INSERT INTO study_programs (program_name)
VALUES
    ('Backend-utvikling'),
    ('Frontend-utvikling'),
    ('Cybersikkerhet');


-- ============================================================
-- 2. LEGG INN STUDENTER
--
-- study_program_id brukes i stedet for tekst-verdi.
-- ============================================================

-- Backend-utvikling (study_program_id = 1): 9 studenter

INSERT INTO students
    (first_name, last_name, email, study_program_id, start_year)
VALUES
    ('Emma',   'Hansen',    'emma.hansen@example.com',    1, 2026),
    ('Oliver', 'Johansen',  'oliver.johansen@example.com', 1, 2026),
    ('Nora',   'Larsen',    'nora.larsen@example.com',    1, 2026),
    ('Jakob',  'Nilsen',    'jakob.nilsen@example.com',   1, 2026),
    ('Sofie',  'Berg',      'sofie.berg@example.com',     1, 2026),
    ('Magnus', 'Eriksen',   'magnus.eriksen@example.com', 1, 2025),
    ('Ida',    'Andersen',  'ida.andersen@example.com',   1, 2025),
    ('Henrik', 'Olsen',     'henrik.olsen@example.com',   1, 2025),
    ('Thea',   'Pedersen',  'thea.pedersen@example.com',  1, 2025);


-- Frontend-utvikling (study_program_id = 2): 6 studenter

INSERT INTO students
    (first_name, last_name, email, study_program_id, start_year)
VALUES
    ('Lucas',   'Kristiansen', 'lucas.kristiansen@example.com', 2, 2026),
    ('Sara',    'Moen',        'sara.moen@example.com',         2, 2026),
    ('Emil',    'Solberg',     'emil.solberg@example.com',      2, 2026),
    ('Ingrid',  'Dahl',        'ingrid.dahl@example.com',       2, 2025),
    ('Mathias', 'Lunde',       'mathias.lunde@example.com',     2, 2025),
    ('Amalie',  'Strand',      'amalie.strand@example.com',     2, 2025);


-- Cybersikkerhet (study_program_id = 3): 5 studenter

INSERT INTO students
    (first_name, last_name, email, study_program_id, start_year)
VALUES
    ('William', 'Lie',     'william.lie@example.com',   3, 2026),
    ('Maja',    'Knutsen', 'maja.knutsen@example.com',  3, 2026),
    ('Noah',    'Eide',    'noah.eide@example.com',     3, 2026),
    ('Ella',    'Haugen',  'ella.haugen@example.com',   3, 2025),
    ('Aksel',   'Bakke',   'aksel.bakke@example.com',   3, 2025);


-- ============================================================
-- 3. LEGG INN EMNER
-- ============================================================

INSERT INTO subjects
    (subject_name, credits)
VALUES
    ('Databaser', 10),
    ('Objektorientert programmering', 10),
    ('Backend-utvikling', 15),
    ('Frontend-utvikling', 15),
    ('Cybersikkerhet', 10),
    ('Cloud og containere', 10);


-- ============================================================
-- 4. LEGG INN KARAKTERER
-- ============================================================

-- Databaser (subject_id = 1)

INSERT INTO grades (student_id, subject_id, grade)
VALUES
    (1, 1, 'A'),
    (2, 1, 'B'),
    (3, 1, 'C'),
    (4, 1, 'B'),
    (5, 1, 'A'),
    (6, 1, 'C'),
    (7, 1, 'B'),
    (8, 1, 'D'),
    (9, 1, 'C'),

    (10, 1, 'B'),
    (11, 1, 'C'),
    (12, 1, 'D'),
    (13, 1, 'B'),
    (14, 1, 'C'),
    (15, 1, 'E'),

    (16, 1, 'A'),
    (17, 1, 'B'),
    (18, 1, 'B'),
    (19, 1, 'C'),
    (20, 1, 'A');


-- Objektorientert programmering (subject_id = 2)

INSERT INTO grades (student_id, subject_id, grade)
VALUES
    (1, 2, 'B'),
    (2, 2, 'A'),
    (3, 2, 'B'),
    (4, 2, 'C'),
    (5, 2, 'B'),
    (6, 2, 'D'),
    (7, 2, 'C'),
    (8, 2, 'C'),
    (9, 2, 'F'),

    (10, 2, 'C'),
    (11, 2, 'B'),
    (12, 2, 'C'),
    (13, 2, 'D'),
    (14, 2, 'B'),
    (15, 2, 'C');


-- Backend-utvikling (subject_id = 3) – bare Backend-studenter

INSERT INTO grades (student_id, subject_id, grade)
VALUES
    (1, 3, 'A'),
    (2, 3, 'B'),
    (3, 3, 'B'),
    (4, 3, 'C'),
    (5, 3, 'A'),
    (6, 3, 'C'),
    (7, 3, 'B'),
    (8, 3, 'D'),
    (9, 3, 'C');


-- Frontend-utvikling (subject_id = 4) – bare Frontend-studenter

INSERT INTO grades (student_id, subject_id, grade)
VALUES
    (10, 4, 'A'),
    (11, 4, 'B'),
    (12, 4, 'C'),
    (13, 4, 'A'),
    (14, 4, 'B'),
    (15, 4, 'D');


-- Cybersikkerhet (subject_id = 5) – bare Cybersikkerhet-studenter

INSERT INTO grades (student_id, subject_id, grade)
VALUES
    (16, 5, 'A'),
    (17, 5, 'B'),
    (18, 5, 'C'),
    (19, 5, 'B'),
    (20, 5, 'A');


-- Cloud og containere (subject_id = 6) – blanding, ikke alle har karakter

INSERT INTO grades (student_id, subject_id, grade)
VALUES
    (1,  6, 'B'),
    (2,  6, 'C'),
    (3,  6, 'A'),
    (4,  6, 'B'),
    (6,  6, 'C'),
    (7,  6, 'B'),
    (8,  6, 'D'),

    (16, 6, 'A'),
    (17, 6, 'B'),
    (18, 6, 'C'),
    (19, 6, 'B');
