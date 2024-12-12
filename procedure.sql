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
