CREATE OR REPLACE TRIGGER VMSCMS."TRG_REISSINPUT_STD" BEFORE
INSERT ON  "CMS_REISSUE_INPUT" FOR EACH ROW
BEGIN --Trigger body begins
 IF INSERTING THEN
  :NEW.CRI_INS_DATE   := SYSDATE;
 END IF;
END; --Trigger body ends;
/

