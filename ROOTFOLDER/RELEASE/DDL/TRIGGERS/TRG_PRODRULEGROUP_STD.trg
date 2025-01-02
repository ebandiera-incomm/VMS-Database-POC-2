CREATE OR REPLACE TRIGGER VMSCMS.trg_prodrulegroup_std
 BEFORE INSERT OR UPDATE ON VMSCMS.PCMS_PROD_RULEGROUP   FOR EACH ROW
BEGIN --Trigger body begins
IF INSERTING THEN
 :NEW.ppr_ins_date := SYSDATE;
 :NEW.ppr_lupd_date := SYSDATE;
ELSIF UPDATING THEN
 :NEW.ppr_lupd_date := SYSDATE;
END IF;
END;
/

