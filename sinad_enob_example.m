% example how to estimate uncertainties of an algorithm

clear all, close all
%%%%%%%%% SETTINGS %%%%%%%%% 
% path to the qwtb:
addpath('../Q-Wave/qwtb/qwtb/')
% calculation settings:
% monte carlo:
CS.unc = 'mcm';
CS.mcm.repeats = 1e3;
CS.mcm.method = 'multicore';
CS.mcm.procno = 6;
% variation settings:
CS.var.dir = 'SINAD-ENOB';
CS.var.dir = 'freq_estimate';
CS.var.cleanfiles = 1;
%%%%%%%%% SETTINGS %%%%%%%%% 

% the SINAD-ENOB algorithm will be tested for the quality of frequency estimate
% for a selected sinewave

% generate sine wave %<<<1
% sampling frequency:
DI.fs.v = 1e4;
DI.fs.u = 0;
% record length:
M = 1e3;
% time series:
DI.t.v = [0 : 1./DI.fs.v : M./DI.fs.v];
DI.t.u = ones(size(DI.t.v)).*1e-10;
% signal amplitude
DI.A.v = 1;
% signal frequency
DI.f.v = 1e2;
% signal phase
DI.ph.v = 0;
% signal offset
DI.O.v = 0;
% sampled values:
DI.y.v = DI.A.v.*sin(2.*pi.*DI.f.v.*DI.t.v + DI.ph.v) + DI.O.v;
% add distortion at 5. harmonic and SINAD -22 dB:
harm = 5;
distortion_dB = -22;
DI.y.v = DI.y.v + DI.A.v.*10^(distortion_dB/20).*sin(2.*pi.*harm.*DI.f.v.*DI.t.v + DI.ph.v) + DI.O.v;
% uncertainties of every sample:
DI.y.u = ones(size(DI.y.v)).*1e-5;
% bit resolution
DI.bitres.v = 10;
DI.bitres.u = 0;
% full scale range
DI.FSR.v = 2;
DI.FSR.u = 0;

% uncertainties %<<<1
% suppose all estimates have uncertainty of 0.1 %
DI.A.u  = DI.A.v .*1e-4;
DI.f.u  = DI.f.v .*1e-4;
DI.ph.u = DI.ph.v.*1e-4;
DI.O.u  = DI.O.v .*1e-4;

% varied values %<<<1
% suppose we want to know the dependence of output SINADdB on the frequency
% estimate

% DIvar.f.v = linspace(99.9, 100.1, 20);%[990 : 2 : 1010];
DIvar.f.v = linspace(99.96, 100.03, 20);%[990 : 2 : 1010];

% calculation %<<<1
jobfn = qwtbvar('SINAD-ENOB', DI, DIvar, CS);

% output plotting %<<<1
[H, x, y] = qwtbvar(jobfn, 'f', 'SINADdB');
hold on
plot(xlim, -1.*[distortion_dB distortion_dB], '-')
legend('calculated SINAD','real value')

% vim settings modeline: vim: foldmarker=%<<<,%>>> fdm=marker fen ft=matlab textwidth=80 tabstop=4 shiftwidth=4
