function [error_data, error_flag, fault_type, error_injection_points] = wrapper(data, time, name, flag)

error_data = data;
error_flag = 0;
global finjectors;
ff = 2;
try 
    ff = finjectors(name);
catch
    ne = name;
    warning('NOT EXIST');
    warning(name);
end

if ff ~= 2
    if (ff.fexp_flag == 1)
        if (flag > 0 && ff.fail_trigger ~= 1)
            ff.setfail_trigger(1);
            %disp(time);
        elseif flag <= 0
            ff.setfail_trigger(0);
        end
%         if (flag > 0)
            ff.set_error_injection_points(flag);
%         else
%             ff.set_error_injection_points(0);
%         end
        error_data = ff.finject(data, time);
        error_flag = ff.fail_flag;
        error_injection_points = ff.error_injection_points;
        
%         ft = ff.fault_type;	
        if error_flag == 0	
            fault_type = 0;	
        elseif (ff.fault_type == FaultTypeEnum.noise)	
            fault_type = 1;	
        elseif (ff.fault_type == FaultTypeEnum.bias)	
            fault_type = 2;	
        elseif (ff.fault_type == FaultTypeEnum.bitflip)	
            fault_type = 3;	
        elseif (ff.fault_type == FaultTypeEnum.stuck)	
            fault_type = 4;	
        elseif (ff.fault_type == FaultTypeEnum.timedelay)	
            fault_type = 5;	
        else	
            fault_type = 6;	
        end	
        fault_type = convertStringsToChars(fault_type);
        %disp('injecting');
    end
end

%global faultdatas;
%faultdatas = containers.Map;
%faultdatas(n) = error_data;
%disp('____________________');
end