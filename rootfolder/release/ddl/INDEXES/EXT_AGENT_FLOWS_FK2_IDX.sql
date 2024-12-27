CREATE INDEX VMSCMS.EXT_AGENT_FLOWS_FK2_IDX ON VMSCMS.DMRS_EXT_AGENT_FLOWS
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


