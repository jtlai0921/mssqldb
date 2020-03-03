--建立資料庫MYDB
CREATE DATABASE MYDB
GO

USE MYDB
GO

--建立資料表
CREATE TABLE 訂單(
	訂單編號  int primary key,
	下單日期  datetime,
	客戶編號  int,	
	原價      smallmoney,
	折扣      decimal(2,2)
)
go


drop table 訂單
go
--建立計算欄位
CREATE TABLE 訂單(
	訂單編號  int identity not null ,
	下單日期  datetime not null ,
	客戶編號  int,	
	原價      smallmoney,
	折扣      decimal(2,2),
	優惠價  AS  原價*折扣
)
go


--建立資料表條件限制
--1.Primary Key
drop table 客戶
CREATE TABLE dbo.[客戶](
   客戶編號  int not null,
   身份證字號  char(10) not null,  
   年齡  tinyint ,
   地址  varchar(50),
   電話  char(12)
)
go
alter table 客戶 add  constraint [PK_客編_身份證號] primary key (客戶編號,身份證字號)
alter table 客戶 drop  constraint [PK_客編_身份證號] 


--2. NULL 、 NOT NULL
drop table 客戶

CREATE TABLE 客戶
(  客戶編號  int NOT NULL,
   身份證字號  char(10) NOT NULL,
   年齡  tinyint NULL,
   地址  varchar(50),
   電話  char(12),   
   CONSTRAINT [PK_客戶編號] PRIMARY KEY (客戶編號)  ) 
 go

 alter table 客戶 alter column 電話 varchar(15) not null


--3. DEFAULT值
drop table 訂單
go

CREATe TABLE 訂單(
	訂單編號  int NOT NULL primary key,
	下單日期  datetime DEFAULT GETDATE(),
	客戶編號  int	NOT NULL
	)
go

insert 訂單 (訂單編號,客戶編號) values (4,1)
select * from 訂單

--4. UNIQUE
drop table 客戶
CREATE TABLE 客戶
(  客戶編號  int ,
   身份證字號  char(10) ,  
   年齡  tinyint  ,  
   地址  varchar(50),
   電話  char(12),   
   CONSTRAINT [PK_客戶編號] PRIMARY KEY (客戶編號) ,
   CONSTRAINT [UIQ_身份證字號] UNIQUE (身份證字號)) 
go


--5. CHECK
drop table 客戶
CREATE TABLE 客戶
(  客戶編號  int NOT NULL,
   身份證字號  char(10) NOT NULL ,  
   年齡  tinyint ,
   地址  varchar(50),
   電話  char(12),   
   CONSTRAINT [PK_客戶編號] PRIMARY KEY (客戶編號) ,
   CONSTRAINT [UIQ_身份證字號] UNIQUE (身份證字號),
   CONSTRAINT [CK_電話地址] CHECK (地址 IS NOT NULL OR 電話 IS NOT NULL )) 
go


--6.Foreign Key
drop table 訂單
CREATE TABLE 訂單(
	訂單編號  nvarchar(10) primary key,
	下單日期  datetime,
	客戶編號  nvarchar(10)	
	)
go
create table 訂單明細(
訂單編號 nvarchar(10) ,
產品編號 nvarchar(10)  ,
單價  int,
數量  int,
constraint [PK_訂單編號_產品編號] primary key(訂單編號,產品編號),
constraint [FK_明細_訂單] Foreign Key(訂單編號) REFERENCES 訂單(訂單編號)
)




--修改欄位屬性
--變更資料型別(客戶.電話改為varchar(12))
alter table 客戶 alter column 電話 varchar(12)
go


--新增客戶姓名欄位
alter table 客戶 add 客戶姓名 varchar(20)
go


--刪除年齡欄位
alter table 客戶 drop column 年齡
go

--變更資料表名字 & 欄位名稱
exec sp_rename '客戶','客戶資料表'


exec sp_helpconstraint 客戶


--新增條件約束
CREATE TABLE 客戶
(  客戶編號  int identity NOT NULL,
   身份證字號  char(10) NOT NULL ,  
   年齡  tinyint ,
   地址  varchar(50),
   電話  char(12))

insert into 客戶 (身份證字號,年齡,地址,電話) values ('a1234565',25,'a123455','1234567870')
go 100


select count(*) from 客戶

select * from 客戶

sp_helpconstraint 客戶
--with NO check
alter table 客戶 with nocheck add constraint [CK_客戶電話] check (電話 is not null)
go

--drop constraint
alter table 客戶 drop constraint [CK_客戶電話] 
go

--with check
alter table 客戶 add constraint [CK_客戶電話] check (電話 is not null)
go


--新增條件約束Primary KEY
alter table 客戶 add constraint [PK_客戶編號] PRIMARY KEY (客戶編號)
go

