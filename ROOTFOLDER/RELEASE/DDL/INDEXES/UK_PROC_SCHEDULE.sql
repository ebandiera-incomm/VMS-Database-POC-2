CREATE UNIQUE INDEX VMSCMS.UK_PROC_SCHEDULE ON VMSCMS.PCMS_PROCESS_SCHEDULE
(PPS_PROCESS_JOB, PPS_PROCESS_JOBGROUP, PPS_PROCESS_TRGR, PPS_PROCESS_TRGRGROUP)
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

