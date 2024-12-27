CREATE OR REPLACE PROCEDURE VMSCMS.SP_INS_HOSTONUS_IBR(ERRMSG OUT VARCHAR2) IS
-- Minus amt Records
CURSOR c_Rev IS SELECT RHB_PAN_CODE,RHB_RETREF_NUMB ,RHB_TRANS_AMT, RHB_REC_TYPE,ROWID FROM REC_HOST_BASE2ONUS_IBR_TEMP WHERE RHB_MESG_TYPE = '0420' ;
c_Rowid VARCHAR2(25);
c_No_trans NUMBER(4);
c_amt   NUMBER(10);
BEGIN
	ERRMSG:= 'OK';
  DELETE FROM REC_HOST_BASE2ONUS_IBR_R_TEMP;
	FOR X IN c_rev LOOP
			-- Find corrsponding positive Trans
			SELECT MAX(ROWID), COUNT(*)  INTO c_Rowid , c_No_trans FROM REC_HOST_BASE2ONUS_IBR_TEMP
			WHERE RHB_PAN_CODE = X.RHB_PAN_CODE
			AND RHB_RETREF_NUMB  = X.RHB_RETREF_NUMB AND RHB_MESG_TYPE = '0210'
			AND RHB_REC_TYPE  = X.RHB_REC_TYPE;
			IF c_No_trans >= 1 THEN
				SELECT  RHB_TRANS_AMT - x.RHB_TRANS_AMT  INTO c_amt FROM REC_HOST_BASE2ONUS_IBR_TEMP WHERE ROWID = c_Rowid;
					UPDATE REC_HOST_BASE2ONUS_IBR_TEMP SET RHB_REV_FLAG = 'Y' WHERE ROWID = c_Rowid;
					IF c_Amt = 0 THEN
						UPDATE REC_HOST_BASE2ONUS_IBR_TEMP SET RHB_REV_FLAG = 'Y' WHERE ROWID = X.ROWID;
					ELSE
						UPDATE REC_HOST_BASE2ONUS_IBR_TEMP SET RHB_MESG_TYPE = '0220', RHB_TRANS_AMT = C_AMT WHERE ROWID = X.ROWID;
					END IF;
			ELSE
				-- Find Orignal In Host_sms Table Then Move Rev and Orignal Trans to REv TEmp Table
				SELECT MAX(ROWID) INTO c_RowID FROM REC_HOST_BASE2ONUS_IBR
				WHERE RHB_PAN_CODE = X.RHB_PAN_CODE
				AND RHB_RETREF_NUMB  = X.RHB_RETREF_NUMB AND RHB_MESG_TYPE = '0210'
				AND RHB_REV_FLAG = 'N' AND RHB_REC_TYPE = X.RHB_REC_TYPE ;
				IF c_RowId IS NOT NULL THEN
					SELECT RHB_TRANS_AMT - x.RHB_TRANS_AMT  INTO c_amt FROM REC_HOST_BASE2ONUS_IBR WHERE ROWID = c_Rowid;
					INSERT INTO REC_HOST_BASE2ONUS_IBR_R_TEMP
						(
						RHB_PAN_CODE  ,RHB_MBR_NUMB  ,RHB_ACCT_NO   ,RHB_RETREF_NUMB ,RHB_MESG_TYPE ,RHB_TRANS_AMT
						,RHB_REC_TYPE  ,RHB_TRAN_DATE ,RHB_TRANS_TIME  ,RHB_TERM_ID  ,RHB_FILE_NAME ,RHB_RECON_FLAG
						,RHB_CRNCY_CODE ,RHB_TXN_CODE  ,RHB_TRANS_AMT_ORG  ,RHB_ERR_FLAG ,RHB_REC_GEN
						,RHB_LUPD_DAT ,RHB_MAN_REC   ,RHB_REV_FLAG  ,RHB_NARRATION
						)
					SELECT
						RHB_PAN_CODE  ,RHB_MBR_NUMB  ,RHB_ACCT_NO   ,RHB_RETREF_NUMB ,RHB_MESG_TYPE ,RHB_TRANS_AMT
						,RHB_REC_TYPE  ,RHB_TRAN_DATE ,RHB_TRANS_TIME  ,RHB_TERM_ID  ,RHB_FILE_NAME ,RHB_RECON_FLAG
						,RHB_CRNCY_CODE ,RHB_TXN_CODE  ,RHB_TRANS_AMT_ORG  ,RHB_ERR_FLAG ,RHB_REC_GEN
						,RHB_LUPD_DAT ,RHB_MAN_REC   ,RHB_REV_FLAG  ,RHB_NARRATION
					FROM REC_HOST_BASE2ONUS_IBR WHERE ROWID = C_Rowid;
					DELETE FROM REC_HOST_BASE2ONUS_IBR WHERE ROWID = C_Rowid;
					IF c_Amt = 0 THEN
						UPDATE REC_HOST_BASE2ONUS_IBR_TEMP SET RHB_REV_FLAG = 'Y' WHERE ROWID = X.ROWID;
					ELSE
						UPDATE REC_HOST_BASE2ONUS_IBR_TEMP SET RHB_MESG_TYPE = '0220', RHB_TRANS_AMT = C_AMT WHERE ROWID = X.ROWID;
					END IF;
				END IF;
			END IF;
	END LOOP;
	-- INSERT ONLY VALID OR PROPER TRANS
	INSERT INTO REC_HOST_BASE2ONUS_IBR (
		 RHB_PAN_CODE           ,RHB_MBR_NUMB           ,RHB_ACCT_NO            ,RHB_RETREF_NUMB
		,RHB_MESG_TYPE          ,RHB_TRANS_AMT          ,RHB_REC_TYPE           ,RHB_TRAN_DATE
		,RHB_TRANS_TIME         ,RHB_TERM_ID            ,RHB_FILE_NAME          ,RHB_RECON_FLAG
		,RHB_CRNCY_CODE         ,RHB_TXN_CODE           ,RHB_TRANS_AMT_ORG	,RHB_ERR_FLAG
		,RHB_REC_GEN            ,RHB_LUPD_DAT           ,RHB_MAN_REC
				)
	SELECT
		 RHB_PAN_CODE           ,RHB_MBR_NUMB           ,RHB_ACCT_NO            ,RHB_RETREF_NUMB
		,RHB_MESG_TYPE          ,RHB_TRANS_AMT          ,RHB_REC_TYPE           ,RHB_TRAN_DATE
		,RHB_TRANS_TIME         ,RHB_TERM_ID            ,RHB_FILE_NAME          ,RHB_RECON_FLAG
		,RHB_CRNCY_CODE         ,RHB_TXN_CODE           ,RHB_TRANS_AMT_ORG	,RHB_ERR_FLAG
		,RHB_REC_GEN            ,RHB_LUPD_DAT           ,RHB_MAN_REC
	 FROM REC_HOST_BASE2ONUS_IBR_TEMP
	 WHERE RHB_REV_FLAG = 'N' AND RHB_RETREF_NUMB IS NOT NULL;
	-- INSERT ALL Y MARKED TRANS TO
	INSERT INTO REC_HOST_BASE2ONUS_IBR_R_TEMP
	(
		RHB_PAN_CODE  ,RHB_MBR_NUMB  ,RHB_ACCT_NO   ,RHB_RETREF_NUMB ,RHB_MESG_TYPE ,RHB_TRANS_AMT
		,RHB_REC_TYPE  ,RHB_TRAN_DATE ,RHB_TRANS_TIME  ,RHB_TERM_ID  ,RHB_FILE_NAME ,RHB_RECON_FLAG
		,RHB_CRNCY_CODE ,RHB_TXN_CODE  ,RHB_TRANS_AMT_ORG  ,RHB_ERR_FLAG ,RHB_REC_GEN
		,RHB_LUPD_DAT ,RHB_MAN_REC   ,RHB_REV_FLAG  ,RHB_NARRATION
	)
	SELECT
		RHB_PAN_CODE  ,RHB_MBR_NUMB  ,RHB_ACCT_NO   ,RHB_RETREF_NUMB ,RHB_MESG_TYPE ,RHB_TRANS_AMT
		,RHB_REC_TYPE  ,RHB_TRAN_DATE ,RHB_TRANS_TIME  ,RHB_TERM_ID  ,RHB_FILE_NAME ,RHB_RECON_FLAG
		,RHB_CRNCY_CODE ,RHB_TXN_CODE  ,RHB_TRANS_AMT_ORG  ,RHB_ERR_FLAG ,RHB_REC_GEN
		,RHB_LUPD_DAT ,RHB_MAN_REC   ,RHB_REV_FLAG  ,RHB_NARRATION
	FROM REC_HOST_BASE2ONUS_IBR_TEMP  WHERE RHB_REV_FLAG = 'Y';
EXCEPTION
	WHEN OTHERS THEN
		ERRMSG:= 'Exep Main ......'||SQLERRM;
END SP_INS_HOSTONUS_IBR;
/


