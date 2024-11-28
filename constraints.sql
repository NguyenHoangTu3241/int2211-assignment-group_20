USE academic_administration;

-- Thêm các khóa ngoại

ALTER TABLE class 
    ADD CONSTRAINT FK_class_leader FOREIGN KEY (class_leader_id) REFERENCES student(student_id),
    ADD CONSTRAINT FK_head_teacher FOREIGN KEY (head_teacher_id) REFERENCES teacher(teacher_id);

ALTER TABLE student 
    ADD CONSTRAINT FK_class_id FOREIGN KEY (class_id) REFERENCES class(class_id);

ALTER TABLE teacher 
    ADD CONSTRAINT FK_department_id FOREIGN KEY (department_id) REFERENCES department(department_id);

ALTER TABLE teaching 
    ADD CONSTRAINT FK_subject_id FOREIGN KEY (subject_id) REFERENCES subject(subject_id);

ALTER TABLE subject 
    ADD CONSTRAINT FK_department_id2 FOREIGN KEY (department_id) REFERENCES department(department_id);

ALTER TABLE department 
    ADD CONSTRAINT FK_head_teacher_department FOREIGN KEY (head_teacher_id) REFERENCES teacher(teacher_id);

ALTER TABLE prerequisite 
    ADD CONSTRAINT FK_subject_prerequisite FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
    ADD CONSTRAINT FK_prerequisite_subject FOREIGN KEY (prerequisite_subject_id) REFERENCES subject(subject_id);

ALTER TABLE exam_results 
    ADD CONSTRAINT FK_student_id FOREIGN KEY (student_id) REFERENCES student(student_id),
    ADD CONSTRAINT FK_subject_exam FOREIGN KEY (subject_id) REFERENCES subject(subject_id);


-- Thêm các ràng buộc khác

-- Mã học viên có định dạng 5 ký tự: 3 ký tự đầu là mã lớp, 2 ký tự cuối là số
ALTER TABLE student 
    ADD CONSTRAINT CK_student_id_length CHECK (CHAR_LENGTH(student_id) = 5);

-- Giới tính chỉ có thể là nam hoặc nữ
ALTER TABLE student 
    ADD CONSTRAINT CK_gender_student CHECK (gender IN ('Nam', 'Nu'));

ALTER TABLE teacher 
    ADD CONSTRAINT CK_gender_teacher CHECK (gender IN ('Nam', 'Nu'));

-- Điểm thi có giá trị từ 0 đến 10
ALTER TABLE exam_results 
    ADD CONSTRAINT CK_exam_score CHECK (score BETWEEN 0 AND 10);

-- Kết quả thi phụ thuộc vào điểm
ALTER TABLE exam_results 
    ADD CONSTRAINT CK_exam_result CHECK (
        (score < 5 AND result = 'Khong dat') OR (score BETWEEN 5 AND 10 AND result = 'Dat')
    );

-- Số lần thi không vượt quá 3 lần
ALTER TABLE exam_results 
    ADD CONSTRAINT CK_attempts CHECK (attempt_number <= 3);

-- Học kỳ chỉ nhận các giá trị 1, 2, 3
ALTER TABLE teaching 
    ADD CONSTRAINT CK_semester CHECK (semester IN (1, 2, 3));

-- Học vị giáo viên chỉ nhận giá trị cố định
ALTER TABLE teacher 
    ADD CONSTRAINT CK_academic_degree CHECK (degree IN ('CN', 'KS', 'Ths', 'TS', 'PTS'));

-- Học viên ít nhất là 18 tuổi
ALTER TABLE student ADD CONSTRAINT CK_student_age 
CHECK (2024 - YEAR(birth_date) >= 18);

-- Giảng dạy một môn học ngày bắt đầu (start_date) phải nhỏ hơn ngày kết thúc (end_date)
ALTER TABLE teaching ADD CONSTRAINT CK_teaching_dates 
CHECK (start_date < end_date);

-- Giáo viên khi vào làm ít nhất là 22 tuổi
ALTER TABLE teacher ADD CONSTRAINT CK_teacher_age 
CHECK (YEAR(start_date) - YEAR(birth_date) >= 22);

-- Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3
ALTER TABLE subject ADD CONSTRAINT CK_credit_diff 
CHECK (ABS(theory_credit - practical_credit) <= 3 OR practical_credit = 0);



