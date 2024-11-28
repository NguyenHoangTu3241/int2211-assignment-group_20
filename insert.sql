USE academic_administration;

-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

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
('K11','Lop 1 khoa 1','K1108',11,'GV07'),
('K12','Lop 2 khoa 1','K1205',12,'GV09'),
('K13','Lop 3 khoa 1','K1305',12,'GV14');

-- Insert data into the SUBJECT table
INSERT INTO subject (subject_id, subject_name, theory_credit, practical_credit, department_id) 
VALUES 
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 0, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 0, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');

-- Insert data into the PREREQUISITE table
INSERT INTO prerequisite (subject_id, prerequisite_subject_id) 
VALUES 
('CSDL', 'CTRR'),
('CSDL', 'CTDLGT'),
('CTDLGT', 'THDC'),
('PTTKTT', 'THDC'),
('PTTKTT', 'CTDLGT'),
('DHMT', 'THDC'),
('LTHDT', 'THDC'),
('PTTKHTTT', 'CSDL');

-- Insert data into the TEACHER table
INSERT INTO teacher (teacher_id, full_name, degree, academic_title, gender, birth_date, start_date, coefficient_salary, salary, department_id) 
VALUES 
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-02-05', '2004-11-01', 5, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.5, 2025000, 'KHMT'),
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-01-08', '2004-09-23', 4, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-02-22', '2005-12-01', 4.5, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-12-03', '2005-12-01', 3, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-11-03', '2005-12-01', 4.5, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-01-03', 4, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-01-03', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-01-03', 4, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-07-17', '2005-01-03', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-12-01', '2005-05-15', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, 'KTMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1976-11-30', '2005-05-15', 3, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-04-05', '2005-05-15', 3, 1350000, 'KHMT');

-- Insert data into the TEACHING table
INSERT INTO teaching (class_id, subject_id, teacher_id, semester, year, start_date, end_date) 
VALUES 
('K11', 'THDC', 'GV07', 1, 2006, '2006-02-01', '2006-12-05'),
('K12', 'THDC', 'GV06', 1, 2006, '2006-02-01', '2006-12-05'),
('K13', 'THDC', 'GV15', 1, 2006, '2006-02-01', '2006-12-05'),
('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');

