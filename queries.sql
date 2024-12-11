USE academic_administration;

-- In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    s.birth_date AS "Bỉrth Date",
    c.class_id AS "Class ID"
FROM 
    student s
JOIN 
    class c ON s.student_id = c.class_leader_id;

-- In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên
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

-- In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt
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

-- In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1)
SELECT 
    e.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    s.class_id = 'K11' AND e.subject_id = 'CTRR' AND e.attempt_number = 1 AND e.score < 5;
    
-- Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi)
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

-- Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006
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

-- Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006
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

-- In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT 
    p.prerequisite_subject_id AS "Subject ID", 
    su.subject_name AS "Subject Name"
FROM 
    prerequisite p
JOIN 
    subject su ON p.prerequisite_subject_id = su.subject_id
WHERE 
    p.subject_id = 'CSDL';

-- Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT 
    p.subject_id AS "Subject ID", 
    su.subject_name AS "Subject Name"
FROM 
    prerequisite p
JOIN 
    subject su ON p.subject_id = su.subject_id
WHERE 
    p.prerequisite_subject_id = 'CTRR';
    
-- Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
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

-- Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
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

-- Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
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

-- Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
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

-- Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
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

-- Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT 
    te.teacher_id AS "Teacher ID", 
    te.full_name AS "Teacher Name"
FROM 
    teaching t
JOIN 
    teacher te ON t.teacher_id = te.teacher_id
WHERE 
    t.subject_id = 'CTRR'
GROUP BY 
    t.teacher_id, t.semester, t.year
HAVING 
    COUNT(DISTINCT t.class_id) >= 2;

-- Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    e.subject_id AS "Subject ID",
    e.score AS "Final Score"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    e.subject_id = 'CSDL'
    AND e.attempt_number = (
        SELECT MAX(e2.attempt_number)
        FROM exam_results e2
        WHERE e2.student_id = e.student_id AND e2.subject_id = e.subject_id
    );

-- Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    e.subject_id AS "Subject ID",
    MAX(e.score) AS "Highest Score"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    e.subject_id = 'CSDL'
GROUP BY 
    e.student_id, e.subject_id;
    
-- Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất
SELECT 
    d.department_id AS "Department ID",
    d.department_name AS "Department Name",
    d.creation_date AS "Founded Year"
FROM 
    department d
ORDER BY 
    d.creation_date ASC
LIMIT 1;

-- Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”
SELECT 
    COUNT(*) AS "Professor Count"
FROM 
    teacher
WHERE 
    academic_title IN ('GS', 'PGS');
    
-- Câu 21: Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa
SELECT 
    d.department_id AS "Department ID",
    d.department_name AS "Department Name",
    t.degree AS "Degree",
    COUNT(*) AS "Teacher Count"
FROM 
    teacher t
JOIN 
    department d ON t.department_id = d.department_id
WHERE 
    t.degree IN ('CN', 'KS', 'ThS', 'TS', 'PTS')
GROUP BY 
    d.department_id, t.degree;

-- Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt)
SELECT 
    e.subject_id AS "Subject ID",
    su.subject_name AS "Subject Name",
    CASE 
        WHEN e.score >= 5 THEN 'Pass'
        ELSE 'Fail'
    END AS "Result",
    COUNT(*) AS "Student Count"
FROM 
    exam_results e
JOIN 
    subject su ON e.subject_id = su.subject_id
GROUP BY 
    e.subject_id, 
    CASE 
        WHEN e.score >= 5 THEN 'Pass'
        ELSE 'Fail'
    END;

-- Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học
SELECT 
    te.teacher_id AS "Teacher ID",
    te.full_name AS "Teacher Name"
FROM 
    teacher te
JOIN 
    class c ON te.teacher_id = c.head_teacher_id
JOIN 
    teaching t ON t.teacher_id = te.teacher_id AND t.class_id = c.class_id
GROUP BY 
    te.teacher_id;

-- Câu 24: Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất
SELECT 
    CONCAT(s.last_name, ' ', s.first_name) AS "Class Leader Name"
FROM 
    class c
JOIN 
    student s ON c.class_leader_id = s.student_id
ORDER BY 
    c.size DESC
LIMIT 1;

-- Tìm danh sách họ tên của các lớp trưởng thuộc lớp "K11" mà đã thi không đạt tối đa 3 môn, mỗi môn đều thi không đạt ở tất cả các lần thi.
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS "Class Leader Name"
FROM 
    class c
