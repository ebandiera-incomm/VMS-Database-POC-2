CREATE INDEX VMSCMS.IND_CGR_NEWPAN_CODE ON VMSCMS.CMS_GROUP_REISSUE
(CGR_NEWPAN_CODE)
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


