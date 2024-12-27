CREATE OR REPLACE PROCEDURE VMSCMS.sp_reissue_support_log
		(
		 prm_inst_code		IN NUMBER,
		 prm_old_card_no	IN VARCHAR2,
		 prm_new_card_no	IN VARCHAR2,
         prm_new_dispname   IN VARCHAR2,
         prm_new_product    IN VARCHAR2,
         prm_new_prodcrdtype IN VARCHAR2,
		 prm_file_name		IN VARCHAR2,
		 prm_remarks		IN VARCHAR2,
         prm_reason_code    IN NUMBER,
		 prm_msg24_flag		IN VARCHAR2,
		 prm_processs_flag    IN VARCHAR2,
         prm_process_msg    IN VARCHAR2,
         prm_process_mode    IN VARCHAR2,
         prm_ins_user        IN VARCHAR2,
         prm_ins_date        IN DATE,
-----------------Audit log details------------
        prm_activity_type    IN VARCHAR2,
        prm_tran_code        IN VARCHAR2,
        prm_delv_chnl        IN VARCHAR2,
        prm_tran_amt        IN NUMBER,
        prm_source        IN VARCHAR2,
        prm_reason_desc        IN VARCHAR2,
        prm_support_type    IN VARCHAR2,
        prm_errmsg        OUT VARCHAR2
           )
is
   v_hash_pan    CMS_APPL_PAN.CAP_PAN_CODE%TYPE;  
 v_encr_pan    CMS_APPL_PAN.cap_pan_code_encr%TYPE;
 v_new_hash_pan    CMS_APPL_PAN.CAP_PAN_CODE%TYPE;  
 v_new_encr_pan    CMS_APPL_PAN.cap_pan_code_encr%TYPE;

 
pragma    Autonomous_transaction;
v_reissue_dupflag cms_reissue_detail.CRD_REISSUE_DUPFLAG%type;
BEGIN
    prm_errmsg := 'OK';
  IF prm_processs_flag='C' THEN
    v_reissue_dupflag:='D';
  END IF;
  
 
--SN CREATE HASH PAN 
BEGIN
    v_hash_pan := Gethash(prm_old_card_no);
EXCEPTION
WHEN OTHERS THEN
prm_errmsg := 'Error while converting pan ' || SUBSTR(SQLERRM,1,200);
    RETURN;    
END;
--EN CREATE HASH PAN

--SN create encr pan
BEGIN
    v_encr_pan := Fn_Emaps_Main(prm_old_card_no);
EXCEPTION
WHEN OTHERS THEN
prm_errmsg := 'Error while converting pan ' || SUBSTR(SQLERRM,1,200);
    RETURN;    
END;
--EN create encr pan

--SN CREATE HASH PAN 
BEGIN
    v_new_hash_pan := Gethash(prm_new_card_no);
EXCEPTION
WHEN OTHERS THEN
prm_errmsg := 'Error while converting pan ' || SUBSTR(SQLERRM,1,200);
    RETURN;    
END;
--EN CREATE HASH PAN

--SN create encr pan
BEGIN
    v_new_encr_pan := Fn_Emaps_Main(prm_new_card_no);
EXCEPTION
WHEN OTHERS THEN
prm_errmsg := 'Error while converting pan ' || SUBSTR(SQLERRM,1,200);
    RETURN;    
END;
--EN create encr pan


    --Sn insert into reissue detail
    BEGIN
        INSERT INTO cms_reissue_detail
            (crd_inst_code, 
             crd_old_card_no, 
             crd_new_card_no,
             crd_file_name, 
             crd_remarks, 
             crd_msg24_flag,
             crd_process_flag, 
             crd_process_msg, 
             crd_process_mode,
             crd_ins_user, 
             crd_ins_date, 
             crd_lupd_user, 
             crd_lupd_date,
       CRD_REISSUE_DUPFLAG,
       crd_new_dispname,
       crd_new_product,
       crd_new_productcat,
       crd_reason_code,
       crd_old_card_no_encr, 
             crd_new_card_no_encr
       )
VALUES ( prm_inst_code, 
            --prm_old_card_no
        v_hash_pan,
           -- prm_new_card_no
        v_new_hash_pan,
            prm_file_name, 
            prm_remarks, 
            prm_msg24_flag,
                    prm_processs_flag,
            prm_process_msg,
            prm_process_mode,
                    prm_ins_user,
            prm_ins_date, 
            prm_ins_user, 
            prm_ins_date,
        v_reissue_dupflag,
        prm_new_dispname,
        prm_new_product,
        prm_new_prodcrdtype,
        prm_reason_code,
        v_encr_pan,
        v_new_encr_pan
                  );
    --En create record u
    EXCEPTION
    WHEN OTHERS THEN
    prm_errmsg := 'Error while creating record in detail table ' || substr(sqlerrm,1,150);
    RETURN;    
    END;
    --En insert into reissue detail
    --Sn insert in audit log
    BEGIN
      INSERT INTO PROCESS_AUDIT_LOG
            (pal_inst_code,
             pal_card_no, 
             pal_activity_type, 
             pal_transaction_code,
             pal_delv_chnl, 
             pal_tran_amt, 
             pal_source,
             pal_success_flag, 
             pal_ins_user, 
             pal_ins_date,
             pal_process_msg, 
             pal_reason_desc, 
             pal_remarks,
             pal_spprt_type,
             pal_card_no_encr
            )
              VALUES    
              (prm_inst_code,
             -- prm_old_card_no
       v_hash_pan, 
             prm_activity_type,
             prm_tran_code,
             prm_delv_chnl,
             prm_tran_amt,
             prm_source,
             prm_processs_flag, 
             prm_ins_user, 
             prm_ins_date,
             prm_process_msg,
             prm_reason_desc,
             prm_remarks,
             prm_support_type,
       v_encr_pan
                     );    
    EXCEPTION
     WHEN OTHERS THEN
     prm_errmsg := 'Error while creating record in detail table ' || substr(sqlerrm,1,150);
     RETURN;    
    END;
    --En insert into audit log
   commit;
EXCEPTION
WHEN OTHERS THEN
prm_errmsg := 'Error while creating record in log table ' || substr(sqlerrm,1,150);
RETURN;    
END;
/


SHOW ERRORS