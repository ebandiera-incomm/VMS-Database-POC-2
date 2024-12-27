CREATE UNIQUE INDEX VMSCMS.PK_MONTH_LOYL ON VMSCMS.CMS_MONTH_LOYL
(CML_INST_CODE, CML_LOYL_CODE)
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


