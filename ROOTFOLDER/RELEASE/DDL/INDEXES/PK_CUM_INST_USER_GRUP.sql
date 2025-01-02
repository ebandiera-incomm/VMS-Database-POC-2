CREATE UNIQUE INDEX VMSCMS.PK_CUM_INST_USER_GRUP ON VMSCMS.CMS_USGPDETL_MAST
(CUM_INST_CODE, CUM_USER_CODE, CUM_GRUP_CODE)
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

