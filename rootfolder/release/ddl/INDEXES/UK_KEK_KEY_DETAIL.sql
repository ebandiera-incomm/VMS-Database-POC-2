CREATE UNIQUE INDEX VMSCMS.UK_KEK_KEY_DETAIL ON VMSCMS.CMS_KEK_KEY_DETAIL
(CKK_INST_CODE, CKK_KEK_NAME)
LOGGING
TABLESPACE CMS_MAST
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


