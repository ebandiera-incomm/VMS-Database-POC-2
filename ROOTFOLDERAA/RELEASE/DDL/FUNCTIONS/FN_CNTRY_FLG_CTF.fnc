CREATE OR REPLACE FUNCTION VMSCMS.FN_CNTRY_FLG_CTF (
   SRC_CRNCY_CDE IN VARCHAR2)
   RETURN VARCHAR2
AS
   FLG   VARCHAR2 (5);
BEGIN
   FLG := 'INT';

   IF SRC_CRNCY_CDE = '356' OR SRC_CRNCY_CDE = '524'
   THEN
      FLG := 'DOM';
   END IF;

   RETURN FLG;
END;
/

SHOW ERROR