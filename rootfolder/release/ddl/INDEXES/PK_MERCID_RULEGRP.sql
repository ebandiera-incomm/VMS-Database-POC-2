CREATE UNIQUE INDEX VMSCMS.PK_MERCID_RULEGRP ON VMSCMS.CMS_MERCID_RULEGRP
(CMR_MERC_GRPCODE)
LOGGING
TABLESPACE INCOMM
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


