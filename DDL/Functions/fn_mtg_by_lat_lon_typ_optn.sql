/**************************************
	Function to convert miles to meters
	Function Name: fn_mtg_by_lat_lon_typ_optn
	Author: Chris Ehmett
	Last Updated: 06/22/2016
	The fn_mtg_by_lat_lon_typ_optn function lists 
	all meetings or for only specific
	types past wihtn radius around
	a lat and lon
***************************************/

--DROP FUNCTION "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(integer,varchar,text[])
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn (10, 43.310216, -70.987599, '{DRA}');
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn (10, 43.310216, -70.987599);
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(
    IN _p_radius integer,
    IN _p_lat numeric,
	IN _p_lon numeric,
    IN _p_mtg_typ text[] DEFAULT '{}')
	RETURNS TABLE (Provider_ID INTEGER, Latitude NUMERIC, Longitude NUMERIC, Provider_Org_Name VARCHAR, Provider_Org_Alias VARCHAR, 
					Phone_Number CHARACTER, Address_Line_1 VARCHAR, Address_Line_2 VARCHAR, Address_Line_3 VARCHAR, City_Name VARCHAR, State CHARACTER, Postal_code CHARACTER, 
					Meeting_Type_Code CHARACTER, Meeting_Day VARCHAR, Meeting_Time TIME, Meeting_Frequency VARCHAR)
AS
$$

                               
BEGIN


	IF _p_mtg_typ  <> '{}'::text[] THEN
			RETURN QUERY SELECT
						mtg.Provider_ID, mtg.Latitude, mtg.Longitude, mtg.Provider_Org_Name, mtg.Provider_Org_Alias, 
						mtg.Phone_Number, mtg.Address_Line_1, mtg.Address_Line_2, mtg.Address_Line_3, mtg.City_Name, mtg.State, mtg.Postal_code, 
						mtg.Meeting_Type_Code, mtg.Meeting_Day, mtg.Meeting_Time, mtg.Meeting_Frequency
					FROM "OAR_OSP_DB".Provider_Meeting_Schedule_V mtg
					WHERE mtg.Meeting_Type_Code = ANY(_p_mtg_typ)
					AND ST_DWithin((GeomFromEWKT('SRID=4326;POINT(' || _p_lon || ' ' || _p_lat || ')'))::geography,
						(mtg.Geo_Point)::geography, (SELECT "OAR_OSP_DB".fn_convert_radius(_p_radius)));
	ELSE
			RETURN QUERY SELECT
						mtg.Provider_ID, mtg.Latitude, mtg.Longitude, mtg.Provider_Org_Name, mtg.Provider_Org_Alias, 
						mtg.Phone_Number, mtg.Address_Line_1, mtg.Address_Line_2, mtg.Address_Line_3, mtg.City_Name, mtg.State, mtg.Postal_code, 
						mtg.Meeting_Type_Code, mtg.Meeting_Day, mtg.Meeting_Time, mtg.Meeting_Frequency
					FROM "OAR_OSP_DB".Provider_Meeting_Schedule_V mtg
					WHERE ST_DWithin((GeomFromEWKT('SRID=4326;POINT(' || _p_lon || ' ' || _p_lat || ')'))::geography,
						(mtg.Geo_Point)::geography, (SELECT "OAR_OSP_DB".fn_convert_radius(_p_radius)));
	END IF;
END;  
$$
LANGUAGE 'plpgsql';
