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

SELECT id FROM OPENJSON ('{ "id" : 122}') WITH (id integer);
SELECT fullSerialNumber FROM OPENJSON ('{"type":"SALE","entryMode":"EMV","merchantIdentifier":"602370409","nbo":"849863346","responseCode":"APPROVED","externalResponseCode":"000","responseMessage":"Approved 239946 (000)","authorizationCode":"239946","traceNumber":"456007","processorId":"991192653749016","referenceNumber":"926522183410","localDateTime":1569208715000,"fullSerialNumber":"60689267","amount":18.00,"currency":604,"installments":1,"cardNumber":"4557********1141","cardHolderName":"","holderIdentificationType":"","holderIdentificationNumber":"","latitude":0.0,"longitude":0.0}') WITH (fullSerialNumber varchar(1000));

select
	fecha_registro as fecha,
	ws_geo_request,
	(select fullSerialNumber from openjson(ws_geo_request) with (fullSerialNumber varchar(100))) as fullSerialNumber,
	ws_geo_response,
	ws_geo_responsecode,
	ws_geo_responseDatacode,
	*
from
	XZEDI.dbo.LOG_TRX_GEOPAGOS (nolock)
where
	ws_geo_responsecode = 400
	and fecha_registro >= '2019-09-22 00:00:00'
	and ws_geo_response like '%Lector no encontrado%'
order by
	fecha_registro desc;

select
	DATESTAMP as fecha,
	ALTERNATETERMINALID,
	CARDACQID,
	CARDACQNAME,
	*
from
	XZEDI.dbo.TMP_CAPTURE (nolock)
where
	ALTERNATETERMINALID = '60635271'
order by
	DATESTAMP desc;



