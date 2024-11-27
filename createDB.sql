CREATE DATABASE IF NOT EXISTS academic_administration;
USE academic_administration;

----------------------------------------------------------------------------------------------
------------------------ Data Definition Language (DDL) --------------------------------------
----------------------------------------------------------------------------------------------

-- Table: DEPARTMENT
CREATE TABLE IF NOT EXISTS department (
    department_id VARCHAR(4),
    department_name VARCHAR(40),
    creation_date DATE,
    head_teacher_id CHAR(4), -- Teacher ID
    PRIMARY KEY (department_id)
);

-- Table: SUBJECT
CREATE TABLE IF NOT EXISTS subject (
    subject_id VARCHAR(10),
    subject_name VARCHAR(40),
    theory_credit TINYINT,
    practical_credit TINYINT,
    department_id VARCHAR(4),
    PRIMARY KEY (subject_id)
);

-- Table: PREREQUISITE
CREATE TABLE IF NOT EXISTS prerequisite (
    subject_id VARCHAR(10), -- Foreign Key Attribute
    prerequisite_subject_id VARCHAR(10), -- Foreign Key Attribute
    PRIMARY KEY (subject_id, prerequisite_subject_id)
);

-- Table: TEACHER
CREATE TABLE IF NOT EXISTS teacher (
    teacher_id CHAR(4),
    full_name VARCHAR(40),
    degree VARCHAR(10),
    academic_title VARCHAR(10),
    gender VARCHAR(3),
    birth_date DATE,
    hire_date DATE,
    coefficient_salary NUMERIC(4, 2),
    salary DECIMAL(15,2),
    department_id VARCHAR(4),
    PRIMARY KEY (teacher_id)
);

-- Table: CLASS
CREATE TABLE IF NOT EXISTS class (
    class_id CHAR(3),
    class_name VARCHAR(40),
    class_leader_id CHAR(5), -- Student ID
    size TINYINT,
    head_teacher_id CHAR(4), -- Teacher ID
    PRIMARY KEY (class_id)
);

-- Table: STUDENT
CREATE TABLE IF NOT EXISTS student (
    student_id CHAR(5),
    last_name VARCHAR(40),
    first_name VARCHAR(10),
    birth_date DATE,
    gender VARCHAR(3),
    birth_place VARCHAR(40),
    class_id CHAR(3),
    note VARCHAR(100), -- GHICHU: Note or remark
    average_score DECIMAL(4,2), -- DIEMTB: Average Score
    classification VARCHAR(10), -- XEPLOAI: Classification
    PRIMARY KEY (student_id)
);

-- Table: TEACHING
CREATE TABLE IF NOT EXISTS teaching (
    class_id CHAR(3), -- Foreign Key Attribute
    subject_id VARCHAR(10), -- Foreign Key Attribute
    teacher_id CHAR(4),
    semester TINYINT,
    year SMALLINT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (class_id, subject_id)
);

-- Table: EXAM_RESULTS
CREATE TABLE IF NOT EXISTS exam_results (
    student_id CHAR(5), -- Foreign Key Attribute
    subject_id VARCHAR(10), -- Foreign Key Attribute
    attempt_number TINYINT, -- Foreign Key Attribute
    exam_date DATE,
    score NUMERIC(4, 2),
    result VARCHAR(10),
    PRIMARY KEY (student_id, subject_id, attempt_number)
);
