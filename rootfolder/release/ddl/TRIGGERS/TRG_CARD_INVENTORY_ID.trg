CREATE OR REPLACE TRIGGER VMSCMS.TRG_CARD_INVENTORY_ID
      BEFORE INSERT ON VMSCMS.PCMS_CARDINVENTORY       FOR EACH ROW
BEGIN      --Trigger body begins
     select SEQ_CARD_INVENTORY_ID.NEXTVAL into :new.CARD_INVENTORY_ID from dual;
    END;       --Trigger body ends
/

