CREATE UNIQUE INDEX VMSCMS.UK_PROFILEMAST_PROFILENAME ON VMSCMS.CMS_PROFILE_MAST
(CPM_INST_CODE, CPM_PROFILE_NAME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

