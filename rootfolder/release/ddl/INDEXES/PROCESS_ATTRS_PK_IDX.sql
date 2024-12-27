CREATE INDEX VMSCMS.PROCESS_ATTRS_PK_IDX ON VMSCMS.DMRS_PROCESS_ATTRIBUTES
(PROCESS_OVID)
NOLOGGING
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


