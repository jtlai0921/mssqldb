--�ϥ�DDL�y�k�إ߸�Ʈw�ɮ�(�w�]���|C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\)
CREATE DATABASE MyDB
GO


--�R����Ʈw
drop database MyDB
GO

--�إ߸�Ʈw�ë��w�����
CREATE DATABASE MYDB
ON(
	NAME=MYDB,
	FileName='D:\DB\MyDB2.mdf'
	)
GO 


/* �ϥ�DDL�y�k�إ߸�Ʈw�ɮ�
   �إ߸�ƮwMyDB,��Ʈw�n���G���ɮ׸s��(�t�w�]�s��),�C�s�ջݦ��@�Ӹ����,
   ����ɪ�l�e�q10MB,�C������100MB,�S���̤j����,
   �O����,��l�e�q1MB,����10%,�S���̤j����
*/ 

CREATE DATABASE MyDB4
ON primary(
	NAME=MyDB4,
	FileName='D:\DB\DATA\MyDB3.mdf',	
	SIZE=10MB,
	MAXSIZE=UNLIMITED,
	FILEGROWTH=100MB),
--�إ߸s��
FileGroup MyDB_G1(
	NAME=MyDB_G1_1,
	FileName='D:\DB\DATA\MyDB_G1_1.mdf',
	SIZE=10MB,
	MAXSIZE=UNLIMITED,
	FILEGROWTH=100MB)
--�إ�Log��
Log ON (
	NAME=MyDB_Log,
	FileName='D:\DB\DATA\MyDB3_Log.ldf',
	MAXSIZE=UNLIMITED
	)
GO

--������Ʈw
exec sp_detach_db MyDB1
go

sp_attach_db mydb3,'D:\DB\DATA\MyDB3.mdf'

--���[��Ʈw(����ɦ�m������)
CREATE DATABASE mydb
ON (FileName='D:\DB\DATA\MyDB3.mdf')
for ATTACH
go

exec sp_attach_db MyDB2 ,
	'D:\DB\DATA\MyDB3.mdf'
go 


--������Ʈw
exec sp_detach_db MyDB3
go


--���[��Ʈw(����ɦ�m������)
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




--����Ʈw�W�r
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


