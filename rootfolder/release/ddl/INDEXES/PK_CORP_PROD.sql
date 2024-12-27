CREATE UNIQUE INDEX VMSCMS.PK_CORP_PROD ON VMSCMS.PCMS_CORP_PROD
(PCP_INST_CODE, PCP_CORP_CODE, PCP_PROD_CODE, PCP_CARD_TYPE)
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

