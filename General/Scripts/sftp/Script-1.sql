update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_codigo_invenio'::regclass;         
update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_codigo_recargas'::regclass;          
update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_flg_mf'::regclass;                  
update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_flg_qr'::regclass;                   
update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_flg_rs'::regclass;                   
update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_tipodetransaccion'::regclass;        
update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_vigente'::regclass;                  
update pg_index set indisvalid = false where indexrelid = 'idx_tb_transacciones_temporal_fechagestion'::regclass;
--REINDEX table sftpvm.tb_transacciones_temporal;