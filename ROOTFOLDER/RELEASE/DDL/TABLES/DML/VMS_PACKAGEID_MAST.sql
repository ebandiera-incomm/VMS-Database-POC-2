INSERT INTO VMSCMS.VMS_PACKAGEID_MAST(VPM_PACKAGE_ID,VPM_PACKAGE_DESC,VPM_REPLACEMENT_PACKAGE_ID,VPM_VENDOR_ID,VPM_SHIP_METHODS,VPM_INS_USER,VPM_INS_DATE,VPM_LUPD_USER,VPM_LUPD_DATE)  
(SELECT DISTINCT CPC_CARD_DETAILS,' ',CPC_CARD_DETAILS,NVL(CPC_PRINT_VENDOR,' '),' ',1,SYSDATE,1,SYSDATE FROM vmscms.CMS_PROD_CARDPACK);