CREATE OR REPLACE TRIGGER VMSCMS.TRG_SHFL_CNTRL
    BEFORE INSERT OR UPDATE ON VMSCMS.CMS_SHFL_CNTRL         FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.CSC_INS_DATE := sysdate;
    ELSIF UPDATING THEN
        :new.CSC_LUPD_DATE := sysdate;
    END IF;
END;
/
SHOW ERRORS;


