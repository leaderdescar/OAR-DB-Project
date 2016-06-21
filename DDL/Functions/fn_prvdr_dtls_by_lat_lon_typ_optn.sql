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
--test select SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(10, '18 Patton St Rochester, NH 03867', '{MD,SA}');
--test select SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(10, '03867', '{MD,SA}');
--test select SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn (10, 43.310216, -70.987599);
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_prvdr_dtls_by_addr_typ_optn(
    IN _p_radius double precision,
    IN _p_addr VARCHAR,
    IN _p_prvdr_typ text[] DEFAULT '{}')
  RETURNS TABLE (Provider_Id INT,Provider_Type_Code CHAR,Geo_Point GEOMETRY(POINT,4326),Latitude NUMERIC  ,Longitude NUMERIC, Provider_Org_Name VARCHAR,
			Provider_Org_Alias VARCHAR,Contact_Title VARCHAR ,Contact_First_Name VARCHAR ,Contact_Middle_Initial CHAR,
			Contact_Last_Name VARCHAR,Phone_Number CHAR,Address_Line_1 VARCHAR ,Address_Line_2 VARCHAR ,Address_Line_3 VARCHAR,
			City VARCHAR,State CHAR,Postal_Code CHAR)
AS
$$

                               
BEGIN

DECLARE

_v_lon NUMERIC;
_v_lat NUMERIC;
_v_geom GEOMETRY;
                     

	--get lon lat from address or xip code passed and load into variable
	SELECT tiger.ST_X(g.geomout), tiger.ST_Y(g.geomout) INTO _v_lon, _v_lat
	FROM tiger.geocode(_p_addr) As g; 


	IF _p_prvdr_typ  <> '{}'::text[] THEN
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(_p_radius,_v_lat, _v_lon,_p_prvdr_typ);
	ELSE
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(_p_radius,_v_lat, _v_lon);
	END IF;
END;  
$$
LANGUAGE 'plpgsql';