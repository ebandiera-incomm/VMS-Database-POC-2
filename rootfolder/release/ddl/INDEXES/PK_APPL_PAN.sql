CREATE UNIQUE INDEX VMSCMS.PK_APPL_PAN ON VMSCMS.CMS_APPL_PAN
(CAP_PAN_CODE, CAP_MBR_NUMB)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


