DEFINE DELIMETER = '-------------------------------------------------------------'
DEFINE SCRIPT_NAME = 'CREATE_EDITION'
DEFINE NEW_EDITION_NAME = 'RELEASE_R003'
DEFINE NEW_EDITION_USER_NAME = 'VMSCMS'

PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT Script Start: &&SCRIPT_NAME
PROMPT &&DELIMETER &&SCRIPT_NAME

PROMPT Script info:
SELECT sys_context('USERENV', 'MODULE') FROM dual;

PROMPT
PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT

CREATE EDITION &&NEW_EDITION_NAME;

GRANT USE ON EDITION &&NEW_EDITION_NAME TO &&NEW_EDITION_USER_NAME;
GRANT USE ON EDITION &&NEW_EDITION_NAME TO VMSCMS_HISTORY;
GRANT USE ON EDITION &&NEW_EDITION_NAME TO DBA_OPERATIONS;
GRANT USE ON EDITION &&NEW_EDITION_NAME TO FSFW;
GRANT USE ON EDITION &&NEW_EDITION_NAME TO APP_VMS_ROLE;

PROMPT &&DELIMETER &&SCRIPT_NAME
PROMPT Script End: &&SCRIPT_NAME
PROMPT &&DELIMETER &&SCRIPT_NAME

UNDEFINE NEW_EDITION_NAME
UNDEFINE NEW_EDITION_USER_NAME
