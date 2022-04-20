function error_data = es_inject_error_gen_dfi_mttr(obj, error_data, simul_time)
    
%     if (obj.fail_flag == 0 && (simul_time == obj.event_value|| obj.fail_trigger == 1))
%         obj.setfail_flag(1);
%         random_value = random(makedist('Normal','mu',obj.effect_value));
%         obj.setfail_time(random_value + simul_time);
%         
%         if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
%             obj.setstuck_value(error_data);
%         end
%     elseif ((simul_time >= obj.fail_time && obj.fail_trigger ~=1))
%         obj.setfail_flag(0);
%     end
    random_value = random(makedist('Normal','mu',obj.effect_value));
%     es_inject_error_gen_dfi(obj, error_data, simul_time, random_value)
%     error_data = es_error_data(obj, error_data, simul_time);
    error_data = es_inject_error_gen_dfi(obj, error_data, simul_time, random_value);
end