-- insert data into STUDENT table 
INSERT INTO student (student_id, last_name, first_name, birth_date, gender, birth_place, class_id, note, average_score, classification)
VALUES
('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11', NULL, NULL, NULL),
('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11', NULL, NULL, NULL),
('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11', NULL, NULL, NULL),
('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11', NULL, NULL, NULL),
('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Nam', 'TpHCM', 'K11', NULL, NULL, NULL),
('K1106', 'Le Nhat', 'Minh', '1986-01-24', 'Nam', 'TpHCM', 'K11', NULL, NULL, NULL),
('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11', NULL, NULL, NULL),
('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11', NULL, NULL, NULL),
('K1109', 'Phan Thi Thanh', 'Tam', '1986-01-27', 'Nu', 'Vinh Long', 'K11', NULL, NULL, NULL),
('K1110', 'Le Hoai', 'Thuong', '1986-05-02', 'Nu', 'Can Tho', 'K11', NULL, NULL, NULL),
('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11', NULL, NULL, NULL),
('K1201', 'Nguyen Van', 'B', '1986-11-02', 'Nam', 'TpHCM', 'K12', NULL, NULL, NULL),
('K1202', 'Nguyen Thi Kim', 'Duyen', '1986-01-18', 'Nu', 'TpHCM', 'K12', NULL, NULL, NULL),
('K1203', 'Tran Thi Kim', 'Duyen', '1986-09-17', 'Nu', 'TpHCM', 'K12', NULL, NULL, NULL),
('K1204', 'Truong My', 'Hanh', '1986-05-19', 'Nu', 'Dong Nai', 'K12', NULL, NULL, NULL),
('K1205', 'Nguyen Thanh', 'Nam', '1986-04-17', 'Nam', 'TpHCM', 'K12', NULL, NULL, NULL),
('K1206', 'Nguyen Thi Truc', 'Thanh', '1986-04-03', 'Nu', 'Kien Giang', 'K12', NULL, NULL, NULL),
('K1207', 'Tran Thi Bich', 'Thuy', '1986-08-02', 'Nu', 'Nghe An', 'K12', NULL, NULL, NULL),
('K1208', 'Huynh Thi Kim', 'Trieu', '1986-08-04', 'Nu', 'Tay Ninh', 'K12', NULL, NULL, NULL),
('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12', NULL, NULL, NULL),
('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12', NULL, NULL, NULL),
('K1211', 'Do Thi', 'Xuan', '1986-09-03', 'Nu', 'Ha Noi', 'K12', NULL, NULL, NULL),
('K1212', 'Le Thi Phi', 'Yen', '1986-12-03', 'Nu', 'TpHCM', 'K12', NULL, NULL, NULL),
('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-09-06', 'Nu', 'Kien Giang', 'K13', NULL, NULL, NULL),
('K1302', 'Truong Thi My', 'Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13', NULL, NULL, NULL),
('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13', NULL, NULL, NULL),
('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13', NULL, NULL, NULL),
('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13', NULL, NULL, NULL),
('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13', NULL, NULL, NULL),
('K1307', 'Tran Minh', 'Man', '1986-05-28', 'Nam', 'TpHCM', 'K13', NULL, NULL, NULL),
('K1308', 'Nguyen Hieu', 'Nghia', '1986-08-04', 'Nam', 'Kien Giang', 'K13', NULL, NULL, NULL),
('K1309', 'Nguyen Trung', 'Nghia', '1987-01-18', 'Nam', 'Nghe An', 'K13', NULL, NULL, NULL),
('K1310', 'Tran Thi Hong', 'Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13', NULL, NULL, NULL),
('K1311', 'Tran Minh', 'Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13', NULL, NULL, NULL),
('K1312', 'Nguyen Thi Kim', 'Yen', '1986-07-09', 'Nu', 'TpHCM', 'K13', NULL, NULL, NULL);

