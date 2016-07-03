/**************************************
	Function to convert miles to meters
	Function Name: fn_prvdr_wth_typ_optn
	Author: Chris Ehmett
	Last Updated: 06/20/2016
	The fn_prvdr_wth_typ_optn function lists 
	all providers or for only specific
	types past
***************************************/
--DROP FUNCTION "OAR_OSP_DB".fn_prvdr_wth_typ_optn(text[])
--SELECT * FROM "OAR_OSP_DB".fn_prvdr_wth_typ_optn  ('{MD, SA, SFST}');
--SELECT * FROM "OAR_OSP_DB".fn_prvdr_wth_typ_optn  ();
CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_prvdr_wth_typ_optn (_p_prvdr_typ text[] default '{}')
	RETURNS TABLE (Provider_Id INT,Provider_Type_Code CHAR,Geo_Point GEOMETRY(POINT,4326),Latitude NUMERIC  ,Longitude NUMERIC, Provider_Org_Name VARCHAR,
			Provider_Org_Alias VARCHAR,Contact_Title VARCHAR ,Contact_First_Name VARCHAR ,Contact_Middle_Initial CHAR,
			Contact_Last_Name VARCHAR,Phone_Number CHAR,Address_Line_1 VARCHAR ,Address_Line_2 VARCHAR ,Address_Line_3 VARCHAR,
			City VARCHAR,State CHAR,Postal_Code CHAR)
AS $$

BEGIN
	IF _p_prvdr_typ  <> '{}'::text[] THEN
			RETURN QUERY SELECT 
				prvdr.Provider_Id as Provider_Id_out, prvdr.Provider_Type_Code as Provider_Type_Code_out, 
				prvdr.Geo_Point as Geo_Point_out, prvdr.Latitude as Latitude_out, prvdr.Longitude as Longitude_out, 
				prvdr.Provider_Org_Name as Provider_Org_Name_out, prvdr.Provider_Org_Alias as Provider_Org_Name_out, prvdr.Contact_Title as Contact_Title_out, 
				prvdr.Contact_First_Name as Contact_First_Name_out, prvdr.Contact_Middle_Initial as Contact_Middle_Initial_out,
				prvdr.Contact_Last_Name as Contact_Last_Name_out, prvdr.Phone_Number as Phone_Number_out, prvdr.Address_Line_1 as Address_Line_1_out, 
				prvdr.Address_Line_2 as Address_Line_2_out, prvdr.Address_Line_3 as Address_Line_3_out,
				prvdr.City as City_out, prvdr.State as State_out, prvdr.Postal_Code as Postal_Code_out
			FROM "OAR_OSP_DB".Provider_Details_V prvdr
			WHERE prvdr.Provider_Type_Code = ANY($1);
	ELSE
			RETURN QUERY SELECT 
				prvdr.Provider_Id as Provider_Id_out, prvdr.Provider_Type_Code as Provider_Type_Code_out, 
				prvdr.Geo_Point as Geo_Point_out, prvdr.Latitude as Latitude_out, prvdr.Longitude as Longitude_out, 
				prvdr.Provider_Org_Name as Provider_Org_Name_out, prvdr.Provider_Org_Alias as Provider_Org_Name_out, prvdr.Contact_Title as Contact_Title_out, 
				prvdr.Contact_First_Name as Contact_First_Name_out, prvdr.Contact_Middle_Initial as Contact_Middle_Initial_out,
				prvdr.Contact_Last_Name as Contact_Last_Name_out, prvdr.Phone_Number as Phone_Number_out, prvdr.Address_Line_1 as Address_Line_1_out, 
				prvdr.Address_Line_2 as Address_Line_2_out, prvdr.Address_Line_3 as Address_Line_3_out,
				prvdr.City as City_out, prvdr.State as State_out, prvdr.Postal_Code as Postal_Code_out
			FROM "OAR_OSP_DB".Provider_Details_V prvdr;
	END IF;
		
END
$$ 
LANGUAGE 'plpgsql';


