classdef  FaultEventEnum < Simulink.Mask.EnumerationBase
   enumeration
      fpr(int32(1), 'Failure probability')
      mttf(int32(2),'Mean Time To Failure')
      dfi(int32(3),'Deterministic')
   end
 end