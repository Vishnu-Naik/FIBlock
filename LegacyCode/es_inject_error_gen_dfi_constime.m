function error_data = es_inject_error_gen_dfi_constime(obj, error_data, simul_time)
    
%     if (obj.fail_flag == 0 && (simul_time == obj.event_value|| obj.fail_trigger == 1))
%         obj.setfail_flag(1);
%         obj.setfail_time(obj.effect_value + simul_time);
%         if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
%             obj.setstuck_value(error_data);
%         end
%     elseif ((simul_time >= obj.fail_time && obj.fail_trigger ~=1))
%         obj.setfail_flag(0);
%     end
    error_data = es_inject_error_gen_dfi(obj, error_data, simul_time, obj.effect_value);
    
%     error_data = es_error_data(obj, error_data, simul_time);
end
