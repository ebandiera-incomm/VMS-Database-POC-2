/* Formatted on 2012/07/02 15:14 (Formatter Plus v4.8.8) */
CREATE OR REPLACE FORCE VIEW vmscms.dmrv_entities (entity_name,
                                                   object_id,
                                                   ovid,
                                                   import_id,
                                                   model_id,
                                                   model_ovid,
                                                   structured_type_id,
                                                   structured_type_ovid,
                                                   structured_type_name,
                                                   number_data_elements,
                                                   classification_type_id,
                                                   classification_type_ovid,
                                                   classification_type_name,
                                                   allow_type_substitution,
                                                   min_volume,
                                                   expected_volume,
                                                   max_volume,
                                                   growth_rate_percents,
                                                   growth_rate_interval,
                                                   normal_form,
                                                   temporary_object_scope,
                                                   adequately_normalized,
                                                   substitution_parent,
                                                   substitution_parent_ovid,
                                                   synonyms,
                                                   synonym_to_display,
                                                   preferred_abbreviation,
                                                   supertypeentity_id,
                                                   supertypeentity_ovid,
                                                   engineering_strategy,
                                                   owner,
                                                   entity_source,
                                                   model_name,
                                                   substitution_parent_name,
                                                   supertypeentity_name,
                                                   design_ovid
                                                  )
AS
   SELECT entity_name, object_id, ovid, import_id, model_id, model_ovid,
          structured_type_id, structured_type_ovid, structured_type_name,
          number_data_elements, classification_type_id,
          classification_type_ovid, classification_type_name,
          allow_type_substitution, min_volume, expected_volume, max_volume,
          growth_rate_percents, growth_rate_interval, normal_form,
          temporary_object_scope, adequately_normalized, substitution_parent,
          substitution_parent_ovid, synonyms, synonym_to_display,
          preferred_abbreviation, supertypeentity_id, supertypeentity_ovid,
          engineering_strategy, owner, entity_source, model_name,
          substitution_parent_name, supertypeentity_name, design_ovid
     FROM dmrs_entities;


