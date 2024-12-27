CREATE UNIQUE INDEX VMSCMS.PK_PTL_TXN_NO ON VMSCMS.PCMS_TXN_LOG_SNAP
(PTL_TXN_NO)
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


