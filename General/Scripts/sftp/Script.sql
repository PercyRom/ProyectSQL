select  fechacreacion,vigente,fechaGestion, * from sftpvm.tb_transacciones_temporal order by 1;
select * from sftpvm.tb_historial_archivos where tipo = 'T'  order by 1;

select sftpvm.sp_sftpvm_historial_archivos(2,'transacciones_20190524_000001.txt','T',now(),now(),'S');

update sftpvm.tb_historial_archivos set flg_vigente='S' where tipo='T' and nombre_archivo like '%' || '20190524' || '%';
update sftpvm.tb_transacciones_temporal set vigente='N' where fechaGestion in ('2019-05-24 00:00:00');-- to_timestamp(coalesce(btrim('24/05/2019'),''), 'DD/MM/YYYY');


select to_timestamp(coalesce(btrim('20190524'),''), 'YYYYMMDD');

select sftpvm.sp_anular_transacciones('20190524','S');

update sftpvm.tb_transacciones_temporal set vigente = 'S',sc = 0 where fechaGestion = to_timestamp(coalesce(btrim('24/05/2019'),''), 'DD/MM/YYYY');
select count(*)from sftpvm.tb_transacciones_temporal where fechaGestion = to_timestamp(coalesce(btrim('24/05/2019'),''), 'DD/MM/YYYY');;
 

select count(*) from sftpvm.tb_transacciones_temporal;

select codigonbo,representantelegal,emailrl,nombrecomercio,* from sftpvm.tb_comercios where codigonbo = '840807139';



CREATE INDEX idx_comercio_codigonbo ON sftpvm.tb_comercios(codigonbo);

select codigonbo,representantelegal,emailrl,nombrecomercio from sftpvm.tb_comercios where codigonbo = '840807139';

begin;
select sftpvm.sp_sftp_comercio_obtenerdatos('840807139');
fetch all in "<unnamed portal 5>";
commit;


