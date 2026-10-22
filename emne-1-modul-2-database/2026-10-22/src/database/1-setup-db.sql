DROP DATABASE IF EXISTS school;

CREATE DATABASE school;
USE school;

-- OPPRETTER TABELLER
CREATE TABLE students(
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email varchar(100) NOT NULL UNIQUE,
    study_program VARCHAR(100) NOT NULL,
    start_year INT NOT NULL
);

CREATE TABLE subject(
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    credits INT NOT NULL
);

CREATE TABLE grades(
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    grade CHAR(1) NOT NULL,

    CONSTRAINT fk_grades_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    CONSTRAINT fk_grades_subject
        FOREIGN KEY (subject_id)
        REFERENCES subject(subject_id),

    CONSTRAINT uq_student_subject
        UNIQUE (student_id, subject_id)
);