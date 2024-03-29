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
        simulation_time_period = 0;
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
        end

        function enable_fault_injector(obj, flag)
            obj.fexp_flag = flag;
        end
        function setfail_trigger(obj, ft)
            obj.fail_trigger = ft;
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
        function set_simulation_time_period(obj, val)
            obj.simulation_time_period = val;
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
        end
        function error_data = finject(obj, time_data, simul_time)
            error_data = time_data;
            if (obj.simulation_time_period == 0 && simul_time ~= 0)
                obj.set_simulation_time_period(simul_time);
            end
            
            if (obj.fexp_flag == 1)
                time_delay_initiator(obj, error_data);
                switch obj.effect_type
                    case FaultEffectEnum.once
                            obj.set_effect_value(2*obj.simulation_time_period);
                            fault_effect_duration = obj.effect_value;  
                    case FaultEffectEnum.constant_time
                          fault_effect_duration = obj.effect_value;
                    case FaultEffectEnum.infinite_time
                            fault_effect_duration = obj.effect_value;
                    case FaultEffectEnum.mttr
                        fault_effect_duration = random(makedist('Normal','mu',obj.effect_value));
                end

                switch obj.event_type
                    case FaultEventEnum.fpr 
                        error_data = es_inject_error_gen_fpr(obj, error_data, simul_time, fault_effect_duration);
                    case FaultEventEnum.mttf
                        error_data = es_inject_error_gen_mttf(obj, error_data, simul_time, fault_effect_duration);
                    case FaultEventEnum.dfi
                        error_data = es_inject_error_gen_dfi(obj, error_data, simul_time, fault_effect_duration);
                end
             end   
        end
    end
end

function time_delay_initiator(fault_injector_obj, current_data_value)
    if (fault_injector_obj.fault_type == FaultTypeEnum.timedelay)
        fault_injector_obj.setpast_output(current_data_value);
        fault_injector_obj.incrcounter;
    end
end
