--�إ߸�ƮwMYDB
CREATE DATABASE MYDB
GO

USE MYDB
GO

--�إ߸�ƪ�
CREATE TABLE �q��(
	�q��s��  int primary key,
	�U����  datetime,
	�Ȥ�s��  int,	
	���      smallmoney,
	�馩      decimal(2,2)
)
go


drop table �q��
go
--�إ߭p�����
CREATE TABLE �q��(
	�q��s��  int identity not null ,
	�U����  datetime not null ,
	�Ȥ�s��  int,	
	���      smallmoney,
	�馩      decimal(2,2),
	�u�f��  AS  ���*�馩
)
go


--�إ߸�ƪ���󭭨�
--1.Primary Key
drop table �Ȥ�
CREATE TABLE dbo.[�Ȥ�](
   �Ȥ�s��  int not null,
   �����Ҧr��  char(10) not null,  
   �~��  tinyint ,
   �a�}  varchar(50),
   �q��  char(12)
)
go
alter table �Ȥ� add  constraint [PK_�Ƚs_�����Ҹ�] primary key (�Ȥ�s��,�����Ҧr��)
alter table �Ȥ� drop  constraint [PK_�Ƚs_�����Ҹ�] 


--2. NULL �B NOT NULL
drop table �Ȥ�

CREATE TABLE �Ȥ�
(  �Ȥ�s��  int NOT NULL,
   �����Ҧr��  char(10) NOT NULL,
   �~��  tinyint NULL,
   �a�}  varchar(50),
   �q��  char(12),   
   CONSTRAINT [PK_�Ȥ�s��] PRIMARY KEY (�Ȥ�s��)  ) 
 go

 alter table �Ȥ� alter column �q�� varchar(15) not null


--3. DEFAULT��
drop table �q��
go

CREATe TABLE �q��(
	�q��s��  int NOT NULL primary key,
	�U����  datetime DEFAULT GETDATE(),
	�Ȥ�s��  int	NOT NULL
	)
go

insert �q�� (�q��s��,�Ȥ�s��) values (4,1)
select * from �q��

--4. UNIQUE
drop table �Ȥ�
CREATE TABLE �Ȥ�
(  �Ȥ�s��  int ,
   �����Ҧr��  char(10) ,  
   �~��  tinyint  ,  
   �a�}  varchar(50),
   �q��  char(12),   
   CONSTRAINT [PK_�Ȥ�s��] PRIMARY KEY (�Ȥ�s��) ,
   CONSTRAINT [UIQ_�����Ҧr��] UNIQUE (�����Ҧr��)) 
go


--5. CHECK
drop table �Ȥ�
CREATE TABLE �Ȥ�
(  �Ȥ�s��  int NOT NULL,
   �����Ҧr��  char(10) NOT NULL ,  
   �~��  tinyint ,
   �a�}  varchar(50),
   �q��  char(12),   
   CONSTRAINT [PK_�Ȥ�s��] PRIMARY KEY (�Ȥ�s��) ,
   CONSTRAINT [UIQ_�����Ҧr��] UNIQUE (�����Ҧr��),
   CONSTRAINT [CK_�q�ܦa�}] CHECK (�a�} IS NOT NULL OR �q�� IS NOT NULL )) 
go


--6.Foreign Key
drop table �q��
CREATE TABLE �q��(
	�q��s��  nvarchar(10) primary key,
	�U����  datetime,
	�Ȥ�s��  nvarchar(10)	
	)
go
create table �q�����(
�q��s�� nvarchar(10) ,
���~�s�� nvarchar(10)  ,
���  int,
�ƶq  int,
constraint [PK_�q��s��_���~�s��] primary key(�q��s��,���~�s��),
constraint [FK_����_�q��] Foreign Key(�q��s��) REFERENCES �q��(�q��s��)
)




--�ק�����ݩ�
--�ܧ��ƫ��O(�Ȥ�.�q�ܧאּvarchar(12))
alter table �Ȥ� alter column �q�� varchar(12)
go


--�s�W�Ȥ�m�W���
alter table �Ȥ� add �Ȥ�m�W varchar(20)
go


--�R���~�����
alter table �Ȥ� drop column �~��
go

--�ܧ��ƪ�W�r & ���W��
exec sp_rename '�Ȥ�','�Ȥ��ƪ�'


exec sp_helpconstraint �Ȥ�


--�s�W�������
CREATE TABLE �Ȥ�
(  �Ȥ�s��  int identity NOT NULL,
   �����Ҧr��  char(10) NOT NULL ,  
   �~��  tinyint ,
   �a�}  varchar(50),
   �q��  char(12))

insert into �Ȥ� (�����Ҧr��,�~��,�a�},�q��) values ('a1234565',25,'a123455','1234567870')
go 100


select count(*) from �Ȥ�

select * from �Ȥ�

sp_helpconstraint �Ȥ�
--with NO check
alter table �Ȥ� with nocheck add constraint [CK_�Ȥ�q��] check (�q�� is not null)
go

--drop constraint
alter table �Ȥ� drop constraint [CK_�Ȥ�q��] 
go

--with check
alter table �Ȥ� add constraint [CK_�Ȥ�q��] check (�q�� is not null)
go


--�s�W�������Primary KEY
alter table �Ȥ� add constraint [PK_�Ȥ�s��] PRIMARY KEY (�Ȥ�s��)
go

--���J�@�ӽs���b�ѧO����
select * from �Ȥ�

