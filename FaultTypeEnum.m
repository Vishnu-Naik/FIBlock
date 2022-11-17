classdef  FaultTypeEnum < Simulink.Mask.EnumerationBase
   enumeration
      noise(int32(1), 'Noise')
      bias(int32(2),'Bias/Offset')
      bitflip(int32(3),'Bit flips')
      stuck(int32(4),  'Stuck-at')
      timedelay(int32(5),'Time delay')
      packagedrop(int32(6),'Package drop')
   end
 end