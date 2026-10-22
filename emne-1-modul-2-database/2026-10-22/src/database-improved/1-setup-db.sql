-- ============================================================
-- 1. OPPRETT DATABASE
-- ============================================================

DROP DATABASE IF EXISTS school2;

CREATE DATABASE school2;
USE school2;

-- ============================================================
-- 2. OPPRETT TABELL: study_programs
--
-- Normalisering: study_program var en tekst-kolonne i students.
-- Det betyr at samme programnavn ble lagret mange ganger.
-- Vi trekker det ut til en egen tabell og bruker en fremmednøkkel.
-- ============================================================

CREATE TABLE study_programs (
    study_program_id INT AUTO_INCREMENT PRIMARY KEY,
    program_name     VARCHAR(100) NOT NULL UNIQUE
);

-- ============================================================
-- 3. OPPRETT TABELL: students
--
-- study_program er nå erstattet med study_program_id (FK).
-- ============================================================

CREATE TABLE students (
    student_id       INT AUTO_INCREMENT PRIMARY KEY,
    first_name       VARCHAR(50)  NOT NULL,
    last_name        VARCHAR(50)  NOT NULL,
    email            VARCHAR(100) NOT NULL UNIQUE,
    study_program_id INT          NOT NULL,
    start_year       INT          NOT NULL,

    CONSTRAINT fk_students_study_program
        FOREIGN KEY (study_program_id)
        REFERENCES study_programs(study_program_id)
);

-- ============================================================
-- 4. OPPRETT TABELL: subjects
-- ============================================================

CREATE TABLE subjects (
    subject_id   INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    credits      INT NOT NULL
);

-- ============================================================
-- 5. OPPRETT TABELL: grades
-- ============================================================

CREATE TABLE grades (
    grade_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT    NOT NULL,
    subject_id INT    NOT NULL,
    grade      CHAR(1) NOT NULL,

    CONSTRAINT fk_grades_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    CONSTRAINT fk_grades_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id),

    CONSTRAINT uq_student_subject
        UNIQUE (student_id, subject_id)
);
