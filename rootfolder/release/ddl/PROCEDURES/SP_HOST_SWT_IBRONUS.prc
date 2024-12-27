CREATE OR REPLACE PROCEDURE VMSCMS.SP_HOST_SWT_IBRONUS(errmsg OUT VARCHAR2) AS
  --c_amt_chk  number(15);
  c_RHB_rowid VARCHAR2(50);
  CURSOR C_RSB IS
    SELECT ROWID, REC_SWT_BASE2ONUS_IBR.* FROM REC_SWT_BASE2ONUS_IBR;
  CURSOR C_REV IS
    SELECT * FROM REC_SWT_BASE2ONUS_IBR_REV;
BEGIN
  --main begin
  errmsg := 'OK';
  -- DELETE temp table
  DELETE FROM REC_SWTHOST_BASE2ONUS_IBR_T; -- DELETE RECORD FROM SWTHOST_RECON
  -- LOOP ON REC_SWT_BASE2ONUS_IBR TO CHECK THE MATCHING TRANS FROM REC_host_SMS ONE TO ONE MATCHING
  FOR c IN C_RSB LOOP
    BEGIN
      -- BEGIN 1
      --DBMS_OUTPUT.PUT_LINE('Data Found in cursor');
      SELECT MAX(RHB.ROWID)
        INTO c_RHB_rowid
        FROM REC_HOST_BASE2ONUS_IBR RHB
       WHERE RHB.RHB_PAN_CODE = c.RSB_PAN AND
             RHB.RHB_RETREF_NUMB = c.RSB_SEQ_NUM
            --and RHB.RHB_TRAN_DATE   = c.RSB_TRAN_DAT
          --   AND RHB.RHB_MESG_TYPE = C.RSB_tran_TYP AND
			AND TO_NUMBER(RHB.RHB_TRANS_AMT)		= TO_NUMBER(C.RSB_AMT1/100)
             AND RHB.RHB_RECON_FLAG = '0';
      IF c_RHB_rowid IS NOT NULL THEN
        --DBMS_OUTPUT.PUT_LINE('Rowid'||C_RHB_ROWID);
        UPDATE REC_HOST_BASE2ONUS_IBR
           SET RHB_RECON_FLAG = '1'
         WHERE ROWID = TRIM(c_RHB_rowid);
        UPDATE REC_SWT_BASE2ONUS_IBR
           SET RSB_RECON = '1'
         WHERE ROWID = TRIM(C.ROWID);
        -- RECON TRANS INSERTED INTO TWO TABLES 1)REC_SWTHOST_SMS_TEMP 2)REC_SMS_ILF
        INSERT INTO REC_SWTHOST_BASE2ONUS_IBR_T
          (RSB_RECON,
           RSB_PROCESS_DATE,
           RSB_FILE_NAME,
           RSB_TRAN_TYP,
           RSB_RESP_CDE,
           RSB_RVSL_CDE,
           RSB_POST_DAT,
           RSB_ACQ_INST_ID_NUM,
           RSB_TERM_ID,
           RSB_TERM_NAME_LOC,
           RSB_TERM_OWNER_NAME,
           RSB_TERM_CITY,
           RSB_TERM_ST_X,
           RSB_TERM_CNTRY_X,
           RSB_SEQ_NUM,
           RSB_INVOICE_NUM,
           RSB_RETL_ID,
           RSB_TRAN_CDE,
           RSB_RESPONDER,
           RSB_PAN,
           RSB_MBR_NUM,
           RSB_AMT1,
           RSB_AMT2,
           RSB_SETL_CRNCY_CDE,
           RSB_SETL_CONV_RATE,
           RSB_TRAN_DAT,
           RSB_TRAN_TIM,
           RSB_PT_SRV_COND_CDE,
           RSB_PT_SRV_ENTRY_MDE,
           RSB_FROM_ACCT_TYP,
           RSB_FROM_ACCT,
           RSB_ORIG_CRNCY_CDE,
           RSB_RESP,
           RSB_MAT_CAT_CODE,
           RSB_TRACE_NUM,
           RSB_RRN,
           RSB_ACCT_NO_H,
           RSB_RETREF_NUMB_H,
           RSB_MESG_TYPE_H,
           RSB_TRAN_DATE_H,
           RSB_TRANS_TIME_H,
           RSB_TRANS_AMT_H,
           RSB_TERM_ID_H,
           RSB_CRNCY_CODE_H,
           RSB_TXN_CODE_H,
           RSB_TRANS_AMT_ORG_H,
           RSB_FILE_NAME_H,
           RSB_REC_TYPE_H)
          SELECT 1,
                 SYSDATE,
                 RSB.RSB_FILE_NAME,
                 RSB.RSB_TRAN_TYP,
                 RSB.RSB_RESP_CDE,
                 RSB.RSB_RVSL_CDE,
                 RSB.RSB_POST_DAT,
                 RSB.RSB_ACQ_INST_ID_NUM,
                 RSB.RSB_TERM_ID,
                 RSB.RSB_TERM_NAME_LOC,
                 RSB.RSB_TERM_OWNER_NAME,
                 RSB.RSB_TERM_CITY,
                 RSB.RSB_TERM_ST_X,
                 RSB.RSB_TERM_CNTRY_X,
                 RSB.RSB_SEQ_NUM,
                 RSB.RSB_INVOICE_NUM,
                 RSB.RSB_RETL_ID,
                 RSB.RSB_TRAN_CDE,
                 RSB.RSB_RESPONDER,
                 RSB.RSB_PAN,
                 RSB.RSB_MBR_NUM,
                 RSB.RSB_AMT1,
                 RSB.RSB_AMT2,
                 RSB.RSB_SETL_CRNCY_CDE,
                 RSB.RSB_SETL_CONV_RATE,
                 RSB.RSB_TRAN_DAT,
                 RSB.RSB_TRAN_TIM,
                 RSB.RSB_PT_SRV_COND_CDE,
                 RSB.RSB_PT_SRV_ENTRY_MDE,
                 RSB.RSB_FROM_ACCT_TYP,
                 RSB.RSB_FROM_ACCT,
                 RSB.RSB_ORIG_CRNCY_CDE,
                 RSB.RSB_RESP,
                 RSB.RSB_MAT_CAT_CODE,
                 RSB.RSB_TRACE_NUM,
                 RSB.RSB_rrn,
                 RHB.RHB_ACCT_NO,
                 RHB.RHB_RETREF_NUMB,
                 RHB.RHB_MESG_TYPE,
                 RHB.RHB_TRAN_DATE,
                 RHB.RHB_TRANS_TIME,
                 RHB.RHB_TRANS_AMT,
                 RHB.RHB_TERM_ID,
                 RHB.RHB_CRNCY_CODE,
                 RHB.RHB_TXN_CODE,
                 RHB.RHB_TRANS_AMT_ORG,
                 RHB.RHB_FILE_NAME,
                 RHB.RHB_REC_TYPE
            FROM REC_HOST_BASE2ONUS_IBR RHB, REC_SWT_BASE2ONUS_IBR RSB
           WHERE RHB.ROWID = TRIM(c_RHB_rowid) AND
                 RSB.ROWID = TRIM(C.ROWID);
        -- INSERT INTO REC_SMS_ILF TABLE
        INSERT INTO REC_BASE2ONUS_ILF_IBR
          (RBI_RECON,
           RBI_PROCESS_DATE,
           RBI_FILE_TYPE,
           RBI_FILE_NAME,
           RBI_REC_TYP,
           RBI_TRAN_TYP,
           RBI_RESP_CDE,
           RBI_RVSL_CDE,
           RBI_POST_DAT,
           RBI_ACQ_INST_ID_NUM,
           RBI_TERM_ID,
           RBI_TERM_NAME_LOC,
           RBI_TERM_OWNER_NAME,
           RBI_TERM_CITY,
           RBI_TERM_ST_X,
           RBI_TERM_CNTRY_X,
           RBI_SEQ_NUM,
           RBI_INVOICE_NUM,
           RBI_RETL_ID,
           RBI_TRAN_CDE,
           RBI_RESPONDER,
           RBI_PAN,
           RBI_MBR_NUM,
           RBI_AMT1,
           RBI_AMT2,
           RBI_SETL_CRNCY_CDE,
           RBI_SETL_CONV_RATE,
           RBI_TRAN_DAT,
           RBI_TRAN_TIM,
           RBI_PT_SRV_COND_CDE,
           RBI_PT_SRV_ENTRY_MDE,
           RBI_FROM_ACCT_TYP,
           RBI_FROM_ACCT,
           RBI_ORIG_CRNCY_CDE,
           RBI_RESP,
           RBI_MAT_CAT_CODE,
           RBI_TRACE_NUM,
           RBI_RRN)
          SELECT 0,
                 SYSDATE,
                 RSB.RSB_FILE_TYPE,
                 RSB.RSB_FILE_NAME,
                 RSB.RSB_REC_TYP,
                 RSB.RSB_TRAN_TYP,
                 RSB.RSB_RESP_CDE,
                 RSB.RSB_RVSL_CDE,
                 RSB.RSB_POST_DAT,
                 RSB.RSB_ACQ_INST_ID_NUM,
                 RSB.RSB_TERM_ID,
                 RSB.RSB_TERM_NAME_LOC,
                 RSB.RSB_TERM_OWNER_NAME,
                 RSB.RSB_TERM_CITY,
                 RSB.RSB_TERM_ST_X,
                 RSB.RSB_TERM_CNTRY_X,
                 RSB.RSB_SEQ_NUM,
                 RSB.RSB_INVOICE_NUM,
                 RSB.RSB_RETL_ID,
                 RSB.RSB_TRAN_CDE,
                 RSB.RSB_RESPONDER,
                 RSB.RSB_PAN,
                 RSB.RSB_MBR_NUM,
                 RSB.RSB_AMT1,
                 RSB.RSB_AMT2,
                 RSB.RSB_SETL_CRNCY_CDE,
                 RSB.RSB_SETL_CONV_RATE,
                 RSB.RSB_TRAN_DAT,
                 RSB.RSB_TRAN_TIM,
                 RSB.RSB_PT_SRV_COND_CDE,
                 RSB.RSB_PT_SRV_ENTRY_MDE,
                 RSB.RSB_FROM_ACCT_TYP,
                 RSB.RSB_FROM_ACCT,
                 RSB.RSB_ORIG_CRNCY_CDE,
                 RSB.RSB_RESP,
                 RSB.RSB_MAT_CAT_CODE,
                 RSB.RSB_TRACE_NUM,
                 RSB.RSB_RRN
            FROM REC_SWT_BASE2ONUS_IBR RSB
           WHERE RSB.ROWID = TRIM(C.ROWID);
      END IF;
    EXCEPTION
      -- EXCEPTION 1
      WHEN NO_DATA_FOUND THEN
        NULL;
        --        DBMS_OUTPUT.PUT_LINE('Excep 1 --ROW ID NOT FOUND' );
    END;
  END LOOP;
  --  DBMS_OUTPUT.PUT_LINE('chkpt --II loop Starts' );
  --- RECONCILE THE REVERSAL TRANS
  FOR C IN C_REV LOOP
    SELECT MAX(RHB.ROWID)
      INTO c_RHB_rowid
      FROM REC_HOST_BASE2ONUS_IBR RHB
     WHERE RHB.RHB_PAN_CODE = C.RSB_PAN AND
           RHB.RHB_RETREF_NUMB = C.RSB_SEQ_NUM;
          --and RHB.RHB_TRAN_DATE =C.RSB_TRAN_DAT
         --  and RHB.RHB_REC_TYPE = C.RSB_REC_TYP AND
        --   RHB.RHB_MESG_TYPE = C.RSB_tran_TYP;
    IF c_RHB_rowid IS NOT NULL THEN
      UPDATE REC_HOST_BASE2ONUS_IBR
         SET RHB_REV_FLAG = 'Y'
       WHERE ROWID = c_RHB_rowid;
    END IF;
  END LOOP;
  -- delete recordes from both table (REC_SWT_BASE2ONUS_IBR and REC_host_SMS ) which are reconsiled
  DELETE FROM REC_SWT_BASE2ONUS_IBR WHERE RSB_recon = '1';
  DELETE FROM REC_HOST_BASE2ONUS_IBR WHERE RHB_recon_flag = '1';
  --DBMS_OUTPUT.PUT_LINE('Delete chk pt');
EXCEPTION
  --excp of main
  WHEN OTHERS THEN
    errmsg := 'Main Excp --' || SQLERRM;
END --end of main
;
/


