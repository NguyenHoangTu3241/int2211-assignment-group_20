-- Thêm một sinh viên mới vào bảng students và thêm kết quả thi của sinh viên này vào bảng exam_results
-- Nếu có lỗi xảy ra ở bất kỳ bước nào, toàn bộ các thay đổi sẽ bị hủy (rollback).
START TRANSACTION;
INSERT INTO students (student_id, first_name, last_name, class_id) 
VALUES (1001, 'John', 'Doe', 'K11');
INSERT INTO exam_results (student_id, subject_id, exam_number, score) 
VALUES (1001, 'INVALID_SUBJECT', 1, 95);
ROLLBACK;

