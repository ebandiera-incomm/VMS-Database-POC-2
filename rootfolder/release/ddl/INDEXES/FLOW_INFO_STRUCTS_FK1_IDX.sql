CREATE INDEX VMSCMS.FLOW_INFO_STRUCTS_FK1_IDX ON VMSCMS.DMRS_FLOW_INFO_STRUCTURES
(FLOW_OVID)
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


