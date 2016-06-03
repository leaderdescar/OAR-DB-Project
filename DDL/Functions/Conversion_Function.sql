/**************************************
	Function to convert miles to meters
	Author: Chris Ehmett
	Last Updated: 06/03/2016
***************************************/

CREATE OR REPLACE FUNCTION convert_radius (p_miles INT)
	RETURNS FLOAT
AS $$
--multiply miles by meter covnersion
Select $1 * 0.000621371;
$$ 
LANGUAGE 'plpgsql';
