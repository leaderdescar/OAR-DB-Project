/**************************************
	Function Name: fn_mtg_schdl_wth_typ_optn 
	Author: Chris Ehmett
	Last Updated: 06/21/2016
	The fn_mtg_schdl_wth_typ_optn function lists 
	all providers or for only specific
	types past
***************************************/
--DROP FUNCTION "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn(text[])
--SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn  ('{MD, SA, SFST}');
--SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn  ();
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn (_p_mtg_typ text[] default '{}')
	RETURNS TABLE (Provider_ID INTEGER, Latitude NUMBERIC, Longitude NUMERIC, Provider_Org_Name TEXT, Provider_Org_Alias TEXT, 
					Phone_Number TEXT, Address_Line_1 TEXT, Address_Line_2 TEXT, Address_Line_3 TEXT, City_Name TEXT, State TEXT, Postal_code TEXT, 
					Meeting_Type_Code TEXT, Meeting_Day TEXT, Meeting_Time TEXT, Meeting_Frequency TEXT)
AS $$

BEGIN
	IF _p_mtg_typ  <> '{}'::text[] THEN
			RETURN QUERY SELECT
						mtg.Provider_ID, mtg.Latitude, mtg.Longitude, mtg.Provider_Org_Name, mtg.Provider_Org_Alias, 
						mtg.Phone_Number, mtg.Address_Line_1, mtg.Address_Line_2, mtg.Address_Line_3, mtg.City_Name, mtg.State, mtg.Postal_code, 
						mtg.Meeting_Type_Code, mtg.Meeting_Day, mtg.Meeting_Time, mtg.Meeting_Frequency
					FROM "OAR_OSP_DB".Provider_Meeting_Schedule_V mtg
					WHERE mtg.Meeting_Type_Code = ANY($1);
	ELSE
			RETURN QUERY SELECT
						mtg.Provider_ID, mtg.Latitude, mtg.Longitude, mtg.Provider_Org_Name, mtg.Provider_Org_Alias, 
						mtg.Phone_Number, mtg.Address_Line_1, mtg.Address_Line_2, mtg.Address_Line_3, mtg.City_Name, mtg.State, mtg.Postal_code, 
						mtg.Meeting_Type_Code, mtg.Meeting_Day, mtg.Meeting_Time, mtg.Meeting_Frequency
					FROM "OAR_OSP_DB".Provider_Meeting_Schedule_V mtg;
	END IF;
		
END
$$ 
LANGUAGE 'plpgsql';


