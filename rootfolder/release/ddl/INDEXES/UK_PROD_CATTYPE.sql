CREATE UNIQUE INDEX VMSCMS.UK_PROD_CATTYPE ON VMSCMS.CMS_PROD_CATTYPE
(CPC_INST_CODE, CPC_PROD_CODE, CPC_CARDTYPE_DESC)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

