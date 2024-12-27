/* Formatted on 2012/07/02 15:13 (Formatter Plus v4.8.8) */
CREATE OR REPLACE FORCE VIEW vmscms.dmrv_check_constraints (dataelement_id,
                                                            dataelement_ovid,
                                                            TYPE,
                                                            SEQUENCE,
                                                            constraint_name,
                                                            text,
                                                            database_type,
                                                            container_id,
                                                            container_ovid,
                                                            container_name,
                                                            dataelement_name,
                                                            design_ovid
                                                           )
AS
   SELECT dataelement_id, dataelement_ovid, TYPE, SEQUENCE, constraint_name,
          text, database_type, container_id, container_ovid, container_name,
          dataelement_name, design_ovid
     FROM dmrs_check_constraints;