JOIN 
    student s ON c.class_leader_id = s.student_id
WHERE 
    c.class_id = 'K11'
    AND (
        SELECT COUNT(DISTINCT e.subject_id)
        FROM exam_results e
        WHERE e.student_id = s.student_id
        AND e.score < 5
        AND NOT EXISTS (
            SELECT 1
            FROM exam_results e2
            WHERE e2.student_id = e.student_id 
            AND e2.subject_id = e.subject_id 
            AND e2.score >= 5
        )
    ) <= 3;

-- Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    e.score IN (9, 10)
GROUP BY 
    s.student_id
ORDER BY 
    COUNT(*) DESC
LIMIT 1;

-- Câu 27: Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT 
    s.class_id AS "Class ID",
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    COUNT(*) AS "Number Of Subjects"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    e.score IN (9, 10)
GROUP BY 
    s.class_id, s.student_id
ORDER BY 
    s.class_id, COUNT(*) DESC;

-- Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp
SELECT 
    t.teacher_id AS "Teacher ID",
    te.full_name AS "Teacher Name",
    t.semester AS "Semester",
    t.year AS "Year",
    COUNT(DISTINCT t.subject_id) AS "Subjects Taught",
    COUNT(DISTINCT t.class_id) AS "Classes Taught"
FROM 
    teaching t
JOIN 
    teacher te ON t.teacher_id = te.teacher_id
GROUP BY 
    t.teacher_id, t.semester, t.year;

-- Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất
SELECT 
    t.teacher_id AS "Teacher ID",
    te.full_name AS "Teacher Name",
    t.semester AS "Semester",
    t.year AS "Year",
    COUNT(DISTINCT t.class_id) AS "Number of Classes"
FROM 
    teaching t
JOIN 
    teacher te ON t.teacher_id = te.teacher_id
GROUP BY 
    t.semester, t.year, t.teacher_id
ORDER BY 
    t.semester, t.year, COUNT(DISTINCT t.class_id) DESC
LIMIT 1;

-- Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt ở lần thi thứ 1
SELECT 
    e.subject_id AS "Subject ID",
    su.subject_name AS "Subject Name",
    COUNT(*) AS "Number of Failing Students"
FROM 
    exam_results e
JOIN 
    subject su ON e.subject_id = su.subject_id
WHERE 
    e.attempt_number = 1
    AND e.score < 5
GROUP BY 
    e.subject_id
ORDER BY 
    COUNT(*) DESC
LIMIT 1;

-- Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1)
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    e.attempt_number = 1
GROUP BY 
    s.student_id
HAVING 
    COUNT(CASE WHEN e.score >= 5 THEN 1 END) = COUNT(*);

-- Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng)
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    e.attempt_number = (SELECT MAX(attempt_number) FROM exam_results e2 WHERE e2.student_id = s.student_id AND e2.subject_id = e.subject_id)
GROUP BY 
    s.student_id
HAVING 
    COUNT(CASE WHEN e.score >= 5 THEN 1 END) = COUNT(*);

-- Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1)
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    e.attempt_number = 1
GROUP BY 
    s.student_id
HAVING 
    COUNT(CASE WHEN e.score >= 5 THEN 1 END) = COUNT(DISTINCT e.subject_id);

-- Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi sau cùng)
SELECT 
    s.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name"
FROM 
    student s
JOIN 
    exam_results e ON s.student_id = e.student_id
WHERE 
    e.attempt_number = (SELECT MAX(attempt_number) FROM exam_results e2 WHERE e2.student_id = s.student_id AND e2.subject_id = e.subject_id)
GROUP BY 
    s.student_id
HAVING 
    COUNT(CASE WHEN e.score >= 5 THEN 1 END) = COUNT(DISTINCT e.subject_id);

-- Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng)
SELECT 
    e.student_id AS "Student ID",
    CONCAT(s.last_name, ' ', s.first_name) AS "Full Name",
    e.subject_id AS "Subject ID",
    e.score AS "Highest Score"
FROM 
    exam_results e
JOIN 
    student s ON e.student_id = s.student_id
WHERE 
    e.attempt_number = (SELECT MAX(attempt_number) FROM exam_results e2 WHERE e2.student_id = e.student_id AND e2.subject_id = e.subject_id)
ORDER BY 
    e.subject_id, e.score DESC;

