CREATE UNIQUE INDEX VMSCMS.PK_GROUP_PROG ON VMSCMS.CMS_GROUP_PROG
(CGP_INST_CODE, CGP_GROUP_CODE, CGP_PROG_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


