-- Thêm dữ liệu một sinh viên mới
DELIMITER $$
CREATE PROCEDURE ThemSinhVien(
in MSV char(5), 
in Last_Name varchar(40), 
in First_Name varchar(10),
in birthday date,
in sex varchar(3),
in birthplace varchar(40),
in Class_ID char(3),
in Note varchar(100),
in GPA decimal(4,2),
in Classification varchar(10)
)
BEGIN
IF NOT EXISTS (SELECT 1 FROM class WHERE class_id = Class_ID) THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Lớp không tồn tại!';
END IF;

IF GPA < 0 OR GPA > 4 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'GPA không hợp lệ! Giá trị phải nằm trong khoảng 0-4.';
END IF;

INSERT INTO student(student_id, last_name, first_name, birth_date, gender, 
birth_place, class_id, note, average_score, classification)
VALUES(MSV, Last_Name, First_Name, birthday, sex, birthplace, Class_ID, Note, GPA, Classification);
END $$
DELIMITER ;

-- Thêm thông tin một lớp học mới
DELIMITER $$
CREATE PROCEDURE ThemLopHocMoi(
    IN New_Class_ID CHAR(3), 
    IN New_Class_Name VARCHAR(40), 
    IN New_Class_Leader_ID CHAR(5), 
    IN New_Size TINYINT, 
    IN New_Head_Teacher_ID CHAR(4)
)
BEGIN
    -- Kiểm tra trùng lặp mã lớp
    IF EXISTS (SELECT 1 FROM class WHERE class_id = New_Class_ID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã lớp đã tồn tại!';
    END IF;
    
    -- Kiểm tra tồn tại của giáo viên chủ nhiệm
    IF NOT EXISTS (SELECT 1 FROM teacher WHERE teacher_id = New_Head_Teacher_ID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giáo viên chủ nhiệm không tồn tại!';
    END IF;

    -- Kiểm tra kích thước lớp hợp lệ
    IF New_Size < 1 OR New_Size > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sĩ số lớp không hợp lệ!';
    END IF;

    INSERT INTO class (class_id, class_name, class_leader_id, size, head_teacher_id)
    VALUES (New_Class_ID, New_Class_Name, New_Class_Leader_ID, New_Size, New_Head_Teacher_ID);
END $$
DELIMITER ;

-- Tính điểm thi trung bình của một môn học
DELIMITER $$
CREATE PROCEDURE Average_Score_Of_A_Subject(IN ID_of_subject VARCHAR(10))
BEGIN
	-- Kiểm tra môn học có tồn tại không
	IF NOT EXISTS (SELECT 1 FROM subject WHERE subject_id = ID_of_subject) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Môn học không tồn tại!';
	END IF;
	-- Tính điểm trung bình
	SELECT COALESCE(AVG(score), 0) AS average_score -- Trả về 0 nếu không có dữ liệu
	FROM exam_results
	WHERE subject_id = ID_of_subject;
END $$
DELIMITER //

-- Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa
CREATE PROCEDURE sp_update_salary_for_department_heads()
BEGIN
    UPDATE teacher
    SET coefficient_salary = coefficient_salary * 1.2
    WHERE teacher_id IN (SELECT head_teacher_id FROM department);
END //

-- Cập nhật điểm trung bình (average_score) cho mỗi học viên
CREATE PROCEDURE sp_update_average_score_for_students()
BEGIN
    UPDATE student
    SET average_score = (
        SELECT AVG(score)
        FROM exam_results e1
        WHERE student.student_id = e1.student_id
          AND NOT EXISTS (
              SELECT 1
              FROM exam_results e2
              WHERE e1.student_id = e2.student_id 
                AND e1.subject_id = e2.subject_id 
                AND e1.attempt_number < e2.attempt_number
          )
    );
END //

-- Ghi chú "Cam thi" cho học viên thi lần 3 dưới 5 điểm
CREATE PROCEDURE sp_update_ban_examNote()
BEGIN
    UPDATE student
    SET note = 'Cam thi'
    WHERE student_id IN (
        SELECT student_id 
        FROM exam_results
        WHERE attempt_number = 3 AND score < 5
    );
END //

-- Xếp loại học viên dựa trên điểm trung bình
CREATE PROCEDURE sp_update_student_classification()
BEGIN
    UPDATE student
    SET classification = CASE
        WHEN average_score >= 9 THEN 'XS'
        WHEN average_score >= 8 THEN 'G'
        WHEN average_score >= 6.5 THEN 'K'
        WHEN average_score >= 5 THEN 'TB'
        ELSE 'Y'
    END;
END //

DELIMITER ;
