#Cau 1: Hiển thị số lượng sinh viên ở từng nơi
# cound dem so dong
SELECT Address, Phone, StudentName, count(Address) as c
FROM Student
having c > 1;






#Cau 2: Tính điểm trung bình các môn học của mỗi học viên
-- SELECT S.StudentId, S.StudentName, AVG(Mark)
-- FROM Student S
--          join Mark M on S.StudentId = M.StudentId
-- GROUP BY S.StudentId, S.StudentName
-- HAVING AVG(Mark) < 15;

#Cau 2: Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
-- SELECT S.StudentId, S.StudentName, AVG(Mark)
-- FROM Student S join Mark M on S.StudentId = M.StudentId
-- GROUP BY S.StudentId, S.StudentName
-- HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);

#Cau 3: Lay ra diem trung binh lon nhat
-- select MAX(m.Mark)
-- from 
-- 	(SELECT *, avg(Mark) FROM quanlysinhvien.mark
-- 	group by StudentId) as m

