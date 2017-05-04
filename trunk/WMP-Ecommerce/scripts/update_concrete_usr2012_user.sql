use mysql;
update user set Host = '127.0.0.1' where Host = '192.168.0.0/255.255.0.0' and User = 'username';
SET PASSWORD FOR 'username'@'127.0.0.1' = PASSWORD('password');
create user 'username'@'localhost' identified by 'password';
grant all on database.* to 'username'@'localhost';
flush privileges;
use database;
truncate table Logs;
truncate table DownloadStatistics;
