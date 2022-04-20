function error_data = es_inject_error_gen_dfi_once(obj, error_data, simul_time)
    
    if (obj.effect_value == 0 && simul_time ~= 0)
        obj.set_effect_value(2*simul_time)
        disp(obj.effect_value)
    end

    if (obj.fail_flag == 0 && (simul_time == obj.event_value|| obj.fail_trigger == 1))
        obj.setfail_flag(1);
        obj.setfail_time(obj.effect_value + simul_time);
        if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
            obj.setstuck_value(error_data);
        end
    elseif (simul_time >= obj.fail_time  && obj.fail_trigger ~=1)
        obj.setfail_flag(0);
    end
    
    if (obj.fail_flag == 1)
        if (strcmp(obj.fault_type, 'Network: Time delay'))
            obj.incrdelay_counter;
        end
        error_data = es_inject_error_gen(obj, error_data);
    elseif (obj.fail_time ~= 0 && simul_time >= obj.fail_time && strcmp(obj.fault_type, 'Network: Time delay') && obj.fail_trigger ~=1)
         error_data = es_inject_error_gen(obj, error_data);
    end
end

