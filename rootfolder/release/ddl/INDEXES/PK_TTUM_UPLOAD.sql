CREATE UNIQUE INDEX VMSCMS.PK_TTUM_UPLOAD ON VMSCMS.CMS_TTUM_UPLOAD
(CTU_INST_CODE, CTU_FILE_NAME, CTU_ROW_ID)
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

