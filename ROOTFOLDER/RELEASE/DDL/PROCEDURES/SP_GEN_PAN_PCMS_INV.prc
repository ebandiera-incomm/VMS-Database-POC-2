create or replace
PROCEDURE        vmscms.SP_GEN_PAN_PCMS_INV (
   prm_instcode          IN       NUMBER,
   prm_applcode          IN       NUMBER,
   prm_lupduser          IN       NUMBER,
   prm_pan               OUT      VARCHAR2,
   prm_applprocess_msg   OUT      VARCHAR2,
   prm_errmsg            OUT      VARCHAR2
)
AS

/************************************
     * Modified By      : Shanmugavel
     * Modified Date    : 23/01/2024
     * Purpose          : VMS-8219-Remove the Default Status in the Product Category Profile Screen on the Host UI
     * Reviewer         : Venkat/John/Pankaj
     * Release Number   : VMSGPRHOSTR92

****************************************/

   v_inst_code              cms_appl_mast.cam_inst_code%TYPE;
   v_asso_code              cms_appl_mast.cam_asso_code%TYPE;
   v_inst_type              cms_appl_mast.cam_inst_type%TYPE;
   v_prod_code              cms_appl_mast.cam_prod_code%TYPE;
   v_appl_bran              cms_appl_mast.cam_appl_bran%TYPE;
   v_cust_code              cms_appl_mast.cam_cust_code%TYPE;
   v_card_type              cms_appl_mast.cam_card_type%TYPE;
   v_cust_catg              cms_appl_mast.cam_cust_catg%TYPE;
   v_disp_name              cms_appl_mast.cam_disp_name%TYPE;
   v_active_date            cms_appl_mast.cam_active_date%TYPE;
   v_expry_date             cms_appl_mast.cam_expry_date%TYPE;
   v_addon_stat             cms_appl_mast.cam_addon_stat%TYPE;
   v_tot_acct               cms_appl_mast.cam_tot_acct%TYPE;
   v_chnl_code              cms_appl_mast.cam_chnl_code%TYPE;
   v_limit_amt              cms_appl_mast.cam_limit_amt%TYPE;
   v_use_limit              cms_appl_mast.cam_use_limit%TYPE;
   v_bill_addr              cms_appl_mast.cam_bill_addr%TYPE;
   v_request_id             cms_appl_mast.cam_request_id%TYPE;
   v_appl_stat              cms_appl_mast.cam_appl_stat%TYPE;
   v_bin                    cms_bin_mast.cbm_inst_bin%TYPE;
   v_profile_code           cms_prod_cattype.cpc_profile_code%TYPE;
   v_errmsg                 VARCHAR2 (500);
   v_hsm_mode               cms_inst_param.cip_param_value%TYPE;
   v_pingen_flag            VARCHAR2 (1);
   v_emboss_flag            VARCHAR2 (1);
   v_loop_cnt               NUMBER                                  DEFAULT 0;
   v_loop_max_cnt           NUMBER;
   v_tmp_pan                cms_appl_pan.cap_pan_code%TYPE;
   v_noof_pan_param         NUMBER;
   v_inst_bin               cms_prod_bin.cpb_inst_bin%TYPE;
   v_serial_index           NUMBER;
   v_serial_maxlength       NUMBER (2);
   v_serial_no              NUMBER;
   v_check_digit            NUMBER;
   v_pan                    cms_appl_pan.cap_pan_code%TYPE;
   v_acct_id                cms_acct_mast.cam_acct_id%TYPE;
   v_acct_num               cms_acct_mast.cam_acct_no%TYPE;
   v_adonlink               cms_appl_pan.cap_pan_code%TYPE;
   v_mbrlink                cms_appl_pan.cap_mbr_numb%TYPE;
   v_cam_addon_link         cms_appl_mast.cam_addon_link%TYPE;
   v_prod_prefix            cms_prod_cattype.cpc_prod_prefix%TYPE;
   v_card_stat              cms_appl_pan.cap_card_stat%TYPE;
   v_offline_atm_limit      cms_appl_pan.cap_atm_offline_limit%TYPE;
   v_online_atm_limit       cms_appl_pan.cap_atm_online_limit%TYPE;
   v_online_pos_limit       cms_appl_pan.cap_pos_online_limit%TYPE;
   v_offline_pos_limit      cms_appl_pan.cap_pos_offline_limit%TYPE;
   v_offline_aggr_limit     cms_appl_pan.cap_offline_aggr_limit%TYPE;
   v_online_aggr_limit      cms_appl_pan.cap_online_aggr_limit%TYPE;
   v_cpm_catg_code          cms_prod_mast.cpm_catg_code%TYPE;
   v_issueflag              VARCHAR2 (1);
   v_initial_topup_amount   cms_appl_mast.cam_initial_topup_amount%TYPE;
   v_func_code              cms_func_mast.cfm_func_code%TYPE;
   v_func_desc              cms_func_mast.cfm_func_desc%TYPE;
   v_cr_gl_code             cms_func_prod.cfp_crgl_code%TYPE;
   v_crgl_catg              cms_func_prod.cfp_crgl_catg%TYPE;
   v_crsubgl_code           cms_func_prod.cfp_crsubgl_code%TYPE;
   v_cracct_no              cms_func_prod.cfp_cracct_no%TYPE;
   v_dr_gl_code             cms_func_prod.cfp_drgl_code%TYPE;
   v_drgl_catg              cms_func_prod.cfp_drgl_catg%TYPE;
   v_drsubgl_code           cms_func_prod.cfp_drsubgl_code%TYPE;
   v_dracct_no              cms_func_prod.cfp_dracct_no%TYPE;
   v_gl_check               NUMBER (1);
   v_subgl_desc             VARCHAR2 (30);
   v_tran_code              cms_func_mast.cfm_txn_code%TYPE;
   v_tran_mode              cms_func_mast.cfm_txn_mode%TYPE;
   v_delv_chnl              cms_func_mast.cfm_delivery_channel%TYPE;
   v_tran_type              cms_func_mast.cfm_txn_type%TYPE;
   v_savepoint              NUMBER                                  DEFAULT 1;
   V_EXPRYPARAM             CMS_BIN_PARAM.CBP_PARAM_VALUE%TYPE;
   v_prod_suffix            cms_prod_cattype.cpc_prod_suffix%TYPE;
   v_card_start             cms_prod_cattype.cpc_start_card_no%TYPE;
   v_card_end               cms_prod_cattype.cpc_end_card_no%TYPE;
   v_prodprefx_index        NUMBER;
   v_prefix                 VARCHAR2(10);
   V_CPC_SERL_FLAG          cms_prod_cattype.CPC_SERL_FLAG%type;
