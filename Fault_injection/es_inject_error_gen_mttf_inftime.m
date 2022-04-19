function error_data = es_inject_error_gen_mttf_inftime(obj, error_data, simul_time)
    if (strcmp(obj.fault_type, 'Network: Time delay'))
        obj.setpast_output(error_data);
        obj.incrcounter;
    end

    if (obj.mean_failure_time == 0)
        obj.set_mean_failure_time(random(makedist('Normal', 'mu', obj.event_value)));
    end
    
    if (obj.fail_flag == 0 && (simul_time >= obj.mean_failure_time|| obj.fail_trigger == 1))
        obj.setfail_flag(1);
        obj.setfail_time(obj.effect_value + simul_time);
        if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
            obj.setstuck_value(error_data);
        end
    end
    
    if (obj.fail_flag == 1)
        if (strcmp(obj.fault_type, 'Network: Time delay'))
            obj.incrdelay_counter;
        end
        error_data = es_inject_error_gen(obj, error_data);
    end
end


