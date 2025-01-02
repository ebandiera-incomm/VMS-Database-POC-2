CREATE OR REPLACE PROCEDURE VMSCMS.Sp_Ins_Hostsms    (errmsg	OUT		VARCHAR2)
AS
-- Minus amt Records
CURSOR c_Rev IS SELECT RHS_PAN_CODE,RHS_RETREF_NUMB ,RHS_TRANS_AMT, ROWID FROM REC_HOST_SMS_TEMP  WHERE RHS_MESG_TYPE = '0420' ;
c_Rowid VARCHAR2(25);
c_No_trans NUMBER(4);
c_amt   NUMBER(10);
BEGIN
	ERRMSG:= 'OK';

	FOR X IN c_rev LOOP
			-- Find corrsponding positive Trans
			SELECT MAX(ROWID), COUNT(*)  INTO c_Rowid , c_No_trans FROM REC_HOST_SMS_TEMP
			WHERE RHS_PAN_CODE = X.RHS_PAN_CODE
			AND RHS_RETREF_NUMB  = X.RHS_RETREF_NUMB AND RHS_MESG_TYPE = '0210';


			IF c_No_trans >= 1 THEN
				SELECT  RHS_TRANS_AMT - x.RHS_TRANS_AMT  INTO c_amt FROM REC_HOST_SMS_TEMP WHERE ROWID = c_Rowid;
					IF c_Amt = 0 THEN
						UPDATE REC_HOST_SMS_TEMP SET RHS_REV_FLAG = 'Y' WHERE ROWID = c_Rowid;
						UPDATE REC_HOST_SMS_TEMP SET RHS_REV_FLAG = 'Y' WHERE ROWID = X.ROWID;
					ELSE
						UPDATE REC_HOST_SMS_TEMP SET RHS_MESG_TYPE = '0220' WHERE ROWID = X.ROWID;
					END IF;
			ELSE

				-- Find Orignal In Host_sms Table Then Move Rev and Orignal Trans to REv TEmp Table

				SELECT MAX(ROWID) INTO c_RowID FROM rec_host_sms
				WHERE RHS_PAN_CODE = X.RHS_PAN_CODE
				AND RHS_RETREF_NUMB  = X.RHS_RETREF_NUMB AND RHS_MESG_TYPE = '0210'
				AND RHS_REV_FLAG = 'N';

				IF c_RowId IS NOT NULL THEN
					SELECT RHS_TRANS_AMT - x.RHS_TRANS_AMT  INTO c_amt FROM REC_HOST_SMS WHERE ROWID = c_Rowid;
					IF c_Amt = 0 THEN

						UPDATE REC_HOST_SMS_TEMP SET RHS_REV_FLAG = 'Y' WHERE ROWID = X.ROWID;

						INSERT INTO REC_HOST_SMS_REV_TEMP
							(
							RHS_PAN_CODE  ,RHS_MBR_NUMB  ,RHS_ACCT_NO   ,RHS_RETREF_NUMB ,RHS_MESG_TYPE ,RHS_TRANS_AMT
							,RHS_REC_TYPE  ,RHS_TRAN_DATE ,RHS_TRANS_TIME  ,RHS_TERM_ID  ,RHS_FILE_NAME ,RHS_RECON_FLAG
							,RHS_CRNCY_CODE ,RHS_TXN_CODE  ,RHS_TRANS_AMT_ORG  ,RHS_ERR_FLAG ,RHS_REC_GEN
							,RHS_LUPD_DAT ,RHS_MAN_REC   ,RHS_REV_FLAG  ,RHS_NARRATION
							)
						SELECT
							RHS_PAN_CODE  ,RHS_MBR_NUMB  ,RHS_ACCT_NO   ,RHS_RETREF_NUMB ,RHS_MESG_TYPE ,RHS_TRANS_AMT
							,RHS_REC_TYPE  ,RHS_TRAN_DATE ,RHS_TRANS_TIME  ,RHS_TERM_ID  ,RHS_FILE_NAME ,RHS_RECON_FLAG
							,RHS_CRNCY_CODE ,RHS_TXN_CODE  ,RHS_TRANS_AMT_ORG  ,RHS_ERR_FLAG ,RHS_REC_GEN
							,RHS_LUPD_DAT ,RHS_MAN_REC   ,RHS_REV_FLAG  ,RHS_NARRATION
						FROM REC_HOST_SMS WHERE ROWID = C_Rowid;



						DELETE FROM REC_HOST_SMS WHERE ROWID = C_Rowid;


					ELSE
						UPDATE REC_HOST_SMS_TEMP SET RHS_MESG_TYPE = '0220' WHERE ROWID = X.ROWID;
					END IF;

				END IF;
			END IF;


	END LOOP;

	-- INSERT ONLY VALID OR PROPER TRANS
	INSERT INTO REC_HOST_SMS (
		 RHS_PAN_CODE           ,RHS_MBR_NUMB           ,RHS_ACCT_NO            ,RHS_RETREF_NUMB
		,RHS_MESG_TYPE          ,RHS_TRANS_AMT          ,RHS_REC_TYPE           ,RHS_TRAN_DATE
		,RHS_TRANS_TIME         ,RHS_TERM_ID            ,RHS_FILE_NAME          ,RHS_RECON_FLAG
		,RHS_CRNCY_CODE         ,RHS_TXN_CODE           ,RHS_TRANS_AMT_ORG	,RHS_ERR_FLAG
		,RHS_REC_GEN            ,RHS_LUPD_DAT           ,RHS_MAN_REC
				)
	SELECT
		 RHS_PAN_CODE           ,RHS_MBR_NUMB           ,RHS_ACCT_NO            ,RHS_RETREF_NUMB
		,RHS_MESG_TYPE          ,RHS_TRANS_AMT          ,RHS_REC_TYPE           ,RHS_TRAN_DATE
		,RHS_TRANS_TIME         ,RHS_TERM_ID            ,RHS_FILE_NAME          ,RHS_RECON_FLAG
		,RHS_CRNCY_CODE         ,RHS_TXN_CODE           ,RHS_TRANS_AMT_ORG	,RHS_ERR_FLAG
		,RHS_REC_GEN            ,RHS_LUPD_DAT           ,RHS_MAN_REC
	 FROM REC_HOST_SMS_TEMP
	 WHERE RHS_REV_FLAG = 'N';


	-- INSERT ALL Y MARKED TRANS TO

	INSERT INTO REC_HOST_SMS_REV_TEMP
	(
		RHS_PAN_CODE  ,RHS_MBR_NUMB  ,RHS_ACCT_NO   ,RHS_RETREF_NUMB ,RHS_MESG_TYPE ,RHS_TRANS_AMT
		,RHS_REC_TYPE  ,RHS_TRAN_DATE ,RHS_TRANS_TIME  ,RHS_TERM_ID  ,RHS_FILE_NAME ,RHS_RECON_FLAG
		,RHS_CRNCY_CODE ,RHS_TXN_CODE  ,RHS_TRANS_AMT_ORG  ,RHS_ERR_FLAG ,RHS_REC_GEN
		,RHS_LUPD_DAT ,RHS_MAN_REC   ,RHS_REV_FLAG  ,RHS_NARRATION
	)
	SELECT
		RHS_PAN_CODE  ,RHS_MBR_NUMB  ,RHS_ACCT_NO   ,RHS_RETREF_NUMB ,RHS_MESG_TYPE ,RHS_TRANS_AMT
		,RHS_REC_TYPE  ,RHS_TRAN_DATE ,RHS_TRANS_TIME  ,RHS_TERM_ID  ,RHS_FILE_NAME ,RHS_RECON_FLAG
		,RHS_CRNCY_CODE ,RHS_TXN_CODE  ,RHS_TRANS_AMT_ORG  ,RHS_ERR_FLAG ,RHS_REC_GEN
		,RHS_LUPD_DAT ,RHS_MAN_REC   ,RHS_REV_FLAG  ,RHS_NARRATION
	FROM REC_HOST_SMS_TEMP 	 WHERE RHS_REV_FLAG = 'Y';



EXCEPTION
	WHEN OTHERS THEN
		ERRMSG:= 'Exep Main ......'||SQLERRM;
END;
/

