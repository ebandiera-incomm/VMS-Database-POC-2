CREATE UNIQUE INDEX VMSCMS.PK_PROD_MAST ON VMSCMS.CMS_PROD_MAST
(CPM_INST_CODE, CPM_PROD_CODE)
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


