-- Bắt đầu giao dịch
START TRANSACTION;

-- Thêm học viên mới vào bảng students
-- (giả sử lớp 'K11' tồn tại trong bảng classes)
INSERT INTO students (student_id, first_name, last_name, class_id) 
VALUES ('K1201', 'Jane', 'Smith', 'K11');

-- Thêm kết quả thi cho học viên mới vào bảng exam_results
-- (giả sử môn 'CTRR' tồn tại trong bảng subjects)
INSERT INTO exam_results (student_id, subject_id, attempt_number, score)
VALUES ('K1201', 'CTRR', 1, 75);

-- Nếu không có lỗi, lưu thay đổi
COMMIT;

-- Nếu gặp lỗi, hủy giao dịch
ROLLBACK;
