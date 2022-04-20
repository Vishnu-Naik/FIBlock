function error_data = es_inject_error_gen_dfi_inftime(obj, error_data, simul_time)
    
    if (obj.fail_flag == 0 && (simul_time == obj.event_value|| obj.fail_trigger == 1))
        obj.setfail_flag(1);
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