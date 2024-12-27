CREATE UNIQUE INDEX VMSCMS.PK_MERCCATG_LOYL ON VMSCMS.CMS_MERCCATG_LOYL
(CML_INST_CODE, CML_LOYL_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


