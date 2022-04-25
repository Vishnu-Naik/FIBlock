function error_data = es_inject_error_gen_dfi(fi_obj, current_data_val, current_time, fault_effect_duration)

    isEffectTypeInfinite = contains(fi_obj.effect_type,'infinite','IgnoreCase',true);
    
     if (fi_obj.fail_flag == 0 && (current_time == fi_obj.event_value|| fi_obj.error_injection_points == 1))
        fi_obj.setfail_flag(1);
        if (~isEffectTypeInfinite)
            fi_obj.setfail_time(fault_effect_duration + current_time);
        end
        if (current_time == fi_obj.event_value)
            fi_obj.set_error_injection_points(1)
        end
        
        if (strcmp(fi_obj.fault_type, 'Sensor: Stuck-at fault'))
            fi_obj.setstuck_value(current_data_val);
        end
    elseif ((current_time >= fi_obj.fail_time) && (~isEffectTypeInfinite))
%     elseif ((current_time >= fi_obj.fail_time) && (fi_obj.fail_trigger ~=1) && (~isEffectTypeInfinite))
        fi_obj.setfail_flag(0);
     elseif (fi_obj.error_injection_points == 1 && ~isEffectTypeInfinite)
         fi_obj.set_error_injection_points(0)
     end
    
     error_data = es_error_data(fi_obj, current_data_val, current_time);
end
