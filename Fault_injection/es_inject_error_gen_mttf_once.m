function error_data = es_inject_error_gen_mttf_once(obj, error_data, simul_time)
    if (strcmp(obj.fault_type, 'Network: Time delay'))
        obj.setpast_output(error_data);
        obj.incrcounter;
    end
    if (obj.fail_flag == 0 && obj.fail_time == 0)
        obj.setfail_time(random(makedist('Normal', 'mu', obj.event_value)));
    end
    if (obj.fail_flag == 1 && strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
        error_data = es_inject_error_gen(obj, error_data);
    end 
    if (obj.is_error_injected == 1)
        obj.setfail_flag(0);
    end
    if (obj.fail_flag == 0 && obj.is_error_injected == 0)
        if (simul_time > obj.fail_time  || obj.fail_trigger == 1)
            obj.setfail_flag(1);
            obj.set_error_injected_flag(1);
            if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
                obj.setstuck_value(error_data);
            end
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                obj.incrdelay_counter;
            end
            error_data = es_inject_error_gen(obj, error_data);
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                obj.incrdelay_counter;
            end
        end
     elseif (obj.is_error_injected == 1 && strcmp(obj.fault_type, 'Network: Time delay'))
        error_data = es_inject_error_gen(obj, error_data);
    end
end

