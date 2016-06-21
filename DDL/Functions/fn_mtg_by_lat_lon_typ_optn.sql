/**************************************
	Function to convert miles to meters
	Function Name: fn_mtg_by_lat_lon_typ_optn
	Author: Chris Ehmett
	Last Updated: 06/20/2016
	The fn_mtg_by_lat_lon_typ_optn function lists 
	all meetings or for only specific
	types past wihtn radius around
	a lat and lon
***************************************/

--DROP FUNCTION "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(double precision,varchar,text[])
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn (10, '03867', '{Meeting type here}');
--test select SELECT * FROM "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn (10, 43.310216, -70.987599);
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_mtg_by_lat_lon_typ_optn(
    IN _p_radius double precision,
    IN _p_lat numeric,
	IN _p_lon numeric,
    IN _p_mtg_typ text[] DEFAULT '{}')
	RETURNS TABLE (Provider_ID INTEGER, Latitude NUMBERIC, Longitude NUMERIC, Provider_Org_Name TEXT, Provider_Org_Alias TEXT, 
					Phone_Number TEXT, Address_Line_1 TEXT, Address_Line_2 TEXT, Address_Line_3 TEXT, City_Name TEXT, State TEXT, Postal_code TEXT, 
					Meeting_Type_Code TEXT, Meeting_Day TEXT, Meeting_Time TEXT, Meeting_Frequency TEXT)
AS
$$

                               
BEGIN


	IF _p_mtg_typ  <> '{}'::text[] THEN
			RETURN QUERY SELECT
						mtg.Provider_ID, mtg.Latitude, mtg.Longitude, mtg.Provider_Org_Name, mtg.Provider_Org_Alias, 
						mtg.Phone_Number, mtg.Address_Line_1, mtg.Address_Line_2, mtg.Address_Line_3, mtg.City_Name, mtg.State, mtg.Postal_code, 
						mtg.Meeting_Type_Code, mtg.Meeting_Day, mtg.Meeting_Time, mtg.Meeting_Frequency
					FROM "OAR_OSP_DB".Provider_Meeting_Schedule_V mtg
					WHERE mtg.Meeting_Type_Code = ANY(_p_mtg_typ);
	ELSE
			RETURN QUERY SELECT
						mtg.Provider_ID, mtg.Latitude, mtg.Longitude, mtg.Provider_Org_Name, mtg.Provider_Org_Alias, 
						mtg.Phone_Number, mtg.Address_Line_1, mtg.Address_Line_2, mtg.Address_Line_3, mtg.City_Name, mtg.State, mtg.Postal_code, 
						mtg.Meeting_Type_Code, mtg.Meeting_Day, mtg.Meeting_Time, mtg.Meeting_Frequency
					FROM "OAR_OSP_DB".Provider_Meeting_Schedule_V mtg
					WHERE -- ST_DWithin function
					;
	END IF;
END;  
$$
LANGUAGE 'plpgsql';
