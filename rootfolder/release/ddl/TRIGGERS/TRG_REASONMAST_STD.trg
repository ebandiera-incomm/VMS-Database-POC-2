CREATE OR REPLACE TRIGGER VMSCMS.trg_reasonmast_std
	BEFORE INSERT OR UPDATE ON cms_reason_mast
		FOR EACH ROW
BEGIN	--Trigger body begins
	IF INSERTING THEN
		:new.crm_ins_date	:= sysdate	;
		:new.crm_lupd_date := sysdate	;
	ELSIF UPDATING THEN
		:new.crm_lupd_date := sysdate	;
	END IF;
END;	--Trigger body ends
/


