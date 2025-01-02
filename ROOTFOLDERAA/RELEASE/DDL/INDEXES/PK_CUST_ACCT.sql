CREATE UNIQUE INDEX VMSCMS.PK_CUST_ACCT ON VMSCMS.CMS_CUST_ACCT
(CCA_INST_CODE, CCA_CUST_CODE, CCA_ACCT_ID)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          3M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

