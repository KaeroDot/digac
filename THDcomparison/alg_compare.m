% the FFT and MHSF algorithms will be tested for the quality of THD
% estimate for a selected signals and estimated uncertainties

function alg_compare()
    %%%%%%%%% CALCULATION SETTINGS %%%%%%%%%  %<<<1
    dev = 0; % if developement on simple computer, set to zero for final results
    % path to the qwtb:
    addpath('qwtb/')
    % calculation settings:
    % monte carlo:
    CS.verbose = 1;
    CS.unc = 'mcm';
    CS.loc = 0.6827;
    CS.cor.req = 0;
    CS.cor.gen = 0;
    CS.dof.req = 0;
    CS.dof.gen = 0;
    CS.mcm.repeats = 1e3;
    CS.mcm.verbose = 1;
    CS.mcm.method = 'multicore';
    % CS.mcm.method = 'singlecore';
    CS.mcm.procno = 6;
    CS.mcm.tmpdir = '.';
    CS.mcm.randomize = 1;
    CS.checkinputs = 1;
    % variation settings:
    CS.var.dir = ['THDcomp_' CS.unc];
    CS.var.cleanfiles = 1;
    %%%%%%%%% CALCULATION SETTINGS %%%%%%%%% 

    % general signal properties: %<<<1
    % sampling frequency:
    DI.fs.v = 1e5;
    DI.fs.u = 1e-9; % is it used somewhere?
    % record length:
    DI.L.v = 1e5;
    % signal frequency
    DI.f.v = 50.01;
    DI.f.u = 0.01; % this is uncertainty of estimate. is it used in some alg?
    % harmonics
    DI.nharm.v =  [1   2   3   4   5]; % signal harmonic multiple
    DI.A.v =  [1 0.01 0.01 0.01 0.01]; % signal amplitudes
    DI.ph.v = [0   0   0   0   0]; % signal phase
    DI.O.v =  [0   0   0   0   0]; % signal offset
    DI.noise.v = 1e-5;
    % nonsense uncertainties because qwtb checks uncertainties of all quantities:
    DI.L.u = 0;
    DI.nharm.u =  zeros(size(DI.nharm.v));
    DI.A.u =  zeros(size(DI.A.v));
    DI.ph.u =  zeros(size(DI.ph.v));
    DI.O.u =  zeros(size(DI.O.v));
    DI.noise.u =  zeros(size(DI.noise.v));

    % calculation %<<<1

    %%% Variation: noise %<<<2
    % dependence of output THD on the input noise:
    label = 'noise';
    clear DIvar;
    DIvar.noise.v = logspace(-6, 1, 20);
    if dev DIvar.noise.v = logspace(-6, 1, 2); end
    % DIvar.L.v = round(logspace(5, 6, 20));
    jobfn = processing(label, DI, DIvar, CS, 'noise', 'signal noise sigma', 'THD (percent to main harm.)');

    %%% Variation: thd value %<<<2
    % dependence of output THD on the input THD value - gradually increasing harmonics:
    label = 'thd';
    clear DIvar;
    DIvar.A.v = logspace(-6, -2, 10)'.*[1 1 1 1];
    if dev DIvar.A.v = logspace(-6, -2, 2)'.*[1 1 1 1]; end
    DIvar.A.v = [ones(size(DIvar.A.v,1), 1) DIvar.A.v];
    jobfn = processing(label, DI, DIvar, CS, 'THDref', 'signal THD value', 'THD (percent to main harm.)');

    %%% Variation: signal length, large span %<<<2
    % dependence of output THD uncertainty on the signal length:
    label = 'siglen';
    clear DIvar;
    DIvar.L.v = logspace(5, 7, 5); % 10^8 is too much for notebook, 10^6 is too much for general monte carlo method (too large matrices)
    if dev DIvar.L.v = logspace(5, 6, 2); end
    jobfn = processing(label, DI, DIvar, CS, 'L', 'signal length', 'THD (percent to main harm.)');

    %%% Variation: signal length, small span - not interresting, boring, do not do! %<<<2
    % dependence of output THD uncertainty on the signal length:
    % label = 'siglen';
    % DIvar.L.v = 1e5+[-20:0.01:20]; % 10^8 is too much for notebook

    %% Variation: signal frequency %<<<2
    % dependence of output THD on the signal frequency:
    label = 'sigfreq';
    clear DIvar;
    DIvar.f.v = 50 + [-0.5:0.01:0.5];
    if dev DIvar.f.v = 50 + [-0.5:0.1:0.5]; end
    jobfn = processing(label, DI, DIvar, CS, 'f', 'signal frequency', 'THD (percent to main harm.)');
endfunction

function jobfn = processing(label, DI, DIvar, CS, xvar, xlbl, ylbl) %<<<1
    CS.var.dir = [CS.unc '_' label];

    jobfn = qwtbvar('thdtest', DI, DIvar, CS);

    % output plotting
    figure('visible','off');
    hold on
    [x, y] = qwtbvar(jobfn, xvar, 'thdffterr');
    plot(x.v, y.v, '-xr');
    plot(x.v, y.v - y.u, '-r');
    plot(x.v, y.v + y.u, '-r');
    [x, y] = qwtbvar(jobfn, xvar, 'thdmfsferr');
    plot(x.v, y.v, '-xb');
    plot(x.v, y.v - y.u, '-b');
    plot(x.v, y.v + y.u, '-b');
    xlabel(xlbl);
    ylabel(ylbl);
    legend('wfft', 'neg', 'pos', 'mfsf', 'neg', 'pos');
    title(jobfn);
    hold off
    pltfn = fullfile(CS.var.dir, label);
    printplt(pltfn); replot_to_pdf(pltfn); plot_change_gnuplot_terminal(CS.var.dir);

endfunction


% vim settings modeline: vim: foldmarker=%<<<,%>>> fdm=marker fen ft=octave textwidth=80 tabstop=4 shiftwidth=4
