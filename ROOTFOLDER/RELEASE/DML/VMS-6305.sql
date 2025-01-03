DECLARE
    V_CHK_TAB   NUMBER;
    V_ERR       VARCHAR2 (1000);
    V_CNT       NUMBER (2);
BEGIN
-- TABLE: CMS_TXN_PROPERTIES

    SELECT COUNT (1)
      INTO V_CHK_TAB
      FROM ALL_OBJECTS
     WHERE     OBJECT_TYPE = 'TABLE'
           AND OWNER = 'VMSCMS'
           AND OBJECT_NAME = 'CMS_TXN_PROPERTIES_R92B2';

    IF V_CHK_TAB = 1
    THEN
      --ISR 1
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_TXN_PROPERTIES
         WHERE CTP_INST_CODE = 1 AND CTP_DELIVERY_CHANNEL = '02' AND CTP_TXN_CODE ='28' AND CTP_MSG_TYPE = '1420' AND CTP_REVERSAL_CODE = 69;
        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_TXN_PROPERTIES_R92B2 (CTP_TXN_CODE, CTP_INST_CODE, CTP_MSGBODY_PROP, CTP_HEADER_PROP, CTP_REVERSAL_CODE, CTP_MSG_TYPE, CTP_DELIVERY_CHANNEL, CTP_VALIDATION_PROP, CTP_HEADERPROP_VALIDATION, CTP_NONMANDATORY_MSGBODY_PROP, CTP_NONMANDATORY_VALIDATION)
            VALUES ('28', 1, 'ISO93PreauthCompletionReversal.properties', 'MessageHeader.properties', 69, '1420', '02', 'ISO93PreauthCompletionReversalValidation.properties', 'MessageHeaderPropValidation.properties', 'ISO93SAF-PreauthReversalNonmandatory.properties', 'ISO93SAF-PreauthReversalNonmandatoryValidation.properties');
          COMMIT;
        END IF;
        V_CNT := 0;

      --ISR 2
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_TXN_PROPERTIES
         WHERE CTP_INST_CODE = 1 AND CTP_DELIVERY_CHANNEL = '02' AND CTP_TXN_CODE ='28' AND CTP_MSG_TYPE = '1421' AND CTP_REVERSAL_CODE = 69;
        
        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_TXN_PROPERTIES_R92B2 (CTP_TXN_CODE, CTP_INST_CODE, CTP_MSGBODY_PROP, CTP_HEADER_PROP, CTP_REVERSAL_CODE, CTP_MSG_TYPE, CTP_DELIVERY_CHANNEL, CTP_VALIDATION_PROP, CTP_HEADERPROP_VALIDATION, CTP_NONMANDATORY_MSGBODY_PROP, CTP_NONMANDATORY_VALIDATION)
            VALUES ('28', 1, 'ISO93PreauthCompletionReversal.properties', 'MessageHeader.properties', 69, '1421', '02', 'ISO93PreauthCompletionReversalValidation.properties', 'MessageHeaderPropValidation.properties', 'ISO93SAF-PreauthReversalNonmandatory.properties', 'ISO93SAF-PreauthReversalNonmandatoryValidation.properties');
          COMMIT;
        END IF;
        V_CNT := 0;

      --ISR 3  
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_TXN_PROPERTIES
         WHERE CTP_INST_CODE = 1 AND CTP_DELIVERY_CHANNEL = '01' AND CTP_TXN_CODE ='12' AND CTP_MSG_TYPE = '1420' AND CTP_REVERSAL_CODE = 69;
        
        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_TXN_PROPERTIES_R92B2 (CTP_TXN_CODE, CTP_INST_CODE, CTP_MSGBODY_PROP, CTP_HEADER_PROP, CTP_REVERSAL_CODE, CTP_MSG_TYPE, CTP_DELIVERY_CHANNEL, CTP_VALIDATION_PROP, CTP_HEADERPROP_VALIDATION, CTP_NONMANDATORY_MSGBODY_PROP, CTP_NONMANDATORY_VALIDATION)
            VALUES ('12', 1, 'ISO93PreauthCompletionReversal.properties', 'MessageHeader.properties', 69, '1420', '01', 'ISO93PreauthCompletionReversalValidation.properties', 'MessageHeaderPropValidation.properties', 'ISO93SAF-PreauthReversalNonmandatory.properties', 'ISO93SAF-PreauthReversalNonmandatoryValidation.properties');
          COMMIT;
        END IF;
        V_CNT := 0;

      --ISR 4        
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_TXN_PROPERTIES
         WHERE CTP_INST_CODE = 1 AND CTP_DELIVERY_CHANNEL = '01' AND CTP_TXN_CODE ='12' AND CTP_MSG_TYPE = '1421' AND CTP_REVERSAL_CODE = 69;

        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_TXN_PROPERTIES_R92B2 (CTP_TXN_CODE, CTP_INST_CODE, CTP_MSGBODY_PROP, CTP_HEADER_PROP, CTP_REVERSAL_CODE, CTP_MSG_TYPE, CTP_DELIVERY_CHANNEL, CTP_VALIDATION_PROP, CTP_HEADERPROP_VALIDATION, CTP_NONMANDATORY_MSGBODY_PROP, CTP_NONMANDATORY_VALIDATION)
            VALUES ('12', 1, 'ISO93PreauthCompletionReversal.properties', 'MessageHeader.properties', 69, '1421', '01', 'ISO93PreauthCompletionReversalValidation.properties', 'MessageHeaderPropValidation.properties', 'ISO93SAF-PreauthReversalNonmandatory.properties', 'ISO93SAF-PreauthReversalNonmandatoryValidation.properties');
          COMMIT;
        END IF;
        V_CNT := 0;

        INSERT INTO VMSCMS.CMS_TXN_PROPERTIES
            SELECT *
              FROM VMSCMS.CMS_TXN_PROPERTIES_R92B2
             WHERE (CTP_TXN_CODE, CTP_INST_CODE, CTP_MSGBODY_PROP, CTP_HEADER_PROP, CTP_REVERSAL_CODE, CTP_MSG_TYPE, CTP_DELIVERY_CHANNEL, CTP_VALIDATION_PROP, CTP_HEADERPROP_VALIDATION, CTP_NONMANDATORY_MSGBODY_PROP, CTP_NONMANDATORY_VALIDATION)
                   NOT IN ( SELECT CTP_TXN_CODE, CTP_INST_CODE, CTP_MSGBODY_PROP, CTP_HEADER_PROP, CTP_REVERSAL_CODE, CTP_MSG_TYPE, CTP_DELIVERY_CHANNEL, CTP_VALIDATION_PROP, CTP_HEADERPROP_VALIDATION, CTP_NONMANDATORY_MSGBODY_PROP, CTP_NONMANDATORY_VALIDATION
                              FROM VMSCMS.CMS_TXN_PROPERTIES);

        DBMS_OUTPUT.PUT_LINE (SQL%ROWCOUNT || ' ROWS INSERTED ');

        COMMIT;

    END IF;
      
    V_CHK_TAB := 0;

