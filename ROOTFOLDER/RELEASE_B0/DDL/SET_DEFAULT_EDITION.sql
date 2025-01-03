DEFINE DELIMETER = '-------------------------------------------------------------'
DEFINE SCRIPT_NAME = 'SET_DEFAULT_EDITION'
DEFINE EDITION_NAME = 'RELEASE_R93_POC'

PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT Script Start: &&SCRIPT_NAME
PROMPT &&DELIMETER &&SCRIPT_NAME

PROMPT Script info:
SELECT sys_context('USERENV', 'MODULE') FROM dual;

PROMPT
PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT

ALTER DATABASE DEFAULT EDITION = RELEASE_R93_POC;

PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT Script End: &&SCRIPT_NAME
PROMPT &&DELIMETER &&SCRIPT_NAME

UNDEFINE EDITION_NAME


PROMPT     *** DEFAULT_EDITION_INFO  *****

select PROPERTY_VALUE  DEFAULT_EDITION  from database_properties where property_name='DEFAULT_EDITION';



PROMPT     *** pin by hash value   *****

BEGIN

--un-pin FN_DMAPS_MAIN from old edition
FOR i IN (SELECT C.FULL_HASH_VALUE,O.NAMESPACE FROM V$DB_OBJECT_CACHE C, DBA_OBJECTS O WHERE C.OWNER='VMSCMS' AND C.OWNER=O.OWNER AND C.NAME = 'FN_DMAPS_MAIN' AND C.NAME=O.OBJECT_NAME AND C.TYPE = 'FUNCTION' AND C.TYPE=O.OBJECT_TYPE 
AND C.KEPT = 'YES' AND C.EDITION IS NOT NULL AND C.EDITION NOT IN (SELECT PROPERTY_VALUE FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_EDITION'))
LOOP
SYS.DBMS_SHARED_POOL.UNKEEP( i.FULL_HASH_VALUE, i.NAMESPACE);
END LOOP;

--pin FN_DMAPS_MAIN with current edition
FOR i IN (SELECT C.FULL_HASH_VALUE,O.NAMESPACE FROM V$DB_OBJECT_CACHE C, DBA_OBJECTS O WHERE C.OWNER='VMSCMS' AND C.OWNER=O.OWNER AND C.NAME = 'FN_DMAPS_MAIN' AND C.NAME=O.OBJECT_NAME AND C.TYPE = 'FUNCTION' AND C.TYPE=O.OBJECT_TYPE 
AND C.EDITION IS NOT NULL AND C.EDITION IN (SELECT PROPERTY_VALUE FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_EDITION'))
LOOP
SYS.DBMS_SHARED_POOL.KEEP(i.FULL_HASH_VALUE, i.NAMESPACE, 1);
END LOOP;


--un-pin FN_EMAPS_MAIN from old edition
FOR i IN (SELECT C.FULL_HASH_VALUE,O.NAMESPACE FROM V$DB_OBJECT_CACHE C, DBA_OBJECTS O WHERE C.OWNER='VMSCMS' AND C.OWNER=O.OWNER AND C.NAME = 'FN_EMAPS_MAIN' AND C.NAME=O.OBJECT_NAME AND C.TYPE = 'FUNCTION' AND C.TYPE=O.OBJECT_TYPE 
AND C.KEPT = 'YES' AND C.EDITION IS NOT NULL AND C.EDITION NOT IN (SELECT PROPERTY_VALUE FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_EDITION'))
LOOP
SYS.DBMS_SHARED_POOL.UNKEEP( i.FULL_HASH_VALUE, i.NAMESPACE);
END LOOP;

--pin FN_EMAPS_MAIN with current edition
FOR i IN (SELECT C.FULL_HASH_VALUE,O.NAMESPACE FROM V$DB_OBJECT_CACHE C, DBA_OBJECTS O WHERE C.OWNER='VMSCMS' AND C.OWNER=O.OWNER AND C.NAME = 'FN_EMAPS_MAIN' AND C.NAME=O.OBJECT_NAME AND C.TYPE = 'FUNCTION' AND C.TYPE=O.OBJECT_TYPE 
AND C.EDITION IS NOT NULL AND C.EDITION IN (SELECT PROPERTY_VALUE FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME='DEFAULT_EDITION'))
LOOP
SYS.DBMS_SHARED_POOL.KEEP(i.FULL_HASH_VALUE, i.NAMESPACE, 1);
END LOOP;


END;
/
