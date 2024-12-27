CREATE OR REPLACE TRIGGER VMSCMS.trg_req_host
 BEFORE INSERT OR UPDATE ON VMSCMS.PCMS_REQ_HOST   FOR EACH ROW
BEGIN --Trigger body begins
 IF INSERTING THEN
  :NEW.PRH_ins_date := SYSDATE;
  :NEW.PRH_lupd_date := SYSDATE;
 ELSIF UPDATING THEN
  :NEW.PRH_lupd_date := SYSDATE;
 END IF;
END; --Trigger body ends
/