--
--   TYPE rec_pan_construct IS RECORD (
--      cpc_profile_code   cms_pan_construct.cpc_profile_code%TYPE,
--      cpc_field_name     cms_pan_construct.cpc_field_name%TYPE,
--      cpc_start_from     cms_pan_construct.cpc_start_from%TYPE,
--      cpc_start          cms_pan_construct.cpc_start%TYPE,
--      cpc_length         cms_pan_construct.cpc_length%TYPE,
--      cpc_field_value    VARCHAR2 (30)
--   );
--
--   TYPE table_pan_construct IS TABLE OF rec_pan_construct
--      INDEX BY BINARY_INTEGER;
--
--   v_table_pan_construct    table_pan_construct;
   exp_reject_record        EXCEPTION;

--   CURSOR c (p_profile_code IN VARCHAR2)
--   IS
--      SELECT   cpc_profile_code, cpc_field_name, cpc_start_from, cpc_length,
--               cpc_start
--          FROM cms_pan_construct
--         WHERE cpc_profile_code = p_profile_code
--      ORDER BY cpc_start_from DESC;

   CURSOR c1 (appl_code IN NUMBER)
   IS
      SELECT cad_acct_id, cad_acct_posn
        FROM cms_appl_det
       WHERE cad_appl_code = prm_applcode;

   PROCEDURE lp_pan_bin (
      l_instcode    IN       NUMBER,
      l_insttype    IN       NUMBER,
      l_prod_code   IN       VARCHAR2,
      l_pan_bin     OUT      NUMBER,
      l_errmsg      OUT      VARCHAR2
   )
   IS
   BEGIN
      SELECT cpb_inst_bin
        INTO l_pan_bin
        FROM cms_prod_bin
       WHERE cpb_inst_code = l_instcode
         AND cpb_prod_code = l_prod_code
         AND cpb_active_bin = 'Y';

      l_errmsg := 'OK';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         l_errmsg :=
               'Excp1 LP1 -- No prefix  found for combination of Institution '
            || l_instcode
            || ' and product '
            || l_prod_code;
      WHEN OTHERS
      THEN
         l_errmsg := 'Excp1 LP1 -- ' || SQLERRM;
   END;

