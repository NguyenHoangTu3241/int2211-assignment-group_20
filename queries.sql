-- Câu 1: In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    s.birth_date AS "Bỉrth Date",
    c.class_id AS "Class ID"
FROM 
    student s
JOIN 
    class c ON s.student_id = c.class_leader_id;

-- Câu 2: In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên
SELECT 
    e.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    e.attempt_number AS "Attempt Number",
    e.score AS "Score"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    e.subject_id = 'CTRR' AND s.class_id = 'K12'
ORDER BY 
    s.last_name, s.first_name;

-- Câu 3: In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt
SELECT 
    e.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    e.subject_id AS "Subject ID"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    e.attempt_number = 1 AND e.score >= 5;

-- Câu 4: In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1)
SELECT 
    e.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    s.class_id = 'K11' AND e.subject_id = 'CTRR' AND e.attempt_number = 1 AND e.score < 5;
    
-- Câu 5: Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi)
SELECT 
    e.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    s.class_id LIKE 'K%' AND e.subject_id = 'CTRR'
GROUP BY 
    e.student_id
HAVING 
    MAX(e.score) < 5;

-- Câu 6: Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006
SELECT DISTINCT 
    su.subject_name AS "Subject Name"
FROM 
    teaching t
JOIN 
    teacher te ON t.teacher_id = te.teacher_id
JOIN 
    subject su ON t.subject_id = su.subject_id
WHERE 
    te.full_name = 'Tran Tam Thanh' 
    AND t.semester = 1 
    AND t.year = 2006;

-- Câu 7: Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006
SELECT DISTINCT 
    su.subject_id AS "Subject ID", 
    su.subject_name AS "Subject Name"
FROM 
    teaching t
JOIN 
    class c ON t.teacher_id = c.head_teacher_id
JOIN 
    subject su ON t.subject_id = su.subject_id
WHERE 
    c.class_id = 'K11' 
    AND t.semester = 1 
    AND t.year = 2006;
    
-- Câu 8: Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”
SELECT DISTINCT 
    CONCAT(s.last_name, ' ', s.first_name) AS "Class Leader Name"
FROM 
    teaching t
JOIN 
    teacher te ON t.teacher_id = te.teacher_id
JOIN 
    subject su ON t.subject_id = su.subject_id
JOIN 
    class c ON t.class_id = c.class_id
JOIN 
    student s ON c.class_leader_id = s.student_id
WHERE 
    te.full_name = 'Nguyen To Lan' 
    AND su.subject_name = 'Co So Du Lieu';

-- Câu 9: In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT 
    p.prerequisite_subject_id AS "Subject ID", 
    su.subject_name AS "Subject Name"
FROM 
    prerequisite p
JOIN 
    subject su ON p.prerequisite_subject_id = su.subject_id
WHERE 
    p.subject_id = 'CSDL';

-- Câu 10: Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT 
    p.subject_id AS "Subject ID", 
    su.subject_name AS "Subject Name"
FROM 
    prerequisite p
JOIN 
    subject su ON p.subject_id = su.subject_id
WHERE 
    p.prerequisite_subject_id = 'CTRR';
    
-- Câu 11: Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT DISTINCT 
    te.full_name AS "Teacher Name"
FROM 
    teaching t1
JOIN 
    teaching t2 ON t1.teacher_id = t2.teacher_id
JOIN 
    teacher te ON t1.teacher_id = te.teacher_id
WHERE 
    t1.subject_id = 'CTRR' 
    AND t2.subject_id = 'CTRR'
    AND t1.class_id = 'K11' 
    AND t2.class_id = 'K12'
    AND t1.semester = 1 
    AND t1.year = 2006
    AND t2.semester = 1 
    AND t2.year = 2006;

-- Câu 12: Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
SELECT 
    s.student_id AS "Student ID", 
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    e.subject_id = 'CSDL' 
    AND e.attempt_number = 1 
    AND e.score < 5
    AND NOT EXISTS (
        SELECT 1 
        FROM exam_results e2 
        WHERE e2.student_id = e.student_id 
        AND e2.subject_id = 'CSDL' 
        AND e2.attempt_number > 1
    );

-- Câu 13: Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
SELECT 
    te.teacher_id AS "Teacher ID", 
    te.full_name AS "Full Name"
FROM 
    teacher te
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM teaching t 
        WHERE t.teacher_id = te.teacher_id
    );

-- Câu 14: Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
SELECT 
    te.teacher_id AS "Teacher ID", 
    te.full_name AS "Full Name"
FROM 
    teacher te
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM teaching t
        JOIN subject su ON t.subject_id = su.subject_id
        WHERE t.teacher_id = te.teacher_id 
        AND su.department_id = te.department_id
    );

-- Câu 15: Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT DISTINCT 
    s.student_id AS "Student ID", 
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    s.class_id = 'K11'
    AND (
        -- Điều kiện 1: Thi một môn bất kỳ 3 lần vẫn không đạt
        (
            SELECT COUNT(*)
            FROM exam_results e2
            WHERE 
                e2.student_id = e.student_id 
                AND e2.subject_id = e.subject_id 
                AND e2.result = "Khong Dat"
        ) = 3
        -- Điều kiện 2: Thi lần thứ 2 môn CTRR được 5 điểm
        OR (
            e.subject_id = 'CTRR' 
            AND e.attempt_number = 2 
            AND e.score = 5
        )
    );





