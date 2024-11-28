USE academic_administration;

-- Lớp trưởng của một lớp phải là học viên của lớp đó

DELIMITER $$

CREATE TRIGGER trg_insert_class_leader
BEFORE INSERT ON class
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) 
        FROM student 
        WHERE student.student_id = NEW.class_leader_id 
          AND student.class_id != NEW.class_id) > 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Lớp trưởng của một lớp phải là học viên của lớp đó';
    END IF;
END$$

CREATE TRIGGER trg_update_class_leader
BEFORE UPDATE ON class
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) 
        FROM student 
        WHERE student.student_id = NEW.class_leader_id 
          AND student.class_id != NEW.class_id) > 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Lớp trưởng của một lớp phải là học viên của lớp đó';
    END IF;
END$$

DELIMITER ;

-- Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”

DELIMITER $$

CREATE TRIGGER trg_update_department_head
BEFORE UPDATE ON department
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) 
        FROM teacher 
        WHERE teacher.teacher_id = NEW.head_teacher_id 
          AND (teacher.degree NOT IN ('TS', 'PTS') 
            OR teacher.department_id != NEW.department_id)) > 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”';
    END IF;
END$$

DELIMITER ;

-- Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này
-- drop trigger trg_insert_exam;
DELIMITER $$

CREATE TRIGGER trg_insert_exam
BEFORE INSERT ON exam_results
FOR EACH ROW
BEGIN
    IF (NEW.subject_id NOT IN (
            SELECT subject_id 
            FROM teaching 
            WHERE teaching.class_id = (SELECT class_id FROM student WHERE student.student_id = NEW.student_id)
        ) 
        OR NEW.exam_date < (SELECT end_date 
                            FROM teaching 
                            WHERE teaching.subject_id = NEW.subject_id 
                              AND teaching.class_id = (SELECT class_id FROM student WHERE student.student_id = NEW.student_id))) THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này';
    END IF;
END$$

DELIMITER ;

-- Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn

DELIMITER $$

CREATE TRIGGER trg_insert_subject_limit
BEFORE INSERT ON teaching
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(subject_id) 
        FROM teaching 
        WHERE semester = NEW.semester 
          AND year = NEW.year 
          AND class_id = NEW.class_id) >= 3 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn';
    END IF;
END$$

CREATE TRIGGER trg_update_subject_limit
BEFORE UPDATE ON teaching
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(subject_id) 
        FROM teaching 
        WHERE semester = NEW.semester 
          AND year = NEW.year 
          AND class_id = NEW.class_id) >= 3 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn';
    END IF;
END$$

DELIMITER ;

-- Sĩ số của một lớp bằng với số lượng học viên thuộc lớp đó

DELIMITER $$

CREATE TRIGGER trg_insert_class_size 
AFTER INSERT ON student
FOR EACH ROW
BEGIN
    UPDATE class
    SET size = (
        SELECT COUNT(*) 
        FROM student
        WHERE student.class_id = class.class_id
    );
END$$

CREATE TRIGGER trg_update_class_size 
AFTER UPDATE ON student
FOR EACH ROW
BEGIN
    UPDATE class
    SET size = (
        SELECT COUNT(*) 
        FROM student
        WHERE student.class_id = class.class_id
    );
END$$

CREATE TRIGGER trg_delete_class_size 
AFTER DELETE ON student
FOR EACH ROW
BEGIN
    UPDATE class
    SET size = (
        SELECT COUNT(*) 
        FROM student
        WHERE student.class_id = class.class_id
    );
END$$

DELIMITER ;

-- Trong quan hệ PREREQUISITE giá trị của thuộc tính SUBJECT_ID và PREREQUISITE_SUBJECT_ID trong cùng một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”)
DELIMITER $$

