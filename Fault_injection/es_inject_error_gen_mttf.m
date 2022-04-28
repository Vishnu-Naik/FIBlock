function error_data = es_inject_error_gen_mttf(fi_obj, current_data_val, current_time, fault_effect_duration)

%     isEffectTypeInfinite = contains(fi_obj.effect_type,'infinite','IgnoreCase',true);
    isEffectTypeInfinite = (fi_obj == FaultEffectEnum(FaultEffectEnum.infinite_time));
    
    if (fi_obj.mean_failure_time == 0)
        fi_obj.set_mean_failure_time(random(makedist('Normal', 'mu', fi_obj.event_value)));
    end

    if (fi_obj.fail_flag == 0 && (current_time >= fi_obj.mean_failure_time|| fi_obj.error_injection_points == 1))
        fi_obj.setfail_flag(1);
        if (~isEffectTypeInfinite)
            fi_obj.setfail_time(fault_effect_duration + current_time);
        end
        
        if (current_time >= fi_obj.mean_failure_time)
            fi_obj.set_error_injection_points(1)
        end
        
%         if (strcmp(fi_obj.fault_type, 'Sensor: Stuck-at fault'))
        if (fi_obj.fault_type == FaultTypeEnum(FaultTypeEnum.stuck))
            fi_obj.setstuck_value(current_data_val);
        end
    elseif (current_time >= fi_obj.fail_time && ~isEffectTypeInfinite)
        fi_obj.setfail_flag(0);
        if (current_time > fi_obj.mean_failure_time)
            fi_obj.set_mean_failure_time(current_time + random(makedist('Normal', 'mu', fi_obj.event_value)));
        end
    elseif (fi_obj.error_injection_points == 1 && ~isEffectTypeInfinite)
         fi_obj.set_error_injection_points(0)
    end
    
    error_data = es_error_data(fi_obj, current_data_val, current_time);
end

