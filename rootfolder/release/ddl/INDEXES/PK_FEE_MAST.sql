CREATE UNIQUE INDEX VMSCMS.PK_FEE_MAST ON VMSCMS.CMS_FEE_MAST
(CFM_INST_CODE, CFM_FEE_CODE)
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

