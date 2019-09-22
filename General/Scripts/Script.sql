begin;
select sch_demo.sp_authorization_find_user('Juan','123456');
fetch all in "<unnamed portal 1>";
commit;