-- insert data into EXAM_RESULTS table
INSERT INTO exam_results (student_id, subject_id, attempt_number, exam_date, score, result)
VALUES
('K1101', 'CSDL', 1, '2006-07-20', 10, 'Dat'),
('K1101', 'CTDLGT', 1, '2006-12-28', 9, 'Dat'),
('K1101', 'THDC', 1, '2006-05-20', 9, 'Dat'),
('K1101', 'CTRR', 1, '2006-05-13', 9.5, 'Dat'),
('K1102', 'CSDL', 1, '2006-07-20', 4, 'Khong Dat'),
('K1102', 'CSDL', 2, '2006-07-27', 4.25, 'Khong Dat'),
('K1102', 'CSDL', 3, '2006-08-10', 4.5, 'Khong Dat'),
('K1102', 'CTDLGT', 1, '2006-12-28', 4.5, 'Khong Dat'),
('K1102', 'CTDLGT', 2, '2007-05-01', 4, 'Khong Dat'),
('K1102', 'CTDLGT', 3, '2007-01-15', 6, 'Dat'),
('K1102', 'THDC', 1, '2006-05-20', 5, 'Dat'),
('K1102', 'CTRR', 1, '2006-05-13', 7, 'Dat'),
('K1103', 'CSDL', 1, '2006-07-20', 3.5, 'Khong Dat'),
('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
('K1103', 'CTDLGT', 1, '2006-12-28', 7, 'Dat'),
('K1103', 'THDC', 1, '2006-05-20', 8, 'Dat'),
('K1103', 'CTRR', 1, '2006-05-13', 6.5, 'Dat'),
('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'Khong Dat'),
('K1104', 'CTDLGT', 1, '2006-12-28', 4, 'Khong Dat'),
('K1104', 'THDC', 1, '2006-05-20', 4, 'Khong Dat'),
('K1104', 'CTRR', 1, '2006-05-13', 4, 'Khong Dat'),
('K1104', 'CTRR', 2, '2006-05-20', 3.5, 'Khong Dat'),
('K1104', 'CTRR', 3, '2006-06-30', 4, 'Khong Dat'),
('K1201', 'CSDL', 1, '2006-07-20', 6, 'Dat'),
('K1201', 'CTDLGT', 1, '2006-12-28', 5, 'Dat'),
('K1201', 'THDC', 1, '2006-05-20', 8.5, 'Dat'),
('K1201', 'CTRR', 1, '2006-05-13', 9, 'Dat'),
('K1202', 'CSDL', 1, '2006-07-20', 8, 'Dat'),
('K1202', 'CTDLGT', 1, '2006-12-28', 4, 'Khong Dat'),
('K1202', 'CTDLGT', 2, '2007-05-01', 5, 'Dat'),
('K1202', 'THDC', 1, '2006-05-20', 4, 'Khong Dat'),
('K1202', 'THDC', 2, '2006-05-27', 4, 'Khong Dat'),
('K1202', 'CTRR', 1, '2006-05-13', 3, 'Khong Dat'),
('K1202', 'CTRR', 2, '2006-05-20', 4, 'Khong Dat'),
('K1202', 'CTRR', 3, '2006-06-30', 6.25, 'Dat'),
('K1203', 'CSDL', 1, '2006-07-20', 9.25, 'Dat'),
('K1203', 'CTDLGT', 1, '2006-12-28', 9.5, 'Dat'),
('K1203', 'THDC', 1, '2006-05-20', 10, 'Dat'),
('K1203', 'CTRR', 1, '2006-05-13', 10, 'Dat'),
('K1204', 'CSDL', 1, '2006-07-20', 8.5, 'Dat'),
('K1204', 'CTDLGT', 1, '2006-12-28', 6.75, 'Dat'),
('K1204', 'THDC', 1, '2006-05-20', 4, 'Khong Dat'),
('K1204', 'CTRR', 1, '2006-05-13', 6, 'Dat'),
('K1301', 'CSDL', 1, '2006-12-20', 4.25, 'Khong Dat'),
('K1301', 'CTDLGT', 1, '2006-07-25', 8, 'Dat'),
('K1301', 'THDC', 1, '2006-05-20', 7.75, 'Dat'),
('K1301', 'CTRR', 1, '2006-05-13', 8, 'Dat'),
('K1302', 'CSDL', 1, '2006-12-20', 6.75, 'Dat'),
('K1302', 'CTDLGT', 1, '2006-07-25', 5, 'Dat'),
('K1302', 'THDC', 1, '2006-05-20', 8, 'Dat'),
('K1302', 'CTRR', 1, '2006-05-13', 8.5, 'Dat'),
('K1303', 'CSDL', 1, '2006-12-20', 4, 'Khong Dat'),
('K1303', 'CTDLGT', 1, '2006-07-25', 4.5, 'Khong Dat'),
('K1303', 'CTDLGT', 2, '2006-07-08', 4, 'Khong Dat'),
('K1303', 'CTDLGT', 3, '2006-08-15', 4.25, 'Khong Dat'),
('K1303', 'THDC', 1, '2006-05-20', 4.5, 'Khong Dat'),
('K1303', 'CTRR', 1, '2006-05-13', 3.25, 'Khong Dat'),
('K1303', 'CTRR', 2, '2006-05-20', 5, 'Dat'),
('K1304', 'CSDL', 1, '2006-12-20', 7.75, 'Dat'),
('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, 'Dat'),
('K1304', 'THDC', 1, '2006-05-20', 5.5, 'Dat'),
('K1304', 'CTRR', 1, '2006-05-13', 5, 'Dat'),
('K1305', 'CSDL', 1, '2006-12-20', 9.25, 'Dat'),
('K1305', 'CTDLGT', 1, '2006-07-25', 10, 'Dat'),
('K1305', 'THDC', 1, '2006-05-20', 8, 'Dat'),
('K1305', 'CTRR', 1, '2006-05-13', 10, 'Dat');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;