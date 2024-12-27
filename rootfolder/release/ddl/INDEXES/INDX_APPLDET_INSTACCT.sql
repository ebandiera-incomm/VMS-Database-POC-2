CREATE INDEX VMSCMS.INDX_APPLDET_INSTACCT ON VMSCMS.CMS_APPL_DET
(CAD_INST_CODE, CAD_ACCT_ID)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


