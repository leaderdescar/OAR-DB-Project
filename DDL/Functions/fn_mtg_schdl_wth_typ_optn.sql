/**************************************
	Function Name: fn_mtg_schdl_wth_typ_optn 
	Author: Chris Ehmett
	Last Updated: 06/22/2016
	The fn_mtg_schdl_wth_typ_optn function lists 
	all providers or for only specific
	types past
***************************************/
--DROP FUNCTION "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn(TEXT[])
--SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn  ('{DRA, SOS}');
--SELECT * FROM "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn  ();
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_mtg_schdl_wth_typ_optn (_p_mtg_typ TEXT[] default '{}')
	RETURNS TABLE (Provider_ID INTEGER, Latitude NUMERIC, Longitude NUMERIC, Provider_Org_Name VARCHAR, Provider_Org_Alias VARCHAR, 
					Phone_Number CHARACTER, Address_Line_1 VARCHAR, Address_Line_2 VARCHAR, Address_Line_3 VARCHAR, City_Name VARCHAR, State CHARACTER, Postal_code CHARACTER, 
					Meeting_Type_Code CHARACTER, Meeting_Day VARCHAR, Meeting_Time TIME, Meeting_Frequency VARCHAR)
AS $$

BEGIN
	IF _p_mtg_typ  <> '{}'::TEXT[] THEN
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
