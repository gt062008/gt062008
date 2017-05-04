create database authorhub;
create user ah_admin@'%' identified by 'password';
grant all on authorhub.* to ah_admin@'%';
flush privileges;
use authorhub;
