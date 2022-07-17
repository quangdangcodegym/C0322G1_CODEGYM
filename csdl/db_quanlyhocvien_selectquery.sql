

-- SELECT *
-- FROM Student;

#Hiển thị danh sách học viên đang theo học
-- SELECT *
-- FROM Student
-- WHERE Status = true;

#Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.
-- SELECT *
-- FROM Subject
-- WHERE Credit < 10;

#Hiển thị danh sách học viên lớp A1
-- SELECT S.StudentId, S.StudentName, C.ClassName
-- FROM Student S join Class C on S.ClassId = C.ClassID
-- WHERE C.ClassName = 'A1';

-- SELECT S.StudentId, S.StudentName, C.ClassName
-- From Student S, Class C
-- WHERE C.ClassName = 'A1' and S.ClassId = C.ClassID;

#Hiển thị danh sách học viên lớp A1
-- SELECT S.StudentId, S.StudentName, C.ClassName
-- FROM Student S, Class C
-- WHERE C.ClassName = 'A1' and S.ClassId = C.ClassID;

#Hiển thị điểm môn CF của các học viên.
# Join 3 bang
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';

# left join

select StudentId, StudentName, ClassName
from class  full join  Student  on Student.ClassId = class.ClassID;


#Hiển thị điểm môn CF của các học viên.


#Join 4 bang
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark, c.ClassName
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId 
join class c on c.ClassID = S.ClassId
WHERE Sub.SubName = 'CF';

#-------------------------------------
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark, c.ClassName
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId 
join class c on c.ClassID = S.ClassId
WHERE Sub.SubName like 'c%';


#---Su dung in ----------------------------------
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark, c.ClassName
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId 
join class c on c.ClassID = S.ClassId
WHERE Sub.SubName in (select SubName from subject where SubName like 'c%') ;

#---Su dung toan tu  ----------------------------------
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark, c.ClassName
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId 
join class c on c.ClassID = S.ClassId
WHERE Sub.SubName <> 'H' or Sub.SubName <> 'K';

#---Su dung toan tu  ----------------------------------
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark, c.ClassName
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId 
join class c on c.ClassID = S.ClassId
WHERE Sub.SubName not like 'c%';

# Hiển thị danh sách các subject bắt đầu CF
select *
from subject
where SubName like 'c%';

#Hiển thị điểm môn CF của các học viên.
#Join 4 bang

SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark, c.ClassName
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId join class c on c.ClassID = S.ClassId
WHERE Sub.SubName in (select SubName from subject where SubName like 'c%') ;