--插入一個編號在識別欄位裡
select * from 客戶

alter table 客戶 add 客戶姓名 varchar(50)
delete 客戶 where 客戶編號=1

SET IDENTITY_INSERT 客戶 ON

INSERT INTO 客戶 (客戶編號,客戶姓名,身份證字號,地址,電話) values (351,'小強','A123456789','台北市','123456789')

SELECT * FROM 客戶

SET IDENTITY_INSERT 客戶 OFF
go

--參考完整性
use MyDB
go


if exists (select * from sys.tables where name='訂單')
drop table 訂單
go

if exists (select * from sys.tables where name='客戶')
drop table 客戶
go


CREATE TABLE dbo.[客戶](
   客戶編號  int  not null,
   客戶姓名  varchar(20) not null,
   身份證字號  char(10) not null,   
   地址  varchar(50),
   電話  varchar(12),     
   CONSTRAINT [PK_客戶編號] PRIMARY KEY (客戶編號)   
)
go

CREATE TABLE dbo.[訂單](
	訂單編號  int identity not null,
    客戶編號  int	,
	下單日期  datetime,	
	單價  int,
	數量  int,
	小計  as 單價*數量,
	CONSTRAINT [FK_客戶編號_客戶] FOREIGN KEY(客戶編號)
	REFERENCES [客戶](客戶編號)
)
go

INSERT [客戶] VALUES (1,'小陳','A123456789','台北市','1112233')
INSERT [客戶] VALUES (2,'小張','A234567890','台北縣','3456221')
INSERT [客戶] VALUES (3,'小李','A122343212','桃園市','5454554')
INSERT [客戶] VALUES (4,'小黃','A125427565','台中市','5221456')

INSERT [訂單] VALUES (1,'2009/03/03 15:00:02',5,100)
INSERT [訂單] VALUES (1,'2009/03/04 15:15:30',6,120)
INSERT [訂單] VALUES (2,'2009/02/03 11:20:02',10,121)
INSERT [訂單] VALUES (2,'2009/03/01 15:50:30',8,50)
INSERT [訂單] VALUES (3,'2009/03/04 16:44:00',60,60)
INSERT [訂單] VALUES (3,'2009/03/04 09:33:00',2,80)
go

--無法刪除客戶編號『1』的資料
DELETE 客戶 WHERE 客戶編號=1
go

delete from 訂單 where 客戶編號=1
go

--暫時停用外來鍵參考
exec sp_helpconstraint 客戶

alter table 訂單 nocheck constraint [FK_客戶編號_客戶]
--啟用
ALTER TABLE 訂單 CHECK CONSTRAINT [FK_客戶編號_客戶]
go

--變更外來鍵參考處理方式
ALTER TABLE 訂單 DROP CONSTRAINT  [FK_客戶編號_客戶]
go

sp_helpconstraint 訂單

ALTER TABLE 訂單 ADD  CONSTRAINT  [FK_客戶編號_客戶] FOREIGN KEY (客戶編號) REFERENCES [客戶](客戶編號) 
  ON DELETE CASCADE
  ON UPDATE CASCADE
go

SELECT * FROM 客戶
SELECT * FROM 訂單

UPDATE 客戶 SET 客戶編號=4 WHERE 客戶編號=3
SELECT * FROM 客戶
go



--delete AND Truncate
use master
go

if exists(select * from sys.databases where name='mydb')
drop database mydb
go

CREATE DATABASE MyDB
--主群組的資料檔
ON primary(
	NAME=MyDB1,
	FileName='D:\DB-A1\MyDB1.mdf',	
	SIZE=5MB),

--新建群組的資料檔
FileGroup G1(
	NAME=MyDB_G1_1,
	FileName='D:\DB-A1\MyDB_G1_1.ndf',
	SIZE=5MB)
--建立Log檔
Log ON (
	NAME=MyDB_Log,
	FileName='D:\DB-A1\MyDB_Log.ldf'
	)
GO



use MYDB
go


CREATE TABLE 客戶1
(  客戶編號  int identity NOT NULL,
   身份證字號  char(10) NOT NULL ,  
   年齡  tinyint ,
   地址  varchar(50),
   電話  char(12)) on [primary]
go

CREATE TABLE 客戶2
(  客戶編號  int identity NOT NULL,
   身份證字號  char(10) NOT NULL ,  
   年齡  tinyint ,
   地址  varchar(50),
   電話  char(12)) on G1
go

insert into 客戶1 values ('a1234565',25,'a123455',null)
go 200000

insert into 客戶2 values ('a1234565',25,'a123455',null)
go 200000

select * from 客戶1 
select * from 客戶2


Truncate table 客戶1


delete from 客戶2


go
sp_helpdb mydb

DBCC SHRINKFILE (MYDB1,1)

DBCC SHRINKDATABASE (mydb)



