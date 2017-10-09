select pos as 'position', avg(salary) as avgSal
from salaries
group by pos
order by avg(salary) desc;