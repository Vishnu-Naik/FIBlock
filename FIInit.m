%function FIInit
p = Simulink.Mask.get(gcb);
FIBname = p.getParameter('FIBlockName');
FIBtype = p.getParameter('FaultType');
FInjEnable = p.getParameter('FInjEnable');
FaultType = format_fault_type_name(FIBtype.Value);

FIBvalue = p.getParameter('FaultValue');

FIBevent = p.getParameter('FaultEvent');
FIBeventval = p.getParameter('EventValue');

FIBeffect = p.getParameter('FaultEffect');
FIBeffectval = p.getParameter('EffectValue');

BaseFIBvalue = get_values_from_base_ws(FIBvalue);
BaseFIBeventval = get_values_from_base_ws(FIBeventval);
BaseFIBeffectval = get_values_from_base_ws(FIBeffectval);

% global finjectors;
finjectors = containers.Map;
finjectors(FIBname.Value) = FaultInjector(FaultType, BaseFIBvalue, FIBevent.Value, BaseFIBeventval, FIBeffect.Value, BaseFIBeffectval);
try
  baseFI = evalin('base','finjectors');
catch
  baseFI = [];
  assignin('base','finjectors', finjectors);
end

finjectors = [baseFI; finjectors];

assignin('base', 'finjectors', finjectors);

faultinjector = finjectors(FIBname.Value);

faultinjector.reset_fi;

if FInjEnable.Value == "on"
%     faultinjector.fexpflag_1;
    faultinjector.enable_fault_injector(1)
else
%     faultinjector.fexpflag_0;
    faultinjector.enable_fault_injector(0)
end
disp('Init')
disp(FIBname.Value)
disp(keys(finjectors))
disp('init ends')
function FaultType = format_fault_type_name(fault_type_value)
    switch fault_type_value
        case "Stuck-at"
            FaultType = "Sensor: Stuck-at fault";
        case "Package drop"
            FaultType = "Network: Package drop";
        case "Noise"
            FaultType = "Sensor: Noise";
        case "Bit flips"
            FaultType = "Hardware: Bit flips";
        case "Time delay"
            FaultType = "Network: Time delay";
        otherwise
            FaultType = "Sensor: Offset";
    end
end

function value = get_values_from_base_ws(parameter)
    if isempty(str2double(parameter.Value))
        value = evalin('base', parameter.Value);
    else
        value = str2double(parameter.Value);
    end
end

