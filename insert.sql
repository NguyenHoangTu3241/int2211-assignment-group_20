USE academic_administration;

-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Insert data into the DEPARTMENT table
INSERT INTO department (department_id, department_name, creation_date, head_teacher_id) 
VALUES 
('KHMT','Khoa hoc may tinh','2005-06-07','GV01'),
('HTTT','He thong thong tin','2005-06-07','GV02'),
('CNPM','Cong nghe phan mem','2005-06-07','GV04'),
('MTT','Mang va truyen thong','2005-10-20','GV03'),
('KTMT','Ky thuat may tinh','2005-12-20', null);

-- Insert data into the CLASS table
INSERT INTO class (class_id, class_name, class_leader_id, size, head_teacher_id) 
VALUES 
('C11', 'Lớp 1 khóa 1', 'C1108', 11, 'T07'),
('C12', 'Lớp 2 khóa 1', 'C1205', 12, 'T09'),
('C13', 'Lớp 3 khóa 1', 'C1305', 12, 'T14');

-- Insert data into the SUBJECT table
INSERT INTO subject (subject_id, subject_name, theory_credit, practical_credit, department_id) 
VALUES 
('GENC', 'Tin học đại cương', 4, 1, 'CS'),
('DSA', 'Cấu trúc rời rạc và giải thuật', 5, 0, 'CS'),
('DB', 'Cơ sở dữ liệu', 3, 1, 'IS'),
('DSA_ALG', 'Cấu trúc dữ liệu và giải thuật', 3, 1, 'CS'),
('ADAA', 'Phân tích giải thuật nâng cao', 3, 0, 'CS'),
('CG', 'Đồ họa máy tính', 3, 1, 'CS'),
('COMA', 'Kiến trúc máy tính', 3, 0, 'CE'),
('DBD', 'Thiết kế cơ sở dữ liệu', 3, 1, 'IS'),
('ISAD', 'Phân tích và thiết kế hệ thống', 4, 1, 'IS'),
('OS', 'Hệ điều hành', 4, 0, 'CE'),
('INTSE', 'Nhập môn kỹ thuật phần mềm', 3, 0, 'SE'),
('CWPROG', 'Lập trình C Windows', 3, 1, 'SE'),
('OOP', 'Lập trình hướng đối tượng', 3, 1, 'SE');

-- Insert data into the PREREQUISITE table
INSERT INTO prerequisite (subject_id, prerequisite_subject_id) 
VALUES 
('DB', 'DSA'),
('DB', 'DSA_ALG'),
('DSA_ALG', 'GENC'),
('ADAA', 'GENC'),
('ADAA', 'DSA_ALG'),
('CG', 'GENC'),
('OOP', 'GENC'),
('ISAD', 'DB');

-- Insert data into the TEACHING table
INSERT INTO teaching (class_id, subject_id, teacher_id, semester, year, start_date, end_date) 
VALUES 
('C11', 'GENC', 'T07', 1, 2006, '2006-02-01', '2006-12-05'),
('C12', 'GENC', 'T06', 1, 2006, '2006-02-01', '2006-12-05'),
('C13', 'GENC', 'T15', 1, 2006, '2006-02-01', '2006-12-05'),
('C11', 'DSA', 'T02', 1, 2006, '2006-09-01', '2006-05-17'),
('C12', 'DSA', 'T02', 1, 2006, '2006-09-01', '2006-05-17'),
('C13', 'DSA', 'T08', 1, 2006, '2006-09-01', '2006-05-17'),
('C11', 'DB', 'T05', 2, 2006, '2006-01-06', '2006-07-15'),
('C12', 'DB', 'T09', 2, 2006, '2006-01-06', '2006-07-15'),
('C13', 'DSA_ALG', 'T15', 2, 2006, '2006-01-06', '2006-07-15'),
('C13', 'DB', 'T05', 3, 2006, '2006-01-08', '2006-12-15'),
('C13', 'CG', 'T07', 3, 2006, '2006-01-08', '2006-12-15'),
('C11', 'DSA_ALG', 'T15', 3, 2006, '2006-01-08', '2006-12-15'),
('C12', 'DSA_ALG', 'T15', 3, 2006, '2006-01-08', '2006-12-15'),
('C11', 'OS', 'T04', 1, 2007, '2007-02-01', '2007-02-18'),
('C12', 'OS', 'T04', 1, 2007, '2007-02-01', '2007-03-20'),
('C11', 'CG', 'T07', 1, 2007, '2007-02-18', '2007-03-20');

-- Insert data into the TEACHER table
INSERT INTO teacher (teacher_id, full_name, degree, academic_title, gender, birth_date, hire_date, coefficient_salary, salary, department_id) 
VALUES 
('T01', 'Hồ Thanh Sơn', 'Tiến sĩ', 'Giáo sư', 'Nam', '1950-02-05', '2004-11-01', 5, 2250000, 'CS'),
('T02', 'Trần Tâm Thành', 'Tiến sĩ', 'Phó giáo sư', 'Nam', '1965-12-17', '2004-04-20', 4.5, 2025000, 'IS'),
('T03', 'Nguyễn Văn Dương', 'Tiến sĩ', 'Phó giáo sư', 'Nam', '1970-11-20', '2005-08-01', 4, 1900000, 'NT'),
('T04', 'Lê Quang Trịnh', 'Tiến sĩ', 'Giáo sư', 'Nam', '1965-07-08', '2004-11-01', 5, 2100000, 'SE'),
('T05', 'Nguyễn Thị Bích Hạnh', 'Thạc sĩ', 'Giảng viên', 'Nữ', '1982-03-10', '2005-03-05', 3.2, 1550000, 'IS'),
('T06', 'Nguyễn Văn Quốc', 'Thạc sĩ', 'Giảng viên', 'Nam', '1980-06-01', '2005-03-05', 3.5, 1600000, 'CS'),
('T07', 'Nguyễn Phương Nam', 'Tiến sĩ', 'Phó giáo sư', 'Nam', '1975-08-09', '2004-10-01', 4, 1950000, 'SE'),
('T08', 'Trần Thị Thanh Thúy', 'Thạc sĩ', 'Giảng viên', 'Nữ', '1978-03-05', '2005-09-01', 3.5, 1700000, 'CS'),
('T09', 'Đỗ Đình Duy', 'Thạc sĩ', 'Giảng viên', 'Nam', '1980-01-01', '2005-08-01', 3.5, 1650000, 'IS'),
('T14', 'Trần Văn Minh', 'Thạc sĩ', 'Giảng viên', 'Nam', '1981-07-15', '2005-03-05', 3.4, 1600000, 'SE'),
('T15', 'Nguyễn Hoàng Phương', 'Tiến sĩ', 'Giảng viên', 'Nam', '1985-09-12', '2006-02-01', 3.8, 1850000, 'CS');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
