--1
/*For cach city find the date when the first person was employed.*/
select loc, min(Hiredate)
from dept,emp
where emp.deptno=dept.deptno
group by loc;

---2
/*Find people who earn more then everybody in Dallas.*/
select ename
from emp
where sal > all(
select sal
from dept,emp
where dept.deptno=emp.deptno and loc='DALLAS'
);

---3
/*For each department show how many staff members have names consisting of 4 characters.*/
select d.dname,count(empno)
from dept d,emp e
where d.deptno=e.deptno and e.ename like'____' --length(e.ename)=4
group by d.dname;

--4
/*.Find names of departments for which there is somebody earning the same as average salary for grade 1.*/
select d.dname
from dept d, emp
where d.deptno=emp.deptno and sal=(
select avg(sal)
from emp,salgrade
where grade=1 and sal>losal and sal<hisal
);

--5
/*Show names of supervisors ordered by number of staff members supervised by them.*/
select b.ename,count(a.empno)
from emp b, emp a
where a.mgr=b.empno
group by b.ename
order by count(a.empno);

--6
/*Show in one column names of cities and names of departments.*/
select loc 
from dept
union
select dname
from dept
order by 1;

--additional
select job,sal
from emp
union
select loc, deptno
from dept;

--7
/*Find departments in which average salary is smaller than average commission.*/ 
select deptno
from emp
group by deptno
having avg(sal)>avg(nvl(comm,0));

--8
/*ls there any grade such that nobody earns salary in it ? */
select grade
from salgrade
where not exists(
select ename
from emp
where sal>losal and sal<hisal
);

--9 correlated query
/*Find people who earn the highest salary for the city in which they work.*/
select ename
from emp,dept d
where emp.deptno=d.deptno and sal=(
select max(sal)
from emp, dept
where emp.deptno=dept.deptno and loc=d.loc);


--10
/*For each city and grade show how many people from this city earn salary in each grade.*/
select loc,grade,count(empno)
from emp ,salgrade,dept
where emp.deptno=dept.deptno and sal between losal and hisal
group by loc,grade;


--additional.  jobs such that at least one person having this job
--earns salary in second grade and nobody having this job earns salary in grade third
select job
from emp e
where exists (
select empno 
from emp, salgrade
where sal between losal and hisal and grade=2 and job=e.job) ;


select grade,job,sal
from emp,salgrade
where sal between losal and hisal and grade=3;


--for each city find the yearly income for all people working there 

select loc,sum(sal*12 + nvl(comm,0))
from emp, dept
where emp.deptno=dept.deptno
group by loc;
