--   PROCEDURE lp_pan_srno (
--      l_instcode     IN       NUMBER,
--      l_lupduser     IN       NUMBER,
--      l_tmp_pan      IN       VARCHAR2,
--      l_max_length   IN       NUMBER,
--      l_srno         OUT      VARCHAR2,
--      l_errmsg       OUT      VARCHAR2
--   )
--   IS
--      v_ctrlnumb        NUMBER;
--      v_max_serial_no   NUMBER;
--   BEGIN
--      l_errmsg := 'OK';
--
--      SELECT cpc_ctrl_numb, cpc_max_serial_no
--        INTO v_ctrlnumb, v_max_serial_no
--        FROM cms_pan_ctrl
--       WHERE cpc_pan_prefix = l_tmp_pan;
--
--      IF v_ctrlnumb > v_max_serial_no
--      THEN
--         l_errmsg := 'Maximum serial number reached';
--         RETURN;
--      END IF;
--
--      l_srno := v_ctrlnumb;
--
--      UPDATE cms_pan_ctrl
--         SET cpc_ctrl_numb = v_ctrlnumb + 1
--       WHERE cpc_pan_prefix = l_tmp_pan;
--   EXCEPTION
--      WHEN NO_DATA_FOUND
--      THEN
--         INSERT INTO cms_pan_ctrl
--                     (cpc_inst_code, cpc_pan_prefix, cpc_ctrl_numb,
--                      cpc_max_serial_no
--                     )
--              VALUES (1, l_tmp_pan, 2,
--                      LPAD ('9', l_max_length, 9)
--                     );
--
--         v_ctrlnumb := 1;
--         l_srno := v_ctrlnumb;
--      WHEN OTHERS
--      THEN
--         l_errmsg := 'Excp1 LP2 -- ' || SQLERRM;
--   END;

   PROCEDURE lp_pan_chkdig (l_tmppan IN VARCHAR2, l_checkdig OUT NUMBER)
   IS
      ceilable_sum   NUMBER     := 0;
      ceiled_sum     NUMBER;
      temp_pan       NUMBER;
      len_pan        NUMBER (3);
      res            NUMBER (3);
      mult_ind       NUMBER (1);
      dig_sum        NUMBER (2);
      dig_len        NUMBER (1);
   BEGIN
      DBMS_OUTPUT.put_line ('In check digit gen logic');
      temp_pan := l_tmppan;
      len_pan := LENGTH (temp_pan);
      mult_ind := 2;

      FOR i IN REVERSE 1 .. len_pan
      LOOP
         res := SUBSTR (temp_pan, i, 1) * mult_ind;
         dig_len := LENGTH (res);

         IF dig_len = 2
         THEN
            dig_sum := SUBSTR (res, 1, 1) + SUBSTR (res, 2, 1);
         ELSE
            dig_sum := res;
         END IF;

         ceilable_sum := ceilable_sum + dig_sum;

         IF mult_ind = 2
         THEN
            mult_ind := 1;
         ELSE
            mult_ind := 2;
         END IF;
      END LOOP;

      ceiled_sum := ceilable_sum;

      IF MOD (ceilable_sum, 10) != 0
      THEN
         LOOP
            ceiled_sum := ceiled_sum + 1;
            EXIT WHEN MOD (ceiled_sum, 10) = 0;
         END LOOP;
      END IF;

      l_checkdig := ceiled_sum - ceilable_sum;
   END;
BEGIN
   prm_applprocess_msg := 'OK';
   prm_errmsg := 'OK';

   BEGIN
      SELECT seq_pangen_savepoint.NEXTVAL
        INTO v_savepoint
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
                    'Error from sequence pangen ' || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   SAVEPOINT v_savepoint;

   BEGIN
      SELECT cip_param_value
        INTO v_hsm_mode
        FROM cms_inst_param
       WHERE cip_param_key = 'HSM_MODE';

      IF v_hsm_mode = 'Y'
      THEN
         v_pingen_flag := 'Y';
         v_emboss_flag := 'Y';
      ELSE
         v_pingen_flag := 'N';
         v_emboss_flag := 'N';
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_hsm_mode := 'N';
         v_pingen_flag := 'N';
         v_emboss_flag := 'N';
   END;
   
   BEGIN
      SELECT cam_inst_code, cam_asso_code, cam_inst_type, cam_prod_code,
             cam_appl_bran, cam_cust_code, cam_card_type, cam_cust_catg,
             cam_disp_name, cam_active_date, cam_expry_date, cam_addon_stat,
             cam_tot_acct, cam_chnl_code, cam_limit_amt, cam_use_limit,
             cam_bill_addr, cam_request_id, cam_appl_stat,
             cam_initial_topup_amount
        INTO v_inst_code, v_asso_code, v_inst_type, v_prod_code,
             v_appl_bran, v_cust_code, v_card_type, v_cust_catg,
             v_disp_name, v_active_date, v_expry_date, v_addon_stat,
             v_tot_acct, v_chnl_code, v_limit_amt, v_use_limit,
             v_bill_addr, v_request_id, v_appl_stat,
             v_initial_topup_amount
        FROM cms_appl_mast
       WHERE cam_appl_code = prm_applcode AND cam_appl_stat = 'I';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_errmsg := 'No row found for application code' || prm_applcode;
         RAISE exp_reject_record;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting applcode from applmast'
            || SUBSTR (SQLERRM, 1, 300);
         RAISE exp_reject_record;
   END;

   BEGIN
      lp_pan_bin (v_inst_code, v_inst_type, v_prod_code, v_bin, v_errmsg);

      IF v_errmsg <> 'OK'
      THEN
         RAISE exp_reject_record;
      END IF;
   EXCEPTION
      WHEN exp_reject_record
      THEN
         RAISE;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting bin from binmast'
            || SUBSTR (SQLERRM, 1, 300);
         RAISE exp_reject_record;
   END;

   BEGIN
      SELECT cpc_profile_code, cpm_catg_code, cpc_prod_prefix,
             cpc_prod_suffix, cpc_start_card_no, cpc_end_card_no 
        INTO v_profile_code, v_cpm_catg_code, v_prod_prefix,
             v_prod_suffix, v_card_start, v_card_end
        FROM cms_prod_cattype, cms_prod_mast
       WHERE cpc_inst_code = prm_instcode
         AND cpc_prod_code = v_prod_code
         AND cpc_card_type = v_card_type
         AND cpm_prod_code = cpc_prod_code;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_errmsg :=
               'Profile code not defined for product code '
            || v_prod_code
            || 'card type '
            || v_card_type;
         RAISE exp_reject_record;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting applcode from applmast'
            || SUBSTR (SQLERRM, 1, 300);
         RAISE exp_reject_record;
   END;
  

