CREATE TABLE vmscms.VMS_RULESET_MAST
(
	VRS_RULESET_ID NUMBER(9) NOT NULL ,
	VRS_RULESET_NAME VARCHAR2(50) NOT NULL , 
	VRS_INS_USER NUMBER(5) NOT NULL , 
	VRS_INS_DATE DATE NOT NULL , 
	VRS_LUPD_USER NUMBER(5), 
	VRS_LUPD_DATE DATE,
	CONSTRAINT PK_RULESET_ID PRIMARY KEY (VRS_RULESET_ID)
);