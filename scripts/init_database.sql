/*
CREATING DATABASE AND SCHEMAS
*/
--create database 'Datawarehouse'
USE master;
CREATE DATABASE Datawarehouse;
USE Datawarehouse;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