--   BEGIN
--      v_loop_cnt := 0;
--
--      FOR i IN c (v_profile_code)
--      LOOP
--         v_loop_cnt := v_loop_cnt + 1;
--
--         SELECT i.cpc_profile_code,
--                i.cpc_field_name,
--                i.cpc_start_from,
--                i.cpc_length,
--                i.cpc_start
--           INTO v_table_pan_construct (v_loop_cnt).cpc_profile_code,
--                v_table_pan_construct (v_loop_cnt).cpc_field_name,
--                v_table_pan_construct (v_loop_cnt).cpc_start_from,
--                v_table_pan_construct (v_loop_cnt).cpc_length,
--                v_table_pan_construct (v_loop_cnt).cpc_start
--           FROM DUAL;
--      END LOOP;
--   EXCEPTION
--      WHEN OTHERS
--      THEN
--         v_errmsg :=
--               'Error while selecting profile detail from profile mast '
--            || SUBSTR (SQLERRM, 1, 300);
--         RAISE exp_reject_record;
--   END;
--
--   BEGIN
--      v_loop_max_cnt := v_table_pan_construct.COUNT;
--      v_tmp_pan := NULL;
--
--      FOR i IN 1 .. v_loop_max_cnt
--      LOOP
--         DBMS_OUTPUT.put_line (   'IFIELD NAME '
--                               || i
--                               || v_table_pan_construct (i).cpc_field_name
--                              );
--
--         IF v_table_pan_construct (i).cpc_field_name = 'Card Type'
--         THEN
--            v_table_pan_construct (i).cpc_field_value :=
--               LPAD (SUBSTR (TRIM (v_card_type),
--                             v_table_pan_construct (i).cpc_start,
--                             v_table_pan_construct (i).cpc_length
--                            ),
--                     v_table_pan_construct (i).cpc_length,
--                     '0'
--                    );
--         ELSIF v_table_pan_construct (i).cpc_field_name = 'Branch'
--         THEN
--            v_table_pan_construct (i).cpc_field_value :=
--               LPAD (SUBSTR (TRIM (v_appl_bran),
--                             v_table_pan_construct (i).cpc_start,
--                             v_table_pan_construct (i).cpc_length
--                            ),
--                     v_table_pan_construct (i).cpc_length,
--                     '0'
--                    );
--         ELSIF v_table_pan_construct (i).cpc_field_name = 'BIN / PREFIX'
--         THEN
--            DBMS_OUTPUT.put_line (' loop indicator ' || i);
--            v_table_pan_construct (i).cpc_field_value :=
--               LPAD (SUBSTR (TRIM (v_bin),
--                             v_table_pan_construct (i).cpc_start,
--                             v_table_pan_construct (i).cpc_length
--                            ),
--                     v_table_pan_construct (i).cpc_length,
--                     '0'
--                    );
--         ELSIF v_table_pan_construct (i).cpc_field_name =
--                                                     'Product Category Prefix'
--         THEN
--            v_table_pan_construct (i).cpc_field_value :=
--               LPAD (SUBSTR (TRIM (v_prod_prefix),
--                             v_table_pan_construct (i).cpc_start,
--                             v_table_pan_construct (i).cpc_length
--                            ),
--                     v_table_pan_construct (i).cpc_length,
--                     '0'
--                    );
--         ELSE
--            IF v_table_pan_construct (i).cpc_field_name <> 'Serial Number'
--            THEN
--               v_errmsg :=
--                     'Pan construct '
--                  || v_table_pan_construct (i).cpc_field_name
--                  || ' not exist ';
--               RAISE exp_reject_record;
--            END IF;
--         END IF;
--      END LOOP;
--   EXCEPTION
--      WHEN exp_reject_record
--      THEN
--         RAISE;
--      WHEN OTHERS
--      THEN
--         v_errmsg := 'Error from pangen process ' || SUBSTR (SQLERRM, 1, 300);
--         RAISE exp_reject_record;
--   END;
--
--   FOR i IN 1 .. v_loop_max_cnt
--   LOOP
--      DBMS_OUTPUT.put_line ('  PRINT loop indicator ' || i);
--      DBMS_OUTPUT.put_line (   'PRINT START FROM  I  '
--                            || v_table_pan_construct (i).cpc_start_from
--                           );
--      DBMS_OUTPUT.put_line (   'PRINT FIELD NAME I  '
--                            || v_table_pan_construct (i).cpc_field_name
--                           );
--      DBMS_OUTPUT.put_line (   'PRINT FIELD VALUE I  '
--                            || v_table_pan_construct (i).cpc_field_value
--                           );
--      DBMS_OUTPUT.put_line (   'PRINT FIELD LENGTH I  '
--                            || v_table_pan_construct (i).cpc_length
--                           );
--   END LOOP;
--
--   FOR i IN 1 .. v_loop_max_cnt
--   LOOP
--      FOR j IN 1 .. v_loop_max_cnt
--      LOOP
--         DBMS_OUTPUT.put_line (   ' j start from '
--                               || v_table_pan_construct (j).cpc_start_from
--                              );
--
--         IF     v_table_pan_construct (j).cpc_start_from = i
--            AND v_table_pan_construct (j).cpc_field_name <> 'Serial Number'
--         THEN
--            DBMS_OUTPUT.put_line (   'FIELD VALUE I '
--                                  || v_table_pan_construct (j).cpc_field_value
--                                 );
--            v_tmp_pan :=
--                        v_tmp_pan || v_table_pan_construct (j).cpc_field_value;
--            DBMS_OUTPUT.put_line (v_tmp_pan);
--            EXIT;
--         END IF;
--      END LOOP;
--   END LOOP;
--
--   FOR i IN 1 .. v_table_pan_construct.COUNT
--   LOOP
--      IF v_table_pan_construct (i).cpc_field_name = 'Serial Number'
--      THEN
--         v_serial_index := i;
--      END IF;
--   END LOOP;
--
--   IF v_serial_index IS NOT NULL
--   THEN
--      v_serial_maxlength := v_table_pan_construct (v_serial_index).cpc_length;
--      DBMS_OUTPUT.put_line ('SERIAL MAX LENGTH ' || v_serial_maxlength);
--      lp_pan_srno (prm_instcode,
--                   prm_lupduser,
--                   v_tmp_pan,
--                   v_serial_maxlength,
--                   v_serial_no,
--                   v_errmsg
--                  );
--
--      IF v_errmsg <> 'OK'
--      THEN
--         RAISE exp_reject_record;
--      END IF;
--
--      v_table_pan_construct (v_serial_index).cpc_field_value :=
--         LPAD (SUBSTR (TRIM (v_serial_no),
--                       v_table_pan_construct (v_serial_index).cpc_start,
--                       v_table_pan_construct (v_serial_index).cpc_length
--                      ),
--               v_table_pan_construct (v_serial_index).cpc_length,
--               '0'
--              );
--      DBMS_OUTPUT.put_line
--                        (   'SERIAL NO '
--                         || v_table_pan_construct (v_serial_index).cpc_field_value
--                        );
--   END IF;
--
--   DBMS_OUTPUT.put_line (v_tmp_pan);
--
--   FOR i IN 1 .. v_loop_max_cnt
--   LOOP
--      DBMS_OUTPUT.put_line ('  PRINT loop indicator ' || i);
--      DBMS_OUTPUT.put_line (   'PRINT START FROM  I  '
--                            || v_table_pan_construct (i).cpc_start_from
--                           );
--      DBMS_OUTPUT.put_line (   'PRINT FIELD NAME I  '
--                            || v_table_pan_construct (i).cpc_field_name
--                           );
--      DBMS_OUTPUT.put_line (   'PRINT FIELD VALUE I  '
--                            || v_table_pan_construct (i).cpc_field_value
--                           );
--      DBMS_OUTPUT.put_line (   'PRINT FIELD LENGTH I  '
--                            || v_table_pan_construct (i).cpc_length
--                           );
--   END LOOP;

       BEGIN
    vmscard.get_pan_srno (prm_instcode,
                          v_prod_code,
                          v_card_type,
                          v_prod_prefix,
                          v_prod_suffix,
                          v_card_start,  
                          v_card_end,
                          v_cpc_serl_flag,
                          v_prefix,
                          v_serial_no,
                          v_errmsg);

       IF V_ERRMSG <> 'OK' THEN
        RAISE EXP_REJECT_RECORD;
       END IF;
     EXCEPTION
       --Sn added by Pankaj S. on 08_May_2013 for mantis ID-11048
       WHEN EXP_REJECT_RECORD THEN
       RAISE;
       --En added by Pankaj S. 0n 08_May_2013 for mantis ID-11048
       WHEN OTHERS THEN
        V_ERRMSG := 'Error while calling get_pan_srno ' ||
                  SUBSTR(SQLERRM, 1, 300);
        RAISE EXP_REJECT_RECORD;
     END;
     
     V_TMP_PAN := NULL;
     
      BEGIN
      FOR I
         IN (SELECT cpc_profile_code,
                    cpc_field_name,
                    cpc_start_from,
                    cpc_length,
                    cpc_start
               FROM cms_pan_construct
              WHERE cpc_profile_code = V_PROFILE_CODE
                    AND cpc_inst_code = prm_instcode
                    order by cpc_start_from)
      LOOP
         IF i.cpc_field_name = 'Card Type'
         THEN
            V_TMP_PAN := V_TMP_PAN || LPAD ( SUBSTR (TRIM (V_CARD_TYPE), I.CPC_START, I.CPC_LENGTH), I.CPC_LENGTH,'0');
         ELSIF i.cpc_field_name = 'Branch'
         THEN
            V_TMP_PAN := V_TMP_PAN || LPAD ( SUBSTR (TRIM (V_APPL_BRAN), I.CPC_START, I.CPC_LENGTH),  I.CPC_LENGTH, '0');
         ELSIF i.cpc_field_name = 'BIN / PREFIX'
         THEN
            V_TMP_PAN := V_TMP_PAN || LPAD ( SUBSTR (TRIM (V_BIN), I.CPC_START, I.CPC_LENGTH),  I.CPC_LENGTH, '0');
         ELSIF i.cpc_field_name = 'PAN Product Category Prefix'
         THEN
            V_TMP_PAN := V_TMP_PAN || LPAD ( SUBSTR (TRIM (V_PREFIX), I.CPC_START, I.CPC_LENGTH),  I.CPC_LENGTH, '0');
          ELSIF i.cpc_field_name = 'Serial Number'
         THEN
            V_TMP_PAN := V_TMP_PAN || LPAD ( SUBSTR (TRIM (V_SERIAL_NO), I.CPC_START, I.CPC_LENGTH),  I.CPC_LENGTH, '0');
         END IF;
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         V_ERRMSG :=
            'Error while getting temp PAN:' || SUBSTR (SQLERRM, 1, 200);
   END;
   
   lp_pan_chkdig (v_tmp_pan, v_check_digit);
   v_pan := v_tmp_pan || v_check_digit;
   DBMS_OUTPUT.put_line (v_pan);

   BEGIN
      SELECT cam_acct_id, cam_acct_no
        INTO v_acct_id, v_acct_num
        FROM cms_acct_mast
       WHERE cam_inst_code = prm_instcode
         AND cam_acct_id =
                   (SELECT cad_acct_id
                      FROM cms_appl_det
                     WHERE cad_appl_code = prm_applcode AND cad_acct_posn = 1);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_errmsg :=
                 'No account primary  defined for appl code ' || prm_applcode;
         RAISE exp_reject_record;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting acct detail for pan '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   IF v_addon_stat = 'A'
   THEN
      BEGIN
         SELECT cam_addon_link
           INTO v_cam_addon_link
           FROM cms_appl_mast
          WHERE cam_appl_code = prm_applcode;

         SELECT cap_pan_code, cap_mbr_numb
           INTO v_adonlink, v_mbrlink
           FROM cms_appl_pan
          WHERE cap_appl_code = v_cam_addon_link;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_errmsg := 'Parent PAN not generated for ' || prm_applcode;
            RAISE exp_reject_record;
         WHEN OTHERS
         THEN
            v_errmsg := 'Excp1.1 -- ' || SQLERRM;
            RAISE exp_reject_record;
      END;
   ELSIF v_addon_stat = 'P'
   THEN
      v_adonlink := v_pan;
      v_mbrlink := '000';
   END IF;

