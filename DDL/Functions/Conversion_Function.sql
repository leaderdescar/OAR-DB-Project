/**************************************
	Function to convert miles to meters
	Function Name: fn_convert_radius
	Author: Chris Ehmett
	Last Updated: 06/05/2016
***************************************/

CREATE OR REPLACE FUNCTION "OAR_ASP_DB".fn_convert_radius (p_miles INT)
	RETURNS FLOAT
AS $$
BEGIN
--multiply miles by meter conversion
RETURN $1 * 1609.344;
END
$$ 
LANGUAGE 'plpgsql';



--Test slq
---SELECT fn_convert_radius(25);
