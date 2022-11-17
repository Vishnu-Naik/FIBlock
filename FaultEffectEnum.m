classdef  FaultEffectEnum < Simulink.Mask.EnumerationBase
   enumeration
      once(int32(1), 'Once')
      constant_time(int32(2),'Constant time')
      infinite_time(int32(3),'Infinite time')
      mttr(int32(4),'Mean Time To Repair') 
   end
 end