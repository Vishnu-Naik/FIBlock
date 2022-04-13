function [error_data, error_flag, fault_type] = wrapper(data, time, name, flag)

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
        error_data = ff.finject(data, time);
        error_flag = ff.fail_flag;
        ft = ff.fault_type;	
        if error_flag == 0	
            fault_type = 0;	
        elseif (strcmp(ft, 'Sensor: Noise'))	
            fault_type = 1;	
        elseif (strcmp(ft, 'Sensor: Offset'))	
            fault_type = 2;	
        elseif (strcmp(ft, 'Hardware: Bit flips'))	
            fault_type = 3;	
        elseif (strcmp(ft, 'Sensor: Stuck-at fault'))	
            fault_type = 4;	
        elseif (strcmp(ft, 'Network: Time delay'))	
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