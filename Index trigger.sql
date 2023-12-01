CREATE OR REPLACE TRIGGER prevent_index_creation
BEFORE CREATE ON SCHEMA
DECLARE
   v_object_type   VARCHAR2 (30);
   v_object_name   VARCHAR2 (30);
BEGIN
   IF ora_dict_obj_type = 'INDEX' THEN
      -- Extract schema, object type, and object name from the statement
      v_object_type := ora_dict_obj_type;
      v_object_name := ora_dict_obj_name;

      -- Check if schema is specified
      IF INSTR (v_object_name, '.') = 0 THEN
         RAISE_APPLICATION_ERROR (
            -20001,
            'Index creation without schema is not allowed.'
         );
      END IF;
   END IF;
END prevent_index_creation;
/