###########################
# MSDS 7330 Mini Project 2
###########################
use University;

#Question 1.1
select ID, name, dept_name 
from student
order by name;

#Question 1.2
select name, salary
from instructor
where dept_name in('Comp. Sci.', 'Elec. Eng.')
order by salary desc;

#Question 1.3
select * 
from course
where course_id like 'CS-1%';

#Question 1.4
## resource - https://stackoverflow.com/questions/6807854/get-other-columns-that-correspond-with-max-value-of-one-column
## resource - https://dev.mysql.com/doc/refman/5.7/en/create-view.html
###Create enrollment view
create or replace view v_enrollment as 
select course_id, sec_id as 'section_id', count(*) as 'enrollment'
from takes
group by course_id, sec_id
having count(*) > 0
order by count(*) desc;

###The following self join will show any course and section id combination with the maximum 
###enrollment value from the enrollment view.
select a.course_id, a.section_id, enrollment
from v_enrollment a
join (select max(enrollment) as maxenroll 
	  from v_enrollment) b
      on a.enrollment = b.maxenroll;

###The following self join will show any course and section id combination with the minimum 
###enrollment value from the enrollment view.
select a.course_id, a.section_id, enrollment
from v_enrollment a
join (select min(enrollment) as minenroll 
	  from v_enrollment) b
      on a.enrollment = b.minenroll;

#Question 1.5
create or replace view faculty as select ID, name, dept_name 
from instructor;

select * from faculty;

#Question 1.6
create or replace view CSinstructors as select *
from instructor
where dept_name = 'Comp. Sci.';

select * from CSinstructors;