alter table �Ȥ� add �Ȥ�m�W varchar(50)
delete �Ȥ� where �Ȥ�s��=1

SET IDENTITY_INSERT �Ȥ� ON

INSERT INTO �Ȥ� (�Ȥ�s��,�Ȥ�m�W,�����Ҧr��,�a�},�q��) values (351,'�p�j','A123456789','�x�_��','123456789')

SELECT * FROM �Ȥ�

SET IDENTITY_INSERT �Ȥ� OFF
go

--�Ѧҧ����
use MyDB
go


if exists (select * from sys.tables where name='�q��')
drop table �q��
go

if exists (select * from sys.tables where name='�Ȥ�')
drop table �Ȥ�
go


CREATE TABLE dbo.[�Ȥ�](
   �Ȥ�s��  int  not null,
   �Ȥ�m�W  varchar(20) not null,
   �����Ҧr��  char(10) not null,   
   �a�}  varchar(50),
   �q��  varchar(12),     
   CONSTRAINT [PK_�Ȥ�s��] PRIMARY KEY (�Ȥ�s��)   
)
go

CREATE TABLE dbo.[�q��](
	�q��s��  int identity not null,
    �Ȥ�s��  int	,
	�U����  datetime,	
	���  int,
	�ƶq  int,
	�p�p  as ���*�ƶq,
	CONSTRAINT [FK_�Ȥ�s��_�Ȥ�] FOREIGN KEY(�Ȥ�s��)
	REFERENCES [�Ȥ�](�Ȥ�s��)
)
go

INSERT [�Ȥ�] VALUES (1,'�p��','A123456789','�x�_��','1112233')
INSERT [�Ȥ�] VALUES (2,'�p�i','A234567890','�x�_��','3456221')
INSERT [�Ȥ�] VALUES (3,'�p��','A122343212','��饫','5454554')
INSERT [�Ȥ�] VALUES (4,'�p��','A125427565','�x����','5221456')

INSERT [�q��] VALUES (1,'2009/03/03 15:00:02',5,100)
INSERT [�q��] VALUES (1,'2009/03/04 15:15:30',6,120)
INSERT [�q��] VALUES (2,'2009/02/03 11:20:02',10,121)
INSERT [�q��] VALUES (2,'2009/03/01 15:50:30',8,50)
INSERT [�q��] VALUES (3,'2009/03/04 16:44:00',60,60)
INSERT [�q��] VALUES (3,'2009/03/04 09:33:00',2,80)
go

--�L�k�R���Ȥ�s���y1�z�����
DELETE �Ȥ� WHERE �Ȥ�s��=1
go

delete from �q�� where �Ȥ�s��=1
go

--�Ȯɰ��Υ~����Ѧ�
exec sp_helpconstraint �Ȥ�

alter table �q�� nocheck constraint [FK_�Ȥ�s��_�Ȥ�]
--�ҥ�
ALTER TABLE �q�� CHECK CONSTRAINT [FK_�Ȥ�s��_�Ȥ�]
go

--�ܧ�~����ѦҳB�z�覡
ALTER TABLE �q�� DROP CONSTRAINT  [FK_�Ȥ�s��_�Ȥ�]
go

sp_helpconstraint �q��

ALTER TABLE �q�� ADD  CONSTRAINT  [FK_�Ȥ�s��_�Ȥ�] FOREIGN KEY (�Ȥ�s��) REFERENCES [�Ȥ�](�Ȥ�s��) 
  ON DELETE CASCADE
  ON UPDATE CASCADE
go

SELECT * FROM �Ȥ�
SELECT * FROM �q��

UPDATE �Ȥ� SET �Ȥ�s��=4 WHERE �Ȥ�s��=3
SELECT * FROM �Ȥ�
go



--delete AND Truncate
use master
go

if exists(select * from sys.databases where name='mydb')
drop database mydb
go

CREATE DATABASE MyDB
--�D�s�ժ������
ON primary(
	NAME=MyDB1,
	FileName='D:\DB-A1\MyDB1.mdf',	
	SIZE=5MB),

--�s�ظs�ժ������
FileGroup G1(
	NAME=MyDB_G1_1,
	FileName='D:\DB-A1\MyDB_G1_1.ndf',
	SIZE=5MB)
--�إ�Log��
Log ON (
	NAME=MyDB_Log,
	FileName='D:\DB-A1\MyDB_Log.ldf'
	)
GO



use MYDB
go


CREATE TABLE �Ȥ�1
(  �Ȥ�s��  int identity NOT NULL,
   �����Ҧr��  char(10) NOT NULL ,  
   �~��  tinyint ,
   �a�}  varchar(50),
   �q��  char(12)) on [primary]
go

CREATE TABLE �Ȥ�2
(  �Ȥ�s��  int identity NOT NULL,
   �����Ҧr��  char(10) NOT NULL ,  
   �~��  tinyint ,
   �a�}  varchar(50),
   �q��  char(12)) on G1
go

insert into �Ȥ�1 values ('a1234565',25,'a123455',null)
go 200000

insert into �Ȥ�2 values ('a1234565',25,'a123455',null)
go 200000

select * from �Ȥ�1 
select * from �Ȥ�2


Truncate table �Ȥ�1


delete from �Ȥ�2


go
sp_helpdb mydb

DBCC SHRINKFILE (MYDB1,1)

DBCC SHRINKDATABASE (mydb)



