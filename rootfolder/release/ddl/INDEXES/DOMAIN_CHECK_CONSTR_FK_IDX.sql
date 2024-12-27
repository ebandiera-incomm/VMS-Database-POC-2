CREATE INDEX VMSCMS.DOMAIN_CHECK_CONSTR_FK_IDX ON VMSCMS.DMRS_DOMAIN_CHECK_CONSTRAINTS
(DOMAIN_OVID)
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

