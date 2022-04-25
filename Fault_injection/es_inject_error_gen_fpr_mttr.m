function error_data = es_inject_error_gen_fpr_mttr(obj, error_data, simul_time)
 
%     if (obj.fail_flag == 0)
%         randomNum = rand;
%         if (randomNum > 1 - obj.event_value || obj.fail_trigger == 1)
%             random_value = random(makedist('Normal','mu',obj.effect_value));
%             obj.setfail_time(random_value + simul_time);
%             obj.setfail_flag(1);
%             if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
%                 obj.setstuck_value(error_data);
%             end
%         end
%     elseif ((simul_time >= obj.fail_time && obj.fail_trigger ~=1))
%         obj.setfail_flag(0);
%     end
    random_value = random(makedist('Normal','mu',obj.effect_value));
    error_data = es_inject_error_gen_fpr(obj, error_data, simul_time, random_value);
    
%     error_data = es_error_data(obj, error_data, simul_time);
end
