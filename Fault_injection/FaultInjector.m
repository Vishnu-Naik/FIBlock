classdef FaultInjector < handle
    properties (SetAccess = public)
        fault_type, fault_value, event_type, event_value, effect_type, effect_value
    end
    properties (SetAccess = private)
        fail_flag = 0;
        fail_time = 0;
        stuck_value = 0;
        past_output = 0;
        counter = 1;
        delay_counter = 0;
        fexp_flag = 1;
        fail_trigger = 0;
        mean_failure_time = 0;
        error_injection_points = 0;
    end
    
    methods
        function obj = FaultInjector(ft, fv, evt, evv, eft, efv)
            obj.fault_type = ft;
            obj.fault_value = fv;
            obj.event_type = evt;
            obj.event_value = evv;
            obj.effect_type = eft;
            obj.effect_value = efv;
        end
        function setfail_flag(obj, ff)
            obj.fail_flag = ff; 
        end
        function setfail_time(obj, flt)
            obj.fail_time = flt; 
        end
        function setstuck_value(obj, sv)
            obj.stuck_value = sv; 
        end
        function setpast_output(obj, po)
            obj.past_output(obj.counter) = po;
        end
        function incrcounter(obj)
            obj.counter = obj.counter + 1; 
        end
        function incrdelay_counter(obj)
            obj.delay_counter = obj.delay_counter + 1; 
        end
        function dicrdelay_counter(obj)
            obj.delay_counter = obj.delay_counter - 1;
            if (obj.delay_counter == 0)
                %disp(obj.counter);
            end
        end
%         function fexpflag_1(obj)
%             obj.fexp_flag = 1; 
%         end
%         function fexpflag_0(obj)
%             obj.fexp_flag = 0; 
%         end
        function enable_fault_injector(obj, flag)
            obj.fexp_flag = flag;
        end
        function setfail_trigger(obj, ft)
            obj.fail_trigger = ft;
            %disp(ft);
        end
        function set_effect_value(obj, val)
            obj.effect_value = val;
        end
        function set_mean_failure_time(obj, val)
            obj.mean_failure_time = val;
        end
        function set_error_injection_points(obj, val)
            obj.error_injection_points = val;
        end
        function reset_fi(obj)
            obj.fail_flag = 0;
            obj.fail_time = 0; 
            obj.stuck_value = 0;
            obj.past_output = 0; 
            obj.counter = 1;
            obj.delay_counter = 0;
            obj.fexp_flag = 1;
            obj.fail_trigger = 0;
            %disp('reseted');
            %disp(obj.fault_type);
        end
        function error_data = finject(obj, time_data, simul_time)
            %error_data = es_inject_error(obj, time_data, simul_time);
            error_data = time_data;
            %disp(simul_time);
            if (obj.fexp_flag == 1)
                time_delay_initiator(obj, error_data);
                switch obj.event_type
                    case 'Failure probability'
                        %disp('FPR');
                        %disp(obj.event_type);
                        %disp(obj.effect_type);
                        switch obj.effect_type
                            case 'Once'
%                                 error_data = ...
%                                     es_inject_error_gen_fpr_once(obj, time_data, simul_time);
                                   if (obj.effect_value == 0 && simul_time ~= 0)
                                        obj.set_effect_value(2*simul_time)
                                        fault_effect_duration = obj.effect_value;
                                   else
                                        fault_effect_duration = obj.effect_value;
                                   end
                                    
                            case 'Constant time'
%                                 error_data = ...
%                                     es_inject_error_gen_fpr_constime(obj, time_data, simul_time);
                                  fault_effect_duration = obj.effect_value;
                            case 'Infinite time'
%                                 error_data = ...
%                                     es_inject_error_gen_fpr_inftime(obj, time_data, simul_time);
                                    fault_effect_duration = obj.effect_value;
                            case 'Mean Time To Repair'
                                %disp('MTR');
%                                 error_data = ...
%                                     es_inject_error_gen_fpr_mttr(obj, time_data, simul_time);
                                fault_effect_duration = random(makedist('Normal','mu',obj.effect_value));
                        end
                        error_data = es_inject_error_gen_fpr(obj, error_data, simul_time, fault_effect_duration);
                    case 'Mean Time To Failure'
                        %disp('MTTF')
                        switch obj.effect_type
                            case 'Once'
                                error_data = ...
                                    es_inject_error_gen_mttf_once(obj, time_data, simul_time);
                            case 'Constant time'
                                error_data = ...
                                    es_inject_error_gen_mttf_constime(obj, time_data, simul_time);
                            case 'Infinite time'
                                error_data = ...
                                    es_inject_error_gen_mttf_inftime(obj, time_data, simul_time);
                            case 'Mean Time To Repair'
                                error_data = ...
                                    es_inject_error_gen_mttf_mttr(obj, time_data, simul_time);
                        end
                     case 'Deterministic'
                        %disp('Deterministic')
                        switch obj.effect_type
                            case 'Once'
%                                 error_data = ...
%                                     es_inject_error_gen_dfi_once(obj, time_data, simul_time);
                                if (obj.effect_value == 0 && simul_time ~= 0)
                                    obj.set_effect_value(2*simul_time)
                                    fault_effect_duration = obj.effect_value;
                                else
                                    fault_effect_duration = obj.effect_value;
                                end
                            case 'Constant time'
%                                 error_data = ...
%                                     es_inject_error_gen_dfi_constime(obj, time_data, simul_time);
                                    fault_effect_duration = obj.effect_value;
                            case 'Infinite time'
%                                 error_data = ...
%                                     es_inject_error_gen_dfi_inftime(obj, time_data, simul_time);
                                    fault_effect_duration = obj.effect_value;
                            case 'Mean Time To Repair'
%                                 error_data = ...
%                                     es_inject_error_gen_dfi_mttr(obj, time_data, simul_time);
                                    fault_effect_duration = random(makedist('Normal','mu',obj.effect_value));
                        end
                        error_data = es_inject_error_gen_dfi(obj, error_data, simul_time, fault_effect_duration);
                      case 'Manual'
                        %disp('manual')
                        switch obj.effect_type
                            case 'Once'
                                error_data = ...
                                    es_inject_error_gen_manual(obj, time_data, simul_time);
                            case 'Constant time'
                                error_data = ...
                                    es_inject_error_gen_manual(obj, time_data, simul_time);
                            case 'Infinite time'
                                error_data = ...
                                    es_inject_error_gen_manual(obj, time_data, simul_time);
                            case 'Mean Time To Repair'
                                error_data = ...
                                    es_inject_error_gen_manual(obj, time_data, simul_time);
                        end
                    case 'Failure rate distribution'
                        %disp('FRD')
                        switch obj.effect_type
                            case 'Once'
                                error_data = ...
                                    es_inject_error_gen_dist_once(obj, time_data, simul_time);
                            case 'Constant time'
                                error_data = ...
                                    es_inject_error_gen_dist_constime(obj, time_data, simul_time);
                            case 'Infinite time'
                                error_data = ...
                                    es_inject_error_gen_dist_inftime(obj, time_data, simul_time);
                            case 'Mean Time To Repair'
                                error_data = ...
                                    es_inject_error_gen_dist_mttr(obj, time_data, simul_time);
                        end
                end
             end   
            end
        end
end

function time_delay_initiator(fault_injector_obj, current_data_value)
    if (strcmp(fault_injector_obj.fault_type, 'Network: Time delay'))
        fault_injector_obj.setpast_output(current_data_value);
        fault_injector_obj.incrcounter;
    end
end
