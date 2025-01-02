CREATE UNIQUE INDEX VMSCMS.PK_USER_MAST ON VMSCMS.CMS_USER_MAST
(CUM_INST_CODE, CUM_USER_CODE)
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

