function [error_data, error_flag] = wrapper(data, time, name, flag)
% % d = data;
% % t = time;
% % n = name;
% % f = flag;
%global f_flag;
%f = f_flag;
error_data = data;
error_flag = 0;
global finjectors;
ff = 2;
disp('Finit s')
disp(name)
disp(keys(finjectors))
disp('Finit e')
try 
    ff = finjectors(name);
catch
    ne = name;
    warning('NOT EXIST');
    warning(name);
    %disp(n);
end
%disp(ff);
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
        %disp('injecting');
    end
end

%global faultdatas;
%faultdatas = containers.Map;
%faultdatas(n) = error_data;
%disp('____________________');
end