#컴퓨터공학과와 전자공학과에서 85점이상의 점수 정보와 총점 정보 표시
SELECT *, (p_score+m_score+f_score+h_score) AS total FROM score
WHERE dept IN ('컴퓨터공학과','전자공학과') AND (p_score+m_score+f_score+h_score)>=85
ORDER BY dept ASC,total DESC

SELECT dept FROM score GROUP BY dept ORDER BY dept

SELECT*FROM score

SELECT dept, COUNT(*) AS cnt, 
	MAX(p_score) AS p_max, MIN(p_score) AS p_min,
	MAX(m_score) AS m_max, MIN(m_score) AS m_min,
	MAX(f_score) AS f_max, MIN(f_score) AS f_min,
	MAX(h_score) AS h_max, MIN(h_score) AS h_min,
	AVG(p_score+m_score+f_score+h_score) AS dept_avg,
	IF(AVG(p_score+m_score+f_score+h_score)>83,"최고","보통") AS title,
	SUM(IF(p_score+m_score+f_score+h_score>=90,1,0)) AS A_cnt
FROM score
GROUP BY dept
ORDER BY dept_avg ASC

#점수(총점)별 학점처리
SELECT `name`,(p_score+m_score+f_score+h_score) AS score,
CASE
	WHEN(p_score+m_score+f_score+h_score)>=90 THEN 'A'
	WHEN(p_score+m_score+f_score+h_score)>=80 THEN 'B'
	WHEN(p_score+m_score+f_score+h_score)>=70 THEN 'C'
	WHEN(p_score+m_score+f_score+h_score)>=60 THEN 'D'
	ELSE 'F'
END AS grade
FROM score
WHERE dept='컴퓨터공학과'
ORDER BY FIELD (grade,'A','B','C','D','F')  #정렬값 직접 지정
#order by grade

SELECT DISTINCT dept FROM score
SELECT DISTINCT dept,`name` FROM score  #두 컬럼의 조합이 중복인지 체크

#출력 개수 제한
SELECT `name`,(p_score+m_score+f_score+h_score) AS total 
FROM score ORDER BY total DESC LIMIT 0,10

SELECT dept,AVG(p_score+m_score+f_score+h_score) AS d_avg
FROM score WHERE 1=1
GROUP BY dept
HAVING d_avg>83
ORDER BY d_avg DESC

#중복 idx 체크
SELECT idx, COUNT(*) AS cnt
FROM score WHERE 1=1
GROUP BY idx
HAVING cnt




