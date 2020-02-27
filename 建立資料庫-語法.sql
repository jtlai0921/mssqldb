--使用DDL語法建立資料庫檔案(預設路徑C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\)
CREATE DATABASE MyDB
GO


--刪除資料庫
drop database MyDB
GO

--建立資料庫並指定資料檔
CREATE DATABASE MYDB
ON(
	NAME=MYDB,
	FileName='D:\DB\MyDB2.mdf'
	)
GO 


/* 使用DDL語法建立資料庫檔案
   建立資料庫MyDB,資料庫要有二個檔案群組(含預設群組),每群組需有一個資料檔,
   資料檔初始容量10MB,每次成長100MB,沒有最大限制,
   記錄檔,初始容量1MB,成長10%,沒有最大限制
*/ 

CREATE DATABASE MyDB4
ON primary(
	NAME=MyDB4,
	FileName='D:\DB\DATA\MyDB3.mdf',	
	SIZE=10MB,
	MAXSIZE=UNLIMITED,
	FILEGROWTH=100MB),
--建立群組
FileGroup MyDB_G1(
	NAME=MyDB_G1_1,
	FileName='D:\DB\DATA\MyDB_G1_1.mdf',
	SIZE=10MB,
	MAXSIZE=UNLIMITED,
	FILEGROWTH=100MB)
--建立Log檔
Log ON (
	NAME=MyDB_Log,
	FileName='D:\DB\DATA\MyDB3_Log.ldf',
	MAXSIZE=UNLIMITED
	)
GO

--卸離資料庫
exec sp_detach_db MyDB1
go

sp_attach_db mydb3,'D:\DB\DATA\MyDB3.mdf'

--附加資料庫(資料檔位置未改變)
CREATE DATABASE mydb
ON (FileName='D:\DB\DATA\MyDB3.mdf')
for ATTACH
go

exec sp_attach_db MyDB2 ,
	'D:\DB\DATA\MyDB3.mdf'
go 


--卸離資料庫
exec sp_detach_db MyDB3
go


--附加資料庫(資料檔位置有異動)
exec sp_attach_db MyDB2 ,
	'D:\DB\MyDB1.mdf',
	'D:\DB\MyDB1_G1_1',
	'D:\DB\MyDB1_Log.ldf'
go

CREATE DATABASE mydb1
ON (FileName='D:\DB\DATA\MyDB1.mdf'),
(FileName='D:\DB\DATA\MyDB3_G1_1'),
(FileName='D:\DB\DATA\MyDB3_Log.ldf')
for ATTACH




--更改資料庫名字
ALTER DATABASE MYDB MODIFY NAME=Northwind
GO

EXEC sp_renamedb 'NORTHWIND','MYDB'
GO



EXEC sp_helpdb 
GO

EXEC sp_helpfile
GO

EXEC sp_helpfilegroup
GO


