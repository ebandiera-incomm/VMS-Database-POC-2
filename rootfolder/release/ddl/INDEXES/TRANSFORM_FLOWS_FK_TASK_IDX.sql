CREATE INDEX VMSCMS.TRANSFORM_FLOWS_FK_TASK_IDX ON VMSCMS.DMRS_TRANSFORMATION_FLOWS
(TRANSFORMATION_TASK_OVID)
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


