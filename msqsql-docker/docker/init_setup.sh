#!/bin/bash
#Create the url we need to get the newest backup
BACKUP_FILE=`aws s3 ls [S3_FOLDER]/[S3_SUBFOLDER]/ --recursive | sort | tail -n 1 | awk '{print $4}'`

#Download the latest *.BAK file from S3 in the backup directory
aws s3 cp s3://[folder]/$BACKUP_FILE /var/opt/mssql/backup

#Get the backfile name
BAK_FILE=`find -type f -name "*.bak"`

#Restore the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '[STRONG_PASSWORD]' -Q 'RESTORE DATABASE [DB_NAME] FROM DISK = "/var/opt/mssql/backup/'$BAK_FILE'" WITH REPLACE, MOVE "[FILE_NAME]" TO "/var/opt/mssql/data/[DB_NAME].MDF", MOVE "[DB_NAME_LOG]" TO "/var/opt/mssql/data/[DB_NAME].LDF"'

#remove downloaded files
rm $BAK_FILE

#create users for [DB_NAME] -- You can create this command in one line, I just like to separate the steps
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '[STRONG_PASSWORD]' -Q 'USE [DB_NAME] Drop USER [USER_NAME]'
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '[STRONG_PASSWORD]' -Q 'USE [DB_NAME] CREATE USER [USER_NAME] FOR LOGIN [USER_NAME]'
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '[STRONG_PASSWORD]' -Q "USE [DB_NAME] EXEC sp_addrolemember 'db_owner', '[USER_NAME]' "
