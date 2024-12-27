CREATE OR REPLACE TRIGGER VMSCMS.trg_dateloyl_std
	BEFORE INSERT OR UPDATE ON cms_date_loyl
		FOR EACH ROW
BEGIN	--Trigger body begins
	IF INSERTING THEN
		:new.cdl_ins_date := sysdate	;
		:new.cdl_lupd_date := sysdate	;
	ELSIF UPDATING THEN
		:new.cdl_lupd_date := sysdate	;
	END IF;
END;	--Trigger body ends
/


