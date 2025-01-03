DEFINE DELIMETER = '-------------------------------------------------------------'
DEFINE SCRIPT_NAME = 'DROP_EDITION'
DEFINE EDITION_NAME = 'RELEASE_R93_POC'

PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT Script Start: &&SCRIPT_NAME
PROMPT &&DELIMETER &&SCRIPT_NAME

PROMPT Script info:
SELECT sys_context('USERENV', 'MODULE') FROM dual;

PROMPT
PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT

COMMIT;

ALTER SESSION SET EDITION = RELEASE_R93_POC;

DROP EDITION RELEASE_R83 CASCADE;

exec dbms_editions_utilities.clean_unusable_editions;

PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT Script End: &&SCRIPT_NAME
PROMPT &&DELIMETER &&SCRIPT_NAME

UNDEFINE EDITION_NAME
