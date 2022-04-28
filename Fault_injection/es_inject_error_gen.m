function error_data = es_inject_error_gen(obj, time_data)
    
    switch obj.fault_type
        case FaultTypeEnum(FaultTypeEnum.noise)
            error_data = es_inject_error_noise(time_data, obj.fault_value);
        case FaultTypeEnum(FaultTypeEnum.bias)
            error_data = time_data + obj.fault_value;
        case FaultTypeEnum(FaultTypeEnum.bitflip)
            error_data = es_inject_error_bitflip(time_data, obj.fault_value);
        case FaultTypeEnum(FaultTypeEnum.stuck)
            error_data = obj.stuck_value;
        case FaultTypeEnum(FaultTypeEnum.timedelay)
            error_data = obj.past_output(obj.counter - obj.delay_counter);
%         case FaultTypeEnum(FaultTypeEnum.packagedrop)
        otherwise
            error_data = obj.fault_value;
            
    end
end
