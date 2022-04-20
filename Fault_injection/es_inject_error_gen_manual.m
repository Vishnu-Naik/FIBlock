function error_data = es_inject_error_gen_manual(obj, error_data, simul_time)
%     if (strcmp(obj.fault_type, 'Network: Time delay'))
%         obj.setpast_output(error_data);
%         obj.incrcounter;
%     end
    if (obj.fail_flag == 0)
        if (obj.fail_trigger == 1)
            obj.setfail_flag(1);    
            obj.setfail_time(simul_time);
            if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
                obj.setstuck_value(error_data);
            end
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                obj.incrdelay_counter;
            end
        elseif (obj.delay_counter ~= 0 && strcmp(obj.fault_type, 'Network: Time delay'))
            error_data = es_inject_error_gen(obj, error_data);
        end
    end
    if (obj.fail_flag == 1)
        if (obj.fail_trigger == 0)
            obj.setfail_flag(0);
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                error_data = es_inject_error_gen(obj, error_data);
                obj.dicrdelay_counter;
            end
        end
    end
    if (obj.fail_flag == 1)
        error_data = es_inject_error_gen(obj, error_data);
        if (simul_time ~= 0 && strcmp(obj.fault_type, 'Network: Time delay'))
            obj.incrdelay_counter;
        end
    end
end