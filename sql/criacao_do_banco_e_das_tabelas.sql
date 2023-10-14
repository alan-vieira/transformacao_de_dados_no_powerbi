-- criação do banco de dados
create schema if not exists azure_company;

-- acesso ao banco
use azure_company;

-- exibição do schema do banco
select * from information_schema.table_constraints
where constraint_schema = 'azure_company';

-- criação da tabela employee
CREATE TABLE employee(
Fname varchar(15) not null,
Minit char,
Lname varchar(15) not null,
Ssn char(9) not null, 
Bdate date,
Address varchar(30),
Sex char,
Salary decimal(10,2),
Super_ssn char(9),
Dno int not null,
constraint chk_salary_employee check (Salary> 2000.0),
constraint pk_employee primary key (Ssn)
);

-- alteração da table employee
alter table employee modify Dno int not null default 1;

-- criação da tabela departament
create table departament(
Dname varchar(15) not null,
Dnumber int not null,
Mgr_ssn char(9) not null,
Mgr_start_date date, 
Dept_create_date date,
constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
constraint pk_dept primary key (Dnumber),
constraint unique_name_dept unique(Dname),
foreign key (Mgr_ssn) references employee(Ssn)
);

-- alteração da tabela departament (adição de uma constraint)
alter table departament add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn) on update cascade;

-- criação da table dept_locations
create table dept_locations(
Dnumber int not null,
Dlocation varchar(15) not null,
constraint pk_dept_locations primary key (Dnumber, Dlocation)
);

-- alteração da tabela (adição de constraint)
alter table dept_locations 
add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
on delete cascade
on update cascade;

-- criação da tabela project
create table project(
Pname varchar(15) not null,
Pnumber int not null,
Plocation varchar(15),
Dnum int not null,
primary key (Pnumber),
constraint unique_project unique (Pname),
constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

-- criação da tabela works_on
create table works_on(
Essn char(9) not null,
Pno int not null,
Hours decimal(3,1) not null,
primary key (Essn, Pno),
constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);

-- criação da tabela dependent
create table dependent(
Essn char(9) not null,
Dependent_name varchar(15) not null,
Sex char,
Bdate date,
Relationship varchar(8),
primary key (Essn, Dependent_name),
constraint fk_dependent foreign key (Essn) references employee(Ssn)
);