CREATE INDEX VMSCMS.IND_CPA_PAN_CODE_HIST ON VMSCMS.CMS_PAN_ACCT_HIST
(CPA_PAN_CODE)
LOGGING
TABLESPACE CMS_BIG_IDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          10M
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

