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

-- Function: "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(double precision, numeric, numeric, text[])

-- DROP FUNCTION "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(double precision, numeric, numeric, text[]);

CREATE OR REPLACE FUNCTION "OAR_OSP_DB".fn_prvdr_dtls_by_lat_lon_typ_optn(
    IN _p_radius double precision,
    IN _p_lat numeric,
    IN _p_lon numeric,
    IN _p_prvdr_typ text[] DEFAULT '{}'::text[])
  RETURNS TABLE(provider_id integer, provider_type_code character, geo_point geometry, latitude numeric, longitude numeric, provider_org_name character varying, provider_org_alias character varying, contact_title character varying, contact_first_name character varying, contact_middle_initial character, contact_last_name character varying, phone_number character, address_line_1 character varying, address_line_2 character varying, address_line_3 character varying, city character varying, state character, postal_code character) AS
$BODY$


                                                    
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
			WHERE 
			--Seach for points with the radius of the passes lat lon, 
			-- convert lat lon to point wihtin function call with ST_GeomFromText
				ST_DWithin((GeomFromEWKT('SRID=4326;POINT(' || _p_lon || ' ' || _p_lat || ')'))::geography,
				(prvdr.Geo_Point)::geography, (SELECT "OAR_OSP_DB".fn_convert_radius(_p_radius)))
			AND prvdr.Provider_Type_Code = any(_p_prvdr_typ);
	ELSE
	
		RETURN QUERY SELECT 
				prvdr.Provider_Id as Provider_Id_out, prvdr.Provider_Type_Code as Provider_Type_Code_out, 
				prvdr.Geo_Point as Geo_Point_out, prvdr.Latitude as Latitude_out, prvdr.Longitude as Longitude_out, 
				prvdr.Provider_Org_Name as Provider_Org_Name_out, prvdr.Provider_Org_Alias as Provider_Org_Name_out, prvdr.Contact_Title as Contact_Title_out, 
				prvdr.Contact_First_Name as Contact_First_Name_out, prvdr.Contact_Middle_Initial as Contact_Middle_Initial_out,
				prvdr.Contact_Last_Name as Contact_Last_Name_out, prvdr.Phone_Number as Phone_Number_out, prvdr.Address_Line_1 as Address_Line_1_out, 
				prvdr.Address_Line_2 as Address_Line_2_out, prvdr.Address_Line_3 as Address_Line_3_out,
				prvdr.City as City_out, prvdr.State as State_out, prvdr.Postal_Code as Postal_Code_out
				FROM "OAR_OSP_DB".Provider_Details_V prvdr
				WHERE 
				--Seach for points with the radius of the passes lat lon, 
				-- convert lat lon to point wihtin function call with ST_GeomFromText
					ST_DWithin((GeomFromEWKT('SRID=4326;POINT(' || _p_lon || ' ' || _p_lat || ')'))::geography,
					(prvdr.Geo_Point)::geography, (SELECT "OAR_OSP_DB".fn_convert_radius(_p_radius)));
	END IF;
END;  
$BODY$
  LANGUAGE plpgsql
