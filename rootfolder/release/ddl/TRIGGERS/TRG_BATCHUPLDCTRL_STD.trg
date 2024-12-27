CREATE OR REPLACE TRIGGER VMSCMS.TRG_BATCHUPLDCTRL_STD
    BEFORE INSERT OR UPDATE ON VMSCMS.CMS_BATCHPROCESS_CTRL         FOR EACH ROW
BEGIN    --Trigger body begins
    IF INSERTING THEN
        :NEW.CBC_PROCESS_DATE   := SYSDATE;
    END IF;
END;    --Trigger body ends
/