-- TABLE: CMS_ISO_REQMAPPING
    SELECT COUNT (1)
      INTO V_CHK_TAB
      FROM ALL_OBJECTS
     WHERE     OBJECT_TYPE = 'TABLE'
           AND OWNER = 'VMSCMS'
           AND OBJECT_NAME = 'CMS_ISO_REQMAPPING_R92B2';

    IF V_CHK_TAB = 1
    THEN

        --ISR 1
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_ISO_REQMAPPING
         WHERE CIR_INST_CODE='1' AND CIR_MSG_TYPE='1420' AND CIR_TRAN_CDE='28' AND CIR_DELIVERY_CHANNEL='02' AND CIR_ISO_FUNC_CDE='*' AND CIR_ISO_TRAN_CDE='01';

        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_ISO_REQMAPPING_R92B2 (CIR_INST_CODE, CIR_MSG_TYPE, CIR_TRAN_CDE, CIR_DELIVERY_CHANNEL, CIR_INS_DATE, CIR_INS_USER, CIR_LUPD_DATE, CIR_LUPD_USER, CIR_ISO_FUNC_CDE, CIR_ISO_TRAN_CDE, CIR_ISO_MRC, CIR_FSS_ENABLED_FLAG, CIR_FSS_API_TYPE)
            VALUES ('1', '1420', '28', '02', SYSDATE, '1', SYSDATE, '1', '*', '01', '*', 'N', 'REALTIME');
          COMMIT;
        END IF;
        V_CNT := 0;

      --ISR 2
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_ISO_REQMAPPING
         WHERE CIR_INST_CODE='1' AND CIR_MSG_TYPE='1421' AND CIR_TRAN_CDE='28' AND CIR_DELIVERY_CHANNEL='02' AND CIR_ISO_FUNC_CDE='*' AND CIR_ISO_TRAN_CDE='01';
        
        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_ISO_REQMAPPING_R92B2 (CIR_INST_CODE, CIR_MSG_TYPE, CIR_TRAN_CDE, CIR_DELIVERY_CHANNEL, CIR_INS_DATE, CIR_INS_USER, CIR_LUPD_DATE, CIR_LUPD_USER, CIR_ISO_FUNC_CDE, CIR_ISO_TRAN_CDE, CIR_ISO_MRC, CIR_FSS_ENABLED_FLAG, CIR_FSS_API_TYPE)
            VALUES ('1', '1421', '28', '02', SYSDATE, '1', SYSDATE, '1', '*', '01', '*', 'N', 'REALTIME');
          COMMIT;
        END IF;
        V_CNT := 0;

      --ISR 3  
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_ISO_REQMAPPING
         WHERE CIR_INST_CODE='1' AND CIR_MSG_TYPE='1420' AND CIR_TRAN_CDE='12' AND CIR_DELIVERY_CHANNEL='01' AND CIR_ISO_FUNC_CDE='*' AND CIR_ISO_TRAN_CDE='01';

        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_ISO_REQMAPPING_R92B2 (CIR_INST_CODE, CIR_MSG_TYPE, CIR_TRAN_CDE, CIR_DELIVERY_CHANNEL, CIR_INS_DATE, CIR_INS_USER, CIR_LUPD_DATE, CIR_LUPD_USER, CIR_ISO_FUNC_CDE, CIR_ISO_TRAN_CDE, CIR_ISO_MRC, CIR_FSS_ENABLED_FLAG, CIR_FSS_API_TYPE)
            VALUES ('1', '1420', '12', '01', SYSDATE, '1', SYSDATE, '1', '*', '01', '*', 'N', 'REALTIME');
          COMMIT;
        END IF;
        V_CNT := 0;

      --ISR 4        
        SELECT COUNT (1) INTO V_CNT FROM VMSCMS.CMS_ISO_REQMAPPING
         WHERE CIR_INST_CODE='1' AND CIR_MSG_TYPE='1421' AND CIR_TRAN_CDE='12' AND CIR_DELIVERY_CHANNEL='01' AND CIR_ISO_FUNC_CDE='*' AND CIR_ISO_TRAN_CDE='01';

        IF V_CNT = 0 THEN
          INSERT INTO VMSCMS.CMS_ISO_REQMAPPING_R92B2 (CIR_INST_CODE, CIR_MSG_TYPE, CIR_TRAN_CDE, CIR_DELIVERY_CHANNEL, CIR_INS_DATE, CIR_INS_USER, CIR_LUPD_DATE, CIR_LUPD_USER, CIR_ISO_FUNC_CDE, CIR_ISO_TRAN_CDE, CIR_ISO_MRC, CIR_FSS_ENABLED_FLAG, CIR_FSS_API_TYPE)
            VALUES ('1', '1421', '12', '01', SYSDATE, '1', SYSDATE, '1', '*', '01', '*', 'N', 'REALTIME');
          COMMIT;
        END IF;
        V_CNT := 0;

        INSERT INTO VMSCMS.CMS_ISO_REQMAPPING
            SELECT *
              FROM VMSCMS.CMS_ISO_REQMAPPING_R92B2
             WHERE (CIR_INST_CODE, CIR_MSG_TYPE, CIR_TRAN_CDE, CIR_DELIVERY_CHANNEL, CIR_INS_DATE, CIR_INS_USER, CIR_LUPD_DATE, CIR_LUPD_USER, CIR_ISO_FUNC_CDE, CIR_ISO_TRAN_CDE, CIR_ISO_MRC, CIR_FSS_ENABLED_FLAG, CIR_FSS_API_TYPE)
                   NOT IN ( SELECT CIR_INST_CODE, CIR_MSG_TYPE, CIR_TRAN_CDE, CIR_DELIVERY_CHANNEL, CIR_INS_DATE, CIR_INS_USER, CIR_LUPD_DATE, CIR_LUPD_USER, CIR_ISO_FUNC_CDE, CIR_ISO_TRAN_CDE, CIR_ISO_MRC, CIR_FSS_ENABLED_FLAG, CIR_FSS_API_TYPE
                              FROM VMSCMS.CMS_ISO_REQMAPPING);

        DBMS_OUTPUT.PUT_LINE (SQL%ROWCOUNT || ' ROWS INSERTED ');

        COMMIT;

    END IF;

EXCEPTION
    WHEN OTHERS
    THEN
        V_ERR := SUBSTR (SQLERRM, 1, 100);
        DBMS_OUTPUT.PUT_LINE ('MAIN EXCP ' || V_ERR);
END;
/