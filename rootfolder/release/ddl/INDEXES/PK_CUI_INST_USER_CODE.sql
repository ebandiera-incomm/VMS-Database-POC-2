CREATE UNIQUE INDEX VMSCMS.PK_CUI_INST_USER_CODE ON VMSCMS.CMS_USER_INST
(CUI_INST_CODE, CUI_USER_CODE)
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


