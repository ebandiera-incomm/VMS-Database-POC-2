CREATE OR REPLACE FUNCTION VMSCMS.FN_OUR_TO_DATE(TRDT VARCHAR2) RETURN NUMBER
AS
F_DT DATE ;
BEGIN
	F_DT := TO_DATE(TRDT,'YYMMDD');
	RETURN 1;
EXCEPTION
	WHEN OTHERS THEN
	RETURN 0;
END;
/


show error