CREATE INDEX VMSCMS.INDEX_MARCINFOENTRY_INSDATE ON VMSCMS.PCMS_MARC_INFO_ENTRY
(PMI_INS_DATE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