v_card_stat := '0';  -- VMS-8219
--   BEGIN
--      SELECT cbp_param_value
--        INTO v_card_stat
--        FROM cms_bin_param
--       WHERE cbp_profile_code = v_profile_code AND cbp_param_name = 'Status';
--
--      IF v_card_stat IS NULL
--      THEN
--         v_errmsg := 'Status is null for profile code ' || v_profile_code;
--         RAISE exp_reject_record;
--      END IF;
--   EXCEPTION
--      WHEN exp_reject_record
--      THEN
--         RAISE;
--      WHEN NO_DATA_FOUND
--      THEN
--         v_errmsg :=
--                  'Status is not defined for profile code ' || v_profile_code;
--         RAISE exp_reject_record;
--      WHEN OTHERS
--      THEN
--         v_errmsg :=
--             'Error while selecting card status ' || SUBSTR (SQLERRM, 1, 200);
--         RAISE exp_reject_record;
--   END;

   BEGIN
      SELECT cbp_param_value
        INTO v_offline_atm_limit
        FROM cms_bin_param
       WHERE cbp_profile_code = v_profile_code
         AND cbp_param_name = 'Offline ATM Limit';

      IF v_card_stat IS NULL
      THEN
         v_offline_atm_limit := 0;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_offline_atm_limit := 0;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting offline ATM limit '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   BEGIN
      SELECT cbp_param_value
        INTO v_online_atm_limit
        FROM cms_bin_param
       WHERE cbp_profile_code = v_profile_code
         AND cbp_param_name = 'Online ATM Limit';

      IF v_card_stat IS NULL
      THEN
         v_offline_atm_limit := 0;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_online_atm_limit := 0;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting online ATM limit '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   BEGIN
      SELECT cbp_param_value
        INTO v_online_pos_limit
        FROM cms_bin_param
       WHERE cbp_profile_code = v_profile_code
         AND cbp_param_name = 'Online POS Limit';

      IF v_card_stat IS NULL
      THEN
         v_online_pos_limit := 0;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_online_pos_limit := 0;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting online POS limit '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   BEGIN
      SELECT cbp_param_value
        INTO v_offline_pos_limit
        FROM cms_bin_param
       WHERE cbp_profile_code = v_profile_code
         AND cbp_param_name = 'Offline POS Limit';

      IF v_card_stat IS NULL
      THEN
         v_offline_pos_limit := 0;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_offline_pos_limit := 0;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting offline POS limit '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   v_offline_aggr_limit := v_offline_pos_limit + v_offline_pos_limit;
   v_online_aggr_limit := v_online_atm_limit + v_online_pos_limit;

   BEGIN
      SELECT cbp_param_value
        INTO v_expryparam
        FROM cms_bin_param
       WHERE cbp_profile_code = v_profile_code AND cbp_param_name = 'Validity';

      v_expry_date := LAST_DAY (ADD_MONTHS (SYSDATE, v_expryparam - 1));
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_errmsg := 'No validity data found for profile ' || v_profile_code;
         RAISE exp_reject_record;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while selecting offline POS limit '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   v_issueflag := 'N';

   BEGIN
      INSERT INTO cms_appl_pan
                  (cap_appl_code, cap_inst_code, cap_asso_code,
                   cap_inst_type, cap_prod_code, cap_prod_catg,
                   cap_card_type, cap_cust_catg, cap_pan_code, cap_mbr_numb,
                   cap_card_stat, cap_cust_code, cap_disp_name,
                   cap_limit_amt, cap_use_limit, cap_appl_bran,
                   cap_active_date, cap_expry_date, cap_addon_stat,
                   cap_addon_link, cap_mbr_link, cap_acct_id, cap_acct_no,
                   cap_tot_acct, cap_bill_addr, cap_chnl_code,
                   cap_pangen_date, cap_pangen_user, cap_cafgen_flag,
                   cap_pin_flag, cap_embos_flag, cap_phy_embos,
                   cap_join_feecalc, cap_next_bill_date, cap_request_id,
                   cap_issue_flag, cap_ins_user, cap_lupd_user,
                   cap_atm_offline_limit, cap_atm_online_limit,
                   cap_pos_offline_limit, cap_pos_online_limit,
                   cap_offline_aggr_limit, cap_online_aggr_limit,
                   cap_firsttime_topup, cap_inv_flag
                  )
           VALUES (prm_applcode, prm_instcode, v_asso_code,
                   v_inst_type, v_prod_code, v_cpm_catg_code,
                   v_card_type, v_cust_catg, v_pan, '000',
                   v_card_stat, v_cust_code, v_disp_name,
                   v_limit_amt, v_use_limit, v_appl_bran,
                   v_active_date, v_expry_date, v_addon_stat,
                   v_adonlink, v_mbrlink, v_acct_id, v_pan,
                   v_tot_acct, v_bill_addr, v_chnl_code,
                   SYSDATE, prm_lupduser, 'N',
                   v_pingen_flag, v_emboss_flag, 'N',
                   'N', NULL, v_request_id,
                   v_issueflag, prm_lupduser, prm_lupduser,
                   v_offline_atm_limit, v_online_atm_limit,
                   v_offline_pos_limit, v_online_pos_limit,
                   v_offline_aggr_limit, v_online_aggr_limit,
                   'N', 'I'
                  );
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         v_errmsg :=
                   'Pan ' || v_pan || ' is already present in the Pan_master';
         RAISE exp_reject_record;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while inserting records into pan master '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   FOR x IN c1 (prm_applcode)
   LOOP
      BEGIN
         INSERT INTO cms_pan_acct
                     (cpa_inst_code, cpa_cust_code, cpa_acct_id,
                      cpa_acct_posn, cpa_pan_code, cpa_mbr_numb,
                      cpa_ins_user, cpa_lupd_user
                     )
              VALUES (prm_instcode, v_cust_code, x.cad_acct_id,
                      x.cad_acct_posn, v_pan, '000',
                      prm_lupduser, prm_lupduser
                     );

         EXIT WHEN c1%NOTFOUND;
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            v_errmsg :=
                  'Duplicate record exist  in pan acct master for pan  '
               || v_pan
               || 'acct id '
               || x.cad_acct_id;
            RAISE exp_reject_record;
         WHEN OTHERS
         THEN
            v_errmsg :=
                  'Error while inserting records into pan acct  master '
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_record;
      END;
   END LOOP;

   BEGIN
      UPDATE cms_acct_mast
         SET cam_acct_no = v_pan
       WHERE cam_inst_code = prm_instcode AND cam_acct_no = v_acct_num;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'Error while updating account number ';
         RAISE exp_reject_record;
      END IF;
   EXCEPTION
      WHEN exp_reject_record
      THEN
         RAISE;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while updating record in Acct_mast '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   BEGIN
      UPDATE pcms_issuanceentry_update
         SET ciu_pan_code = v_pan
       WHERE ciu_appl_code = prm_applcode;

      IF SQL%ROWCOUNT = 0
      THEN
         prm_errmsg := 'Error while updating issuanceentry_update ';
         RAISE exp_reject_record;
      END IF;
   EXCEPTION
      WHEN exp_reject_record
      THEN
         RAISE;
      WHEN OTHERS
      THEN
         prm_errmsg :=
               'Error while updating record in issuanceentry_update'
            || SUBSTR (SQLERRM, 1, 200);
   END;

   IF v_cpm_catg_code = 'P'
   THEN
      BEGIN
         SELECT cfp_crgl_code, cfp_crgl_catg, cfp_crsubgl_code,
                cfp_cracct_no, cfp_drgl_code, cfp_drgl_catg,
                cfp_drsubgl_code, cfp_dracct_no
           INTO v_cr_gl_code, v_crgl_catg, v_crsubgl_code,
                v_cracct_no, v_dr_gl_code, v_drgl_catg,
                v_drsubgl_code, v_dracct_no
           FROM cms_func_prod
          WHERE cfp_func_code = 'CRDISS'
            AND cfp_prod_code = v_prod_code
            AND cfp_prod_cattype = v_card_type;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_errmsg :=
                  'GL detail is not defined for func code  Card Issuance  prod code '
               || v_prod_code
               || 'card type '
               || v_card_type;
            RAISE exp_reject_record;
         WHEN OTHERS
         THEN
            v_errmsg :=
                  'Error while selecting gl details for card issuance '
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_record;
      END;

      IF v_cr_gl_code IS NULL OR v_crsubgl_code IS NULL
      THEN
         v_errmsg := 'Credit GL or SUB  GL cannot be null for card issuance';
         RAISE exp_reject_record;
      END IF;

      BEGIN
         SELECT 1
           INTO v_gl_check
           FROM cms_gl_mast
          WHERE cgm_gl_code = v_cr_gl_code;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_errmsg :=
                       'GL code is not defined for txn code ' || v_cr_gl_code;
            RAISE exp_reject_record;
         WHEN OTHERS
         THEN
            v_errmsg :=
                  'Error while selecting gl code from master '
               || SUBSTR (SQLERRM, 1, 300);
            RAISE exp_reject_record;
      END;

      BEGIN
         SELECT csm_subgl_desc
           INTO v_subgl_desc
           FROM cms_sub_gl_mast
          WHERE csm_gl_code = v_cr_gl_code AND csm_subgl_code = v_crsubgl_code;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_errmsg :=
                   'Sub gl code is not defined for txn code ' || v_cr_gl_code;
            RAISE exp_reject_record;
         WHEN OTHERS
         THEN
            v_errmsg :=
                  'Error while selecting sub gl code from master '
               || SUBSTR (SQLERRM, 1, 300);
            RAISE exp_reject_record;
      END;

      BEGIN
         INSERT INTO cms_gl_acct_mast
                     (cga_inst_code, cga_glcatg_code,
                      cga_gl_code, cga_subgl_code, cga_acct_code,
                      cga_acct_desc, cga_tran_amt, cga_ins_date,
                      cga_lupd_user, cga_lupd_date
                     )
              VALUES (prm_instcode, SUBSTR (v_crgl_catg, 1, 1),
                      v_cr_gl_code, v_crsubgl_code, v_pan,
                      v_subgl_desc || 'acct', 0, SYSDATE,
                      prm_lupduser, SYSDATE
                     );
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            v_errmsg :=
                  'Problem while inserting records into glacctmast duplicate record found for acct code '
               || v_cracct_no;
            RAISE exp_reject_record;
         WHEN OTHERS
         THEN
            v_errmsg :=
                  'Error while selecting sub gl code from master '
               || SUBSTR (SQLERRM, 1, 300);
            RAISE exp_reject_record;
      END;

      IF v_initial_topup_amount > 0
      THEN
         BEGIN
            SELECT cfm_txn_code, cfm_txn_mode, cfm_delivery_channel,
                   cfm_txn_type, cfm_func_desc
              INTO v_tran_code, v_tran_mode, v_delv_chnl,
                   v_tran_type, v_func_desc
              FROM cms_func_mast
             WHERE cfm_func_code = 'INILOAD';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_errmsg :=
                     v_func_desc || 'Function code not defined for txn code ';
               RAISE exp_reject_record;
            WHEN TOO_MANY_ROWS
            THEN
               v_errmsg :=
                     'More than one function defined for txn code '
                  || v_tran_code;
               RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               v_errmsg :=
                     'Error while selecting func code from master '
                  || SUBSTR (SQLERRM, 1, 300);
               RAISE exp_reject_record;
         END;

         sp_create_issuance_gl_data (prm_instcode,
                                     SYSDATE,
                                     v_tran_code,
                                     v_tran_mode,
                                     v_tran_type,
                                     v_delv_chnl,
                                     v_pan,
                                     v_prod_code,
                                     v_card_type,
                                     v_cr_gl_code,
                                     v_crsubgl_code,
                                     v_initial_topup_amount,
                                     prm_lupduser,
                                     v_errmsg
                                    );

         IF (v_errmsg <> 'OK')
         THEN
            RAISE exp_reject_record;
         END IF;
      END IF;
   END IF;

   BEGIN
      UPDATE cms_appl_mast
         SET cam_appl_stat = 'Y',
             cam_lupd_user = prm_lupduser,
             cam_process_msg = 'SUCCESSFUL'
       WHERE cam_appl_code = prm_applcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'Error while updating records in appl mast  '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   prm_errmsg := 'OK';
   prm_applprocess_msg := 'OK';
EXCEPTION
   WHEN exp_reject_record
   THEN
      ROLLBACK TO v_savepoint;
      prm_errmsg := v_errmsg;

      UPDATE cms_appl_mast
         SET cam_appl_stat = 'E',
             cam_process_msg = v_errmsg,
             cam_lupd_user = prm_lupduser
       WHERE cam_appl_code = prm_applcode;

      prm_applprocess_msg := v_errmsg;
      prm_errmsg := 'OK';
   WHEN OTHERS
   THEN
      ROLLBACK TO v_savepoint;
      prm_errmsg :=
            'Error while processing application for pan gen '
         || SUBSTR (SQLERRM, 1, 200);
      prm_applprocess_msg :=
            'Error while processing application for pan gen '
         || SUBSTR (SQLERRM, 1, 200);
END;
/
show error
