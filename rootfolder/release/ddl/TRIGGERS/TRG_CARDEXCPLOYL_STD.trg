CREATE OR REPLACE TRIGGER VMSCMS.trg_cardexcployl_std
	BEFORE INSERT OR UPDATE ON cms_card_excployl
		FOR EACH ROW
BEGIN	--Trigger body begins
	IF INSERTING THEN
		:new.cce_ins_date := sysdate;
		:new.cce_lupd_date := sysdate;
	ELSIF UPDATING THEN
		:new.cce_lupd_date := sysdate;
	END IF;
END;	--Trigger body ends
/


