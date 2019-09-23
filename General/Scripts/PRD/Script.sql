select
	TRANSACTIONTYPE,
	*
from
	XZEDI.dbo.TMP_CAPTURE (nolock);

SELECT
	top 500 datestamp,
	RESPONSE AS 'respuestaSwitch',
	ADDITIONALDATA,
	STUFF(FROMACCTNUM,
	5,
	8,
	'****') as 'PAN',
	AMOUNTTRANS as 'montoTrx',
	CASE
		TRANSACTIONTYPE
		WHEN 'S' THEN 'VENTA'
		WHEN 'R' THEN 'ANULACION'
		ELSE ''
	END as tipoProceso,
	CARDACQID as 'NBO',
	ALTERNATECARDACQID as 'PMP',
	CARDACQNAME AS 'nombreComercio',
	TERMINALID as 'terminalSerie',
	TRANSACTIONID as 'idUnico',
	AUTHIDRESPONSE,
	RETRIEVALREFNO,
	SYSTEMTRACENO,
	CASE
		POSENTRYMODE
		WHEN 051 THEN 'CHIP'
		WHEN 021 THEN 'BANDA'
		WHEN 071 THEN 'NFC'
		WHEN 921 THEN 'BANDA F'
		WHEN 911 THEN 'NFC F'
		ELSE POSENTRYMODE
	END as metodoCaptura,
	ACCOUNTID2 as 'dni',
	SIGNATURE as 'firma'
from
	XZEDI.dbo.TMP_CAPTURE (nolock)
where
	NII = '008'
	--AND RESPONSECODE = '00' AND REVERSED = '0'
	--AND upper(RESPONSE) not LIKE UPPER('%ap%')
	and FROMACCTNUM not like '4%'
	--and CARDACQID = '001105563'

	ORDER BY DATESTAMP desc;

select
	--distinct 
	--fecha_registro as fecha,
	--ws_geo_request,
	distinct (select fullSerialNumber from openjson(ws_geo_request) with (fullSerialNumber varchar(100))) as fullSerialNumber
	--ws_geo_response,
	--ws_geo_responsecode,
	--ws_geo_responseDatacode,
	--*
from
	XZEDI.dbo.LOG_TRX_GEOPAGOS (nolock)
where
	ws_geo_responsecode = 400
	--and fecha_registro >= '2019-09-22 00:00:00'
	and ws_geo_response like '%Lector no encontrado%'
--order by
--	fecha_registro desc
;

select distinct 
	--DATESTAMP as fecha,
	--ALTERNATETERMINALID,
	CARDACQID,
	CARDACQNAME
	--*
from
	XZEDI.dbo.TMP_CAPTURE (nolock)
where
	ALTERNATETERMINALID in 
	('60632515',
'60632645',
'60632884',
'60632889',
'60633357',
'60633772',
'60633781',
'60634103',
'60634450',
'60634493',
'60634569',
'60634803',
'60635046',
'60635148',
'60635271',
'60689267',
'60689361',
'60689386',
'60689575',
'60690449',
'60691415',
'60692411',
'60693392',
'60693680',
'60693721',
'60694186',
'6K298075');





