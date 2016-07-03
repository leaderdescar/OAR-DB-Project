/**************************************
	Function Name: fn_mtg_schdl_by_addr_typ_optn
	Author: Chris Ehmett
	Last Updated: 06/22/2016
	The function lists 
	all meeting or for only specific
	types past wihtin radius around
	address or city and zip passed
***************************************/

--DROP FUNCTION "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(integer,varchar,VARCHAR[])
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(10, '18 Patton St Rochester, NH 03867', '{DRA, SOS}');
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(10, 'Rochester, NH 03867', '{DRA, SOS}');
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(10, '18 Patton St Rochester, NH 03867');
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_mtg_schdl_by_addr_typ_optn(
    IN _p_radius integer,
    IN _p_addr VARCHAR,
    IN _p_mtg_typ VARCHAR[] DEFAULT '{}')
	RETURNS TABLE (Provider_ID INTEGER, Latitude NUMERIC, Longitude NUMERIC, Provider_Org_Name VARCHAR, Provider_Org_Alias VARCHAR, 
					Phone_Number CHARACTER, Address_Line_1 VARCHAR, Address_Line_2 VARCHAR, Address_Line_3 VARCHAR, City_Name VARCHAR, State CHARACTER, Postal_code CHARACTER, 
					Meeting_Type_Code CHARACTER, Meeting_Day VARCHAR, Meeting_Time TIME, Meeting_Frequency VARCHAR)
AS
$$

DECLARE

_v_lon NUMERIC;
_v_lat NUMERIC;
                               
BEGIN        

	--get lon lat from address or zip code passed and load into variable
	SELECT ST_X(g.geomout), ST_Y(g.geomout) INTO _v_lon, _v_lat
	FROM geocode(_p_addr) As g; 


	IF _p_mtg_typ  <> '{}'::VARCHAR[] THEN
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(_p_radius,_v_lat, _v_lon,_p_mtg_typ);
	ELSE
	
		RETURN QUERY SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(_p_radius,_v_lat, _v_lon);
	END IF;
END;  
$$
LANGUAGE 'plpgsql';
