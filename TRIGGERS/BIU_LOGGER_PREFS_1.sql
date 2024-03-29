--------------------------------------------------------
--  DDL for Trigger BIU_LOGGER_PREFS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "INSTITUTE"."BIU_LOGGER_PREFS" 
  before insert or update on logger_prefs 
  for each row 
begin 
  $if $$logger_no_op_install $then 
    null; 
  $else 
    :new.pref_name := upper(:new.pref_name); 
    :new.pref_type := upper(:new.pref_type); 
 
    if 1=1 
      and :new.pref_type = logger.g_pref_type_logger 
      and :new.pref_name = 'LEVEL' then 
      :new.pref_value := upper(:new.pref_value); 
    end if; 
 
    -- TODO mdsouza: 3.1.1 
    -- TODO mdsouza: if removing then decrease indent 
    -- $if $$currently_installing is null or not $$currently_installing $then 
      -- Since logger.pks may not be installed when this trigger is compiled, need to move some code here 
      if 1=1 
        and :new.pref_type = logger.g_pref_type_logger 
        and :new.pref_name = 'LEVEL' 
        and upper(:new.pref_value) not in (logger.g_off_name, logger.g_permanent_name, logger.g_error_name, logger.g_warning_name, logger.g_information_name, logger.g_debug_name, logger.g_timing_name, logger.g_sys_context_name, logger.g_apex_name) then 
        raise_application_error(-20000, '"LEVEL" must be one of the following values: ' || 
          logger.g_off_name || ', ' || logger.g_permanent_name || ', ' || logger.g_error_name || ', ' || 
          logger.g_warning_name || ', ' || logger.g_information_name || ', ' || logger.g_debug_name || ', ' || 
          logger.g_timing_name || ', ' || logger.g_sys_context_name || ', ' || logger.g_apex_name); 
      end if; 
 
      -- Allow for null to be used for Plugins, then default to NONE 
      if 1=1 
        and :new.pref_type = logger.g_pref_type_logger 
        and :new.pref_name like 'PLUGIN_FN%' 
        and :new.pref_value is null then 
        :new.pref_value := 'NONE'; 
      end if; 
 
      -- #103 
      -- Only predefined preferences and Custom Preferences are allowed 
      -- Custom Preferences must be prefixed with CUST_ 
      if 1=1 
        and :new.pref_type = logger.g_pref_type_logger 
        and :new.pref_name not in ( 
          'GLOBAL_CONTEXT_NAME' 
          ,'INCLUDE_CALL_STACK' 
          ,'INSTALL_SCHEMA' 
          ,'LEVEL' 
          ,'LOGGER_DEBUG' 
          ,'LOGGER_VERSION' 
          ,'PLUGIN_FN_ERROR' 
          ,'PREF_BY_CLIENT_ID_EXPIRE_HOURS' 
          ,'PROTECT_ADMIN_PROCS' 
          ,'PURGE_AFTER_DAYS' 
          ,'PURGE_MIN_LEVEL' 
        ) 
      then 
        raise_application_error (-20000, 'Setting system level preferences are restricted to a set list.'); 
      end if; 
 
      -- this is because the logger package is not installed yet.  We enable it in logger_configure 
      logger.null_global_contexts; 
    -- TODO mdsouza: 3.1.1 
    -- $end 
  $end -- $$logger_no_op_install 
end; 

/
ALTER TRIGGER "INSTITUTE"."BIU_LOGGER_PREFS" ENABLE;
