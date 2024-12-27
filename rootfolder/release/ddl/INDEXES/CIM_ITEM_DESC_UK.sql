CREATE UNIQUE INDEX VMSCMS.CIM_ITEM_DESC_UK ON VMSCMS.CMS_ITEM_MAST
(CIM_ITEM_DESC)
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