CREATE TRIGGER trg_insert_prerequisite 
BEFORE INSERT ON prerequisite
FOR EACH ROW
BEGIN
    IF NEW.subject_id = NEW.prerequisite_subject_id THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Môn học và môn học điều kiện không được giống nhau.';
    END IF;

    IF EXISTS (
        SELECT 1 
        FROM prerequisite 
        WHERE subject_id = NEW.prerequisite_subject_id 
          AND prerequisite_subject_id = NEW.subject_id
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không được tồn tại cặp môn điều kiện ngược.';
    END IF;
END$$

CREATE TRIGGER trg_update_prerequisite 
BEFORE UPDATE ON prerequisite
FOR EACH ROW
BEGIN
    IF NEW.subject_id = NEW.prerequisite_subject_id THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Môn học và môn học điều kiện không được giống nhau.';
    END IF;

    IF EXISTS (
        SELECT 1 
        FROM prerequisite 
        WHERE subject_id = NEW.prerequisite_subject_id 
          AND prerequisite_subject_id = NEW.subject_id
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không được tồn tại cặp môn điều kiện ngược.';
    END IF;
END$$

DELIMITER ;

-- Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau

DELIMITER $$

CREATE TRIGGER trg_insert_teacher_salary 
BEFORE INSERT ON teacher
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM teacher
        WHERE degree = NEW.degree
          AND academic_title = NEW.academic_title
          AND coefficient_salary = NEW.coefficient_salary
          AND salary != NEW.salary
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Giáo viên cùng học vị, học hàm, hệ số lương phải có mức lương bằng nhau.';
    END IF;
END$$

CREATE TRIGGER trg_update_teacher_salary 
BEFORE UPDATE ON teacher
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM teacher
        WHERE degree = NEW.degree
          AND academic_title = NEW.academic_title
          AND coefficient_salary = NEW.coefficient_salary
          AND salary != NEW.salary
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Giáo viên cùng học vị, học hàm, hệ số lương phải có mức lương bằng nhau.';
    END IF;
END$$

DELIMITER ;

-- Học viên chỉ được thi lại (lần thi > 1) khi điểm của lần thi trước đó dưới 5

DELIMITER $$

CREATE TRIGGER trg_insert_exam_score 
BEFORE INSERT ON exam_results 
FOR EACH ROW
BEGIN
    IF NEW.attempt_number > 1 THEN
        IF NOT EXISTS (
            SELECT 1 
            FROM exam_results 
            WHERE student_id = NEW.student_id 
              AND subject_id = NEW.subject_id 
              AND attempt_number = NEW.attempt_number - 1 
              AND score < 5
        ) THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Học viên chỉ được thi lại khi điểm thi trước đó dưới 5.';
        END IF;
    END IF;
END$$
CREATE TRIGGER trg_update_exam_score 
BEFORE UPDATE ON exam_results
FOR EACH ROW
BEGIN
    IF NEW.attempt_number > 1 THEN
        IF NOT EXISTS (
            SELECT 1 
            FROM exam_results 
            WHERE student_id = NEW.student_id 
              AND subject_id = NEW.subject_id 
              AND attempt_number = NEW.attempt_number - 1 
              AND score < 5
        ) THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Học viên chỉ được thi lại khi điểm thi trước đó dưới 5.';
        END IF;
    END IF;
END$$

DELIMITER ;

-- Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước

DELIMITER $$

CREATE TRIGGER trg_insert_exam_date 
BEFORE INSERT ON exam_results 
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM exam_results 
        WHERE student_id = NEW.student_id 
          AND subject_id = NEW.subject_id 
          AND attempt_number < NEW.attempt_number 
          AND exam_date >= NEW.exam_date
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước.';
    END IF;
END$$

CREATE TRIGGER trg_update_exam_date 
BEFORE UPDATE ON exam_results
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM exam_results 
        WHERE student_id = NEW.student_id 
          AND subject_id = NEW.subject_id 
          AND attempt_number < NEW.attempt_number 
          AND exam_date >= NEW.exam_date
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước.';
    END IF;
END$$

DELIMITER ;

-- Học viên chỉ được thi môn lớp đã học xong

DELIMITER $$

CREATE TRIGGER trg_insert_class_completion 
BEFORE INSERT ON exam_results 
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM teaching 
        WHERE teaching.class_id = (SELECT class_id FROM student WHERE student.student_id = NEW.student_id)
          AND teaching.subject_id = NEW.subject_id 
          AND teaching.end_date < NEW.exam_date
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Học viên chỉ được thi môn học mà lớp đã học xong.';
    END IF;
END$$

CREATE TRIGGER trg_update_class_completion 
BEFORE UPDATE ON exam_results
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM teaching 
        WHERE teaching.class_id = (SELECT class_id FROM student WHERE student.student_id = NEW.student_id)
          AND teaching.subject_id = NEW.subject_id 
          AND teaching.end_date < NEW.exam_date
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Học viên chỉ được thi môn học mà lớp đã học xong.';
    END IF;
END$$

DELIMITER ;

-- Xét thứ tự trước sau giữa các môn học

DELIMITER $$

CREATE TRIGGER trg_insert_subject_sequence 
BEFORE INSERT ON teaching
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM prerequisite 
        WHERE prerequisite.subject_id = NEW.subject_id 
          AND prerequisite.prerequisite_subject_id IN (
              SELECT subject_id 
              FROM teaching 
              WHERE class_id = NEW.class_id 
                AND end_date > NEW.start_date
          )
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Chưa học xong môn điều kiện thì không được học môn kế tiếp.';
    END IF;
END$$

CREATE TRIGGER trg_update_subject_sequence 
BEFORE UPDATE ON teaching
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM prerequisite 
        WHERE prerequisite.subject_id = NEW.subject_id 
          AND prerequisite.prerequisite_subject_id IN (
              SELECT subject_id 
              FROM teaching 
              WHERE class_id = NEW.class_id 
                AND end_date >= NEW.start_date
          )
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Chưa học xong môn điều kiện thì không được học môn kế tiếp.';
    END IF;
END$$

DELIMITER ;

-- Giáo viên chỉ được phân công dạy những môn thuộc khoa mình

DELIMITER $$

CREATE TRIGGER trg_insert_teacher_subject 
BEFORE INSERT ON teaching
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM teacher 
        JOIN subject ON teacher.department_id = subject.department_id 
        WHERE teacher.teacher_id = NEW.teacher_id 
          AND subject.subject_id = NEW.subject_id
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Giáo viên chỉ được phân công dạy những môn thuộc khoa mình.';
    END IF;
END$$

CREATE TRIGGER trg_update_teacher_subject 
BEFORE UPDATE ON teaching
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM teacher 
        JOIN subject ON teacher.department_id = subject.department_id 
        WHERE teacher.teacher_id = NEW.teacher_id 
          AND subject.subject_id = NEW.subject_id
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Giáo viên chỉ được phân công dạy những môn thuộc khoa mình.';
    END IF;
END$$

DELIMITER ;
