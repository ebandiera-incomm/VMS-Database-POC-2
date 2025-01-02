CREATE UNIQUE INDEX VMSCMS.PK_CPM_PROCESS_ID ON VMSCMS.CMS_PROCESS_DEFN_MAST
(CPM_PROCESS_ID)
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

