/**************************************
	Function to convert miles to meters
	Function Name: fn_prvdr_dtls_by_lat_lon_typ_optn
	Author: Chris Ehmett
	Last Updated: 06/20/2016
	The fn_prvdr_dtls_by_addr_typ_optn function lists 
	all meeting or for only specific
	types past wihtin radius around
	address or zip passed
***************************************/

--DROP FUNCTION "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(double precision,varchar,text[])
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(10, '18 Patton St Rochester, NH 03867', '{meeting type}');
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(10, '03867', '{meeting type}');
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn (10, 43.310216, -70.987599);
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(
    IN _p_radius double precision,
    IN _p_addr VARCHAR,
    IN _p_mtg_typ text[] DEFAULT '{}')
  RETURNS TABLE (Provider_ID INTEGER, Latitude NUMBERIC, Longitude NUMERIC, Provider_Org_Name TEXT, Provider_Org_Alias TEXT, 
					Phone_Number TEXT, Address_Line_1 TEXT, Address_Line_2 TEXT, Address_Line_3 TEXT, City_Name TEXT, State TEXT, Postal_code TEXT, 
					Meeting_Type_Code TEXT, Meeting_Day TEXT, Meeting_Time TEXT, Meeting_Frequency TEXT)
AS
$$

DECLARE

_v_lon NUMERIC;
_v_lat NUMERIC;
                               
BEGIN        

	--get lon lat from address or zip code passed and load into variable
	SELECT tiger.ST_X(g.geomout), tiger.ST_Y(g.geomout) INTO _v_lon, _v_lat
	FROM tiger.geocode(_p_addr) As g; 


	IF _p_prvdr_typ  <> '{}'::text[] THEN
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(_p_radius,_v_lat, _v_lon,_p_mtg_typ);
	ELSE
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(_p_radius,_v_lat, _v_lon);
	END IF;
END;  
$$
LANGUAGE 'plpgsql';