% test function used for variation of TWM-THDWFFT and TWM-MFSF
function [DO, DI, CS] = thdtest(DI, CS)
    % generate signal %<<<1
    % time series:
    DI.t.v = [0 : 1./DI.fs.v : DI.L.v./DI.fs.v];
    DI.t.u = ones(size(DI.t.v)).*1e-10;
    % sampled values:
    DI.y.v = DI.A.v'.*sin(2.*pi.*DI.f.v.*DI.nharm.v'.*DI.t.v + DI.ph.v') + DI.O.v';
    DI.y.v = sum(DI.y.v, 1);
    % add noise to the data:
    DI.y.v = DI.y.v + normrnd(0,DI.noise.v,size(DI.y.v));
    % uncertainties of every sample:
    DI.y.u = ones(size(DI.y.v)).*1e-5;
    % frequency components to fit for MFSF:
    DI.ExpComp.v = DI.nharm.v;
    DI.ExpComp.u = zeros(size(DI.ExpComp.v));

    % save memory:
    DI = rmfield(DI, 't');

    % calculate thd by algorithms %<<<1
    wfftDO = qwtb('TWM-THDWFFT', DI, CS);
    mfsfDO = qwtb('TWM-MFSF', DI, CS);

    % calculate signal reference THD:
    DO.THDref.v = sum(DI.A.v(2:end).^2)^0.5./DI.A.v(1) * 100;
    % output data %<<<1
    DO.thdffterr.v = wfftDO.thd.v - DO.THDref.v;
    DO.thdffterr.u = wfftDO.thd.u;
    DO.thdmfsferr.v = mfsfDO.thd.v - DO.THDref.v;
    DO.thdmfsferr.u = mfsfDO.thd.u;
end
