%function FIInit
p = Simulink.Mask.get(gcb);
FIBname = p.getParameter('FIBlockName');
FIBtype = p.getParameter('FaultType');
FInjEnable = p.getParameter('FInjEnable');

FIBvalue = p.getParameter('FaultValue');

FIBevent = p.getParameter('FaultEvent');
FIBeventval = p.getParameter('EventValue');

FIBeffect = p.getParameter('FaultEffect');
FIBeffectval = p.getParameter('EffectValue');

BaseFIBvalue = get_values_from_base_ws(FIBvalue);
BaseFIBeventval = get_values_from_base_ws(FIBeventval);
BaseFIBeffectval = get_values_from_base_ws(FIBeffectval);

global finjectors;
finjectors = containers.Map;

finjectors(FIBname.Value) = FaultInjector(FaultType, BaseFIBvalue, FaultEvent, BaseFIBeventval, FaultEffect, BaseFIBeffectval);
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
    faultinjector.enable_fault_injector(1)
else
    faultinjector.enable_fault_injector(0)
end

function value = get_values_from_base_ws(parameter)
    if isempty(str2double(parameter.Value))
        value = evalin('base', parameter.Value);
    else
        value = str2double(parameter.Value);
    end
end

