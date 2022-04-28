function error_data = es_error_data(obj, current_data_value, simul_time)
    % if simul_time is not passed then default it to zero 
    if ~exist('simul_time','var')
      simul_time = 0;
    end
    
    isFaultTypeTimeDelay = (obj.fault_type == FaultTypeEnum(FaultTypeEnum.timedelay));
    
    if (obj.fail_flag == 1)
%         if (strcmp(obj.fault_type, 'Network: Time delay'))
        if (isFaultTypeTimeDelay)
            obj.incrdelay_counter;
        end
        error_data = es_inject_error_gen(obj, current_data_value);
    elseif (obj.fail_time ~= 0 && simul_time >= obj.fail_time && isFaultTypeTimeDelay && obj.fail_trigger ~=1)
         error_data = es_inject_error_gen(obj, current_data_value);
    else
        error_data = current_data_value;
    end

end

