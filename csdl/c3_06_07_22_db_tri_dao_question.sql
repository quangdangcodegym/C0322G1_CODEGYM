SELECT z.class_id, IFNULL(temp.count, 0)
FROM quanlysinhvien.zalo z
	left join (
    SELECT z1.class_id, count(class_id) as count
	FROM quanlysinhvien.zalo z1
	where test_score >=8
	group by z1.class_id) as temp on z.class_id = temp.class_id
group by z.class_id;