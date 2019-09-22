CREATE OR REPLACE FUNCTION sch_weblogistica.sp_entidad_contactos_byId(
		vv_identidad integer, 
		OUT vc_resultado refcursor, 
		OUT vv_message character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
BEGIN
/**
 * Autor	: PROMERO
 * Date 	: 18-05-2019
 * Comment 	: retorna todos los contactos de la entidad
 */

	OPEN vc_resultado FOR
	
		SELECT 
			identidadcontacto, 
			identidad, 
			apellidopaterno, 
			apellidomaterno, 
			nombres, 
			idtipodocumentoidentidad, 
			documentoidentidad, 
			telefonocontacto, 
			idusuariocreacion, 
			fechacreacion, 
			idusuariomodifica, 
			fechamodifica
		FROM 
			sch_weblogistica.tb_entidad_contactos
		WHERE 	
			identidad = vv_identidad;

EXCEPTION
		WHEN OTHERS THEN
			vv_message := '[ERROR][sch_weblogistica.sp_entidad_contactos_byId]';
			vv_message := vv_message ||'[SQLERRM]['||sqlerrm||']';
END;
$function$
;
