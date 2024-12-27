CREATE INDEX VMSCMS.CPT_INST_IDX ON VMSCMS.CMS_PAN_TRANS
(CPT_INST_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

