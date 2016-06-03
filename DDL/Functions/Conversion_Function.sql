/**************************************
	Function to convert miles to meters
	Function Name: fn_convert_radius
	Author: Chris Ehmett
	Last Updated: 06/03/2016
***************************************/

CREATE OR REPLACE FUNCTION fn_convert_radius (p_miles INT)
	RETURNS FLOAT
AS $$
--multiply miles by meter conversion
Select $1 * 1609.344;
$$ 
LANGUAGE 'plpgsql';
