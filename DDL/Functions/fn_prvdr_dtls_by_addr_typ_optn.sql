/**************************************
	Function to convert miles to meters
	Function Name: fn_prvdr_dtls_by_lat_lon_typ_optn
	Author: Chris Ehmett
	Last Updated: 06/20/2016
	The fn_prvdr_dtls_by_addr_typ_optn function lists 
	all providers or for only specific
	types past wihtn radius around
	address or zip passed
***************************************/
--DROP FUNCTION "OAR_OSP_DB".fn_prvdr_dtls_by_addr_typ_optn(double precision,varchar,text[])
--test select SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_addr_typ_optn(10, '18 Patton St Rochester, NH 03867', '{MD,SA}');
--test select SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_addr_typ_optn(10, '03867', '{MD,SA}');
--test select SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_addr_typ_optn10, 43.310216, -70.987599);
-- Function: "OAR_OSP_DB".fn_prvdr_dtls_by_addr_typ_optn(double precision, text, text[])


CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_prvdr_dtls_by_addr_typ_optn(
    IN _p_radius double precision,
    IN _p_addr text,
    IN _p_prvdr_typ text[] DEFAULT '{}'::text[])
  RETURNS TABLE(provider_id integer, provider_type_code character, geo_point geometry, latitude numeric, longitude numeric, provider_org_name character varying, provider_org_alias character varying, contact_title character varying, contact_first_name character varying, contact_middle_initial character, contact_last_name character varying, phone_number character, address_line_1 character varying, address_line_2 character varying, address_line_3 character varying, city character varying, state character, postal_code character) AS
$BODY$
DECLARE

_v_lon NUMERIC;
_v_lat NUMERIC;

                                                    
BEGIN

	--get lon lat from address or xip code passed and load into variable
	SELECT ST_X(g.geomout),ST_Y(g.geomout) INTO _v_lon, _v_lat
	FROM tiger.geocode(_p_addr) As g; 


	IF _p_prvdr_typ  <> '{}'::text[] THEN
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(_p_radius ,_v_lat, _v_lon,_p_prvdr_typ);
	ELSE
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(_p_radius,_v_lat, _v_lon);
	END IF;
END;  
$BODY$
  LANGUAGE plpgsql 