function error_data = es_inject_error_gen_fpr_inftime(obj, error_data, simul_time)

%     if (obj.fail_flag == 0)
%         randomNum = rand;
%         if (randomNum > 1 - obj.event_value || obj.fail_trigger == 1)
%             obj.setfail_flag(1);
%             if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
%                 obj.setstuck_value(error_data);
%             end
%         end
%     end
%     
%     error_data = es_error_data(obj, error_data);
    error_data = es_inject_error_gen_fpr(obj, error_data, simul_time, obj.effect_value);
end
