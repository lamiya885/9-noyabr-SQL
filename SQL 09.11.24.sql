create database  BlogDB 
use BlogDB

create table Categories(
ID int Primary key identity ,
Name nvarchar(50) not null unique
)

create table Tags(
ID int Primary key  identity ,
Name  nvarchar(50) not null unique
)

create table Users(
ID int Primary key  identity,
UserName nvarchar(50) not null unique,
FullName nvarchar(50) not null ,
Age int,
check (Age>=0 and age<=150)
)

create table Comments(
ID int Primary key identity,
Content nvarchar(250) not null,
UserId int foreign key references Users(ID),
BlogId int references Blogs(ID)
)

create table Blogs(
ID int Primary key identity,
Title  nvarchar(50)   not null   ,
Description nvarchar(50) not null ,
UserId int foreign key references Users(ID),
CategoryID int references Categories(ID)
)



create table BlogsTags(
ID int unique not null identity ,
BlogID int Foreign key references Blogs(ID),
TagID int foreign key references Tags(ID)
)


insert into categories
values('eylence'),
('seyahet')

select * from Categories

insert into Tags
values('#BP215'),
('#RM023S1')

select* from Tags

insert into Users
Values('Lamiya','Lamiya885',19),
('Fidan','Valiyeva',19),
('Turkan ','dadashova',19)

select* from Users


insert into Blogs
Values('Description1','Title1',1,1),
('Description2','Title2',1,2),
('Description3','Title3',2,1),
('Description4','Title4',3,2)



select *from Blogs



insert into Comments
values('Hello World!',1,2),
('Salam Dunya!',2,1)

select*from  Comments

insert into BlogsTags
values(1,2),
(2,1)

select*from BlogsTags



create view use_getUsersBlogs
as
select U.UserName [User Name ],U.FullName [Full Name],B.Title [Title] from Users as U
join Blogs as B
on B.UserId=U.ID


create view use_getCategoriesBlogs
as
select C.[name] [name],B.Title [Title] from Blogs as B
join Categories as C
on B.CategoryID=c.ID

select *from use_getUsersBlogs
select *from use_getCategoriesBlogs




create procedure usp_UsersCommentsWhere  @UserID int  
as
select Users.UserName [Istifadeci Adi],users.FullName,Users.Age [yasi],Comments.Content from Users
join Comments
on Comments.UserId=Users.ID 
where Comments.UserId=@UserID 

exec  usp_UsersCommentsWhere @UserID=2


create procedure usp_UsersBlogsWhere  @UserID int  
as
select Users.UserName [Istifadeci Adi],users.FullName,Users.Age [yasi],Blogs.Description,Blogs.Title  from Users
join Blogs
on Blogs.UserId=Users.ID 
where Blogs.UserId=@UserID 

exec usp_UsersBlogsWhere @UserID=1


create function GetBlogsCount( @CategoryID int )
returns int 
as 
begin
declare @BlogCount int
select @BlogCount=Count(*) from Blogs
where Blogs.CategoryID=@CategoryID
return @BlogCount
end 

 select dbo.GetBlogsCount(1) as BlogCount

 
create function GetBlogsTable ( @UserID int )
returns   Table
as 
return 
(
select Blogs.Title, Blogs.Discription from Blogs 
Where Blogs.UserID=@UserID
)

select* from  dbo.GetBlogsTable(1) 

drop function GetBlogsTable




Create Trigger IsDeleted
on Blogs 
after delete
as 
begin
select ' database  silindi! "True"'
end





drop table comments
drop table Tags
drop table Users
drop table Blogs
drop table categories

drop procedure usp_UsersCommentsWhere
drop view use_getCategoriesBlogs
drop view use_getUsersBlogs

drop function  GetBlogsCount



drop database BlogDB
