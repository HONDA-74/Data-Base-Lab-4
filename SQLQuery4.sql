use Company_SD
--1---
select d.Dependent_name , d.Sex from Dependent d
inner join Employee e
on e.SSN = d.ESSN
where e.Sex = 'F' and d.Sex = 'F'

union

select d.Dependent_name , d.Sex from Dependent d
inner join  Employee e
on e.SSN = d.ESSN
where e.Sex = 'M' and d.Sex = 'M'
--2------
select Pname , sum(Hours) from  Project 
inner join Works_for 
on Project.Pnumber = Works_for.Pno
group by Pname
--3---------
select * from Departments
inner join Employee
on Departments.Dnum = Employee.Dno
where Employee.SSN = (
	select Min(SSN) from Employee
)
---4--------
select Dname , Max(Employee.Salary) as MaxSalary, Min(Employee.Salary) as MinSalary, AVG(EMployee.Salary) as AVGsalary from Departments
inner join Employee
on Employee.Dno = Departments.Dnum
group by Dname
----5--------
select distinct Fname + ' ' + Lname as fullName
from Employee 
inner join Departments ON MgrSSN = SSN
where ssn not in (
    select distinct ESSN from Dependent
)
-----6----------
select Dnum , Dname ,count(Employee.SSN) as Enum from Departments
inner join Employee
on Departments.Dnum = Employee.Dno
group by Dnum , Dname
having AVG(Employee.salary)<(
							select AVG(salary) from Employee
							)
------7--------
select distinct Fname , Lname , p.Pname , Dno from Employee
inner join Works_for w
on Employee.SSN = w.ESSn
inner join Project p
on p.Pnumber = w.Pno
where Employee.Dno is not null
order by Dno , Lname , fname
-------8------
select salary from Employee
where salary >=
(
	select Max(salary) from Employee 
	where salary < (select Max(salary) from Employee)
)
order by salary desc
--9---------
select distinct Fname+ ' ' + Lname from Employee
inner join Dependent
on Employee.SSN = Dependent.ESSN
where Dependent.Dependent_name like fname + '%'
or Dependent.Dependent_name like lname + '%'
--10----------
select Fname , SSN from Employee
where exists (
		select * from Dependent
		where Employee.SSN = Dependent.ESSN
)
----11--------
insert into Departments (Dname, Dnum, MgrSSN, [MGRStart Date] )
VALUES ('DEPT IT', 100, 112233, '2006-11-01')
-----12-------
update Departments
set MgrSSN = 968574
where Dnum = 100

update Departments
set MgrSSN = 102672
where Dnum = 20

update Employee
set SuperSSN = 102672
where SSN = 102660
------13--------

delete from Dependent
where ESSN = 223344

update Departments
set MgrSSN = 102672
where MgrSSN = 223344

update Employee
set SuperSSN = 102672
where SuperSSN = 223344

delete from Works_for
where ESSN = 223344

delete from Employee
where SSN = 223344
-----14---------
update Employee
set Salary = Salary * 1.3
where SSN in (
    select ESSN
    from Works_for
    inner join Project  ON Works_for.PNO = Pnumber
    where Pname = 'Al Rabwah'
)




