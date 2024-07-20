% 7
% Code to Estimate Transfer Function of Model Simulink Simulation of Buck Converter
% Save result from workspace as .mat file to use in BuckConverterFeedbackController Design
% This code will take a few minutes to run
% Code will produce Bode Plot and other figures to see

function transferFunc = EstimateTransferFunctionFromBuckModel()
mdl = 'CompleteBuckConverterModel';
open_system(mdl);
ios = [linio([mdl,'/Duty'],1,'input'); linio([mdl,'/Vout'],1,'output')];
f = logspace(log10(200),log10(20000),100);
in = frest.Sinestream('Frequency',f,'Amplitude',0.03);
getSimulationTime(in)/0.02
[sysData,simlog] = frestimate(mdl,ios,in);
bopt               = bodeoptions;
bopt.Grid          = 'on';
bopt.PhaseMatching = 'on';
figure, bode(sysData,'*r',bopt)
frest.simView(simlog,in,sysData);
sysA = tfest(sysData,4)
figure, bode(sysData,'r*',sysA,bopt)
num = sysA.Numerator
den = sysA.Denominator
sys = tf(num,den)
transferFunc = sys
figure, rlocus(sys)
end

% I did not create this code, I only changed values
% Reference: Saed, Yousef Mohammad