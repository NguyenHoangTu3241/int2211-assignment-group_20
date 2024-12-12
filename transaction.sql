<<<<<<< HEAD
=======
USE academic_administration;

-- update dữ liệu mới
START TRANSACTION;
SET SQL_SAFE_UPDATES = 0;

UPDATE teacher SET degree = 'TS' WHERE teacher_id = 'GV01';
UPDATE student SET birth_place = 'Ninh Binh' WHERE student_id = 'K1111';

ROLLBACK;

-- Thêm môn mới CSTTNT và chèn các dữ liệu liên quan 
START TRANSACTION;

INSERT INTO subject (subject_id, subject_name, theory_credit, practical_credit, department_id) 
VALUES ('CSTTNT', 'Co so tri tue nhan tao', 3, 0, 'KHMT');

INSERT INTO prerequisite (subject_id, prerequisite_subject_id) 
VALUES ('CSTTNT', 'CTDLGT');

INSERT INTO teaching (class_id, subject_id, teacher_id, semester, year, start_date, end_date) 
VALUES ('K12', 'CSTTNT', 'GV04', 1, 2007, '2006-01-08', '2006-12-15');

ROLLBACK;

>>>>>>> 6dd22a6b6a0d76671b24f46c9d24677fd2d10ab9
