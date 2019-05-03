use mykeyspace;

-- Converti un timestamp en format date et retourne un chaine de caractere

CREATE OR REPLACE FUNCTION timestamp_as_date_string ( input timestamp)
RETURNS NULL ON NULL INPUT
RETURNS text
LANGUAGE java
AS '
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(input);
';



