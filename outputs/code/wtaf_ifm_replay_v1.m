function result = wtaf_ifm_replay_v1(smokeOnly)
% Replay two-mark WTAF with the archived v9 ray tracer and five-pass solver.
% From the repository root: addpath('outputs/code'); wtaf_ifm_replay_v1
% Pass true for the one-pair geometry and readout check only.
if nargin < 1, smokeOnly = false; end
codeDir = fileparts(mfilename('fullpath'));
repoDir = fileparts(fileparts(codeDir));
workDir = fullfile(repoDir,'work','wtaf-ifm-replay-v1');
if ~isfolder(workDir), mkdir(workDir); end
[api,adapterCleanup] = loadV9(codeDir,workDir); %#ok<ASGLU>
rngBefore = rng;
rngCleanup = onCleanup(@() rng(rngBefore)); %#ok<NASGU>
aa = [3;-4;0.06];                            % fixed external AA position, mm
marks = [-122.5,144.5,0; 144.3,-144.5,0];       % two known local mark positions
validationMarks = [-130,-109,0; 121,120,0];     % two illustrative off-wafer marks
trainAngles = eye(3)*100e-6;                   % paired ±rotations, radians
validationAngles = [145,0,0;0,180,0;0,0,205;105,-60,30;45,120,-95;-70,35,135]*1e-6;
ideal = api.init('ifm_corr','none');
probe = makePairs(api,ideal,aa,marks(1,:),trainAngles(2,:));
assert(all(isfinite(probe.raw),'all') && any(abs(diff(probe.raw,1,1))>1e-10));
if smokeOnly
    result = probe.raw; disp(result); return;
end

% Positions of the ten selected coefficients in the two v9 vectors.
% X: 2,3,5,6,8   Y: 2,3,6,7,8. Injection is in coefficient units, not MC IDs.
injection = [0.10;-0.13;80e-6;-50e-6;0.060;0.090;0.17;-65e-6;90e-6;-0.045];
result.method = 'Synthetic two-mark AA realignment, signed full pair displacement, no noise.';
result.runtime = version;
result.units = 'Model lengths mm; rotations rad; RMS and max: nm per XY component of (+) minus (-).';
result.aa_mm = aa;
result.train_marks_mm = marks;
result.test_marks_mm = validationMarks;
result.train_angles_urad = trainAngles*1e6;
result.test_angles_urad = validationAngles*1e6;
result.raw_channel_order = 'X1 X2 X3 Y1 Y2 Y3 Z1 Z2; single-head equivalent displacements, mm';
result.parameter_order = {'th_X(2)','th_X(3)','th_X(5)','th_X(6)','th_X(8)', ...
    'th_Y(2)','th_Y(3)','th_Y(6)','th_Y(7)','th_Y(8)'};
result.coefficient_units = {'mm/rad','mm/rad','1/rad','1/rad','mm/rad', ...
    'mm/rad','mm/rad','1/rad','1/rad','mm/rad'};
result.ablation_descriptions = struct( ...
    'perturb_all_ten','Add the indicated ten offsets to the calibrated v9 vectors.', ...
    'perturb_core_only','Set the two injected cross offsets to zero; retain calibrated cross coefficients.', ...
    'zero_reference_cross_columns','Start with v9 calibrated vectors, then set only th_X(8) and th_Y(8) to zero.');
result.injection = injection;
for mode = ["none","all6"]
    cfg = api.init('ifm_corr',char(mode));
    base = api.calibrate(cfg);                % v9's separate 300-pose reference training
    train = makePairs(api,cfg,aa,marks,trainAngles);
    test = makePairs(api,cfg,aa,validationMarks,validationAngles);
    baseTrain = differences(api,cfg,base,train);
    baseTest = differences(api,cfg,base,test);
    current = offsetCal(base,injection);
    oldTrain = differences(api,cfg,current,train);
    oldTest = differences(api,cfg,current,test);

    [final,correction,sv] = fitPairs(api,cfg,current,train,zeros(size(baseTrain)));
    [~,controlled] = fitPairs(api,cfg,current,train,baseTrain);
    summary.v9_reference_coefficients = selectedValues(base);
    summary.initial_coefficients_after_ten_injections = selectedValues(current);
    summary.final_wtaf_joint_ten_coefficients = selectedValues(final);
    summary.fixed_xy_scale = [base.th_X(1);base.th_Y(1)];
    summary.train_pairs = numel(train);
    summary.holdout_pairs = numel(test);
    summary.scaled_singular_values = sv;
    summary.scaled_condition_number = sv(1)/sv(end);
    summary.unperturbed_train = metrics(baseTrain);
    summary.before_train = metrics(oldTrain);
    summary.after_train = metrics(differences(api,cfg,final,train));
    summary.unperturbed_holdout = metrics(baseTest);
    summary.before_holdout = metrics(oldTest);
    summary.after_holdout = metrics(differences(api,cfg,final,test));
    summary.fitted_update = correction;
    summary.final_minus_original_coefficients = correction+injection;
    summary.control_error_from_injected_coefficients = controlled+injection;
    % In this control, the target is the original decoder's residual. It is
    % only used to separate numerical recovery from the v9 physical-model floor.
    assert(max(abs(controlled+injection)) < 5e-6);
    assert(summary.after_holdout.rms_nm < 0.1*summary.before_holdout.rms_nm);
    % Nested fits on the same six measured pairs. Core-only restores four
    % beam offsets plus four mean direction coefficients; the augmented fit
    % additionally restores X<-Rx and Y<-Ry. Compare on the unused marks.
    core = [1 2 3 4 6 7 8 9];
    coreInjection = injection;
    coreInjection([5 10]) = 0;
    omitCross = base;
    omitCross.th_X(8) = 0; omitCross.th_Y(8) = 0;
    starts = {current, offsetCal(base,coreInjection), omitCross};
    names = {'perturb_all_ten','perturb_core_only','zero_reference_cross_columns'};
    for trial = 1:numel(starts)
        start = starts{trial};
        eight = fitPairs(api,cfg,start,train,zeros(size(baseTrain)),core);
        ten = fitPairs(api,cfg,start,train,zeros(size(baseTrain)));
        comparison.start_cross_mm = [start.th_X(8),start.th_Y(8)];
        comparison.ten_final_cross_mm = [ten.th_X(8),ten.th_Y(8)];
        comparison.start_holdout = metrics(differences(api,cfg,start,test));
        comparison.eight_holdout = metrics(differences(api,cfg,eight,test));
        comparison.ten_holdout = metrics(differences(api,cfg,ten,test));
        summary.ablation.(names{trial}) = comparison;
    end
    summary.original_cross_mm = [base.th_X(8),base.th_Y(8)];
    summary.first_pair_readings_mm = train(1).raw;
    result.(mode) = summary;
    fprintf('%s rank 10, scaled condition %.3f; independent RMS [base before after] %.6g %.6g %.6g nm\n', ...
        mode,summary.scaled_condition_number,summary.unperturbed_holdout.rms_nm, ...
        summary.before_holdout.rms_nm,summary.after_holdout.rms_nm);
end
dataDir = fullfile(repoDir,'outputs','data');
if ~isfolder(dataDir), mkdir(dataDir); end
putText(fullfile(dataDir,'wtaf_ifm_replay_v1.json'), ...
    [jsonencode(result,'PrettyPrint',true),newline]);
end

function pairs = makePairs(api,cfg,aa,marks,angles)
% Generate independent, rigid, exactly AA-centered positive and negative poses.
% v9 uses p_world = R*(r_local+T), hence T = R'*AA - r_local.
i = 0;
for j = 1:size(marks,1)
    mark = marks(j,:).';
    for k = 1:size(angles,1)
        i = i+1;
        pairs(i).mark = mark; %#ok<AGROW>
        signs = [-1 1];
        for side = 1:2
            angle = signs(side)*angles(k,:);
            R = api.R(angle);
            T = R.'*aa - mark;
            assert(norm(R*(mark+T)-aa,inf) < 1e-12);
            m = api.measure([T.',angle],cfg);
            pairs(i).m(side) = m;
            pairs(i).raw(side,:) = [m.x1,m.x2,m.x3,m.y1,m.y2,m.y3,m.z1,m.z2];
        end
    end
end
end

function residual = differences(api,cfg,cal,pairs)
% World mark XY (+) minus (-), evaluated from the eight simulated readouts.
residual = zeros(2*numel(pairs),1);
for i = 1:numel(pairs)
    xy = zeros(2,2);
    for s = 1:2
        v = api.solve(pairs(i).m(s),cfg,cal);
        p = api.R(v([4 5 7]))*(pairs(i).mark + v(1:3).');
        xy(:,s) = p(1:2);
    end
    residual(2*i-1:2*i) = xy(:,2)-xy(:,1);
end
end

function [cal,total,sv] = fitPairs(api,cfg,cal,pairs,target,active)
% Column normalization removes the impact of different coefficient units.
% Central differences rerun the complete linked decoder, including its five iterations.
if nargin < 6, active = 1:10; end
steps = [0.02;0.02;2e-4;2e-4;0.02;0.02;0.02;2e-4;2e-4;0.02];
total = zeros(10,1);
for iter = 1:3
    r = differences(api,cfg,cal,pairs)-target;
    J = zeros(numel(r),numel(active));
    for col = 1:numel(active)
        p = active(col);
        delta = zeros(10,1); delta(p) = steps(p);
        plus = differences(api,cfg,offsetCal(cal,delta),pairs);
        minus = differences(api,cfg,offsetCal(cal,-delta),pairs);
        J(:,col) = (plus-minus)/(2*steps(p));
    end
    scale = vecnorm(J);
    assert(all(scale>0));
    Jscaled = J./scale;
    sv = svd(Jscaled);
    assert(sv(end)>sv(1)*1e-7,'Insufficient independent excitation.');
    step = zeros(10,1);
    step(active) = -(Jscaled\r)./scale.';
    cal = offsetCal(cal,step);
    total = total+step;
    if max(abs(step./steps))<1e-5, break; end
end
end

function cal = offsetCal(cal,delta)
ix = [2 3 5 6 8]; iy = [2 3 6 7 8];
cal.th_X(ix) = cal.th_X(ix) + delta(1:5);
cal.th_Y(iy) = cal.th_Y(iy) + delta(6:10);
end

function v = selectedValues(cal)
v = [cal.th_X([2 3 5 6 8]);cal.th_Y([2 3 6 7 8])];
end

function o = metrics(r)
o.rms_nm = sqrt(mean((r*1e6).^2));
o.max_abs_nm = max(abs(r))*1e6;
end

function [api,cleanup] = loadV9(codeDir,workDir)
% Build a temporary public entry point with exact local function bodies from
% the archived v9 source; this avoids starting its animation or maintaining
% a second copy of the optical model in the repository.
text = fileread(fullfile(codeDir,'sim_ws_ifm_6dof_animation_v9.m'));
start = strfind(text,'function cfg = init_ifm_geometry');
visual = strfind(text,'function paths = trace_visual_paths');
trace = strfind(text,'function opl = trace_cc_double_pass');
assert(isscalar(start) && isscalar(visual) && isscalar(trace) && start<visual && visual<trace);
directory = tempname(workDir);
mkdir(directory);
entry = fullfile(directory,'wtaf_v9_adapter.m');
header = [ "function api = wtaf_v9_adapter", ...
    "api.init = @init_ifm_geometry; api.measure = @measure_ifm;", ...
    "api.calibrate = @calibrate_ifm_corr_models; api.solve = @solve_8dof_from_ifm;", ...
    "api.R = @(a) rot_z(a(3))*rot_x(a(1))*rot_y(a(2));", "end", "" ];
putText(entry,[strjoin(cellstr(header),newline),text(start:visual-1),text(trace:end)]);
addpath(directory,'-begin');
cleanup = onCleanup(@() removeAdapter(directory,entry));
api = wtaf_v9_adapter();
end

function putText(path,content)
[fid,msg] = fopen(path,'w','n','UTF-8');
assert(fid~=-1,'Cannot open %s: %s',path,msg);
c = onCleanup(@() fclose(fid)); %#ok<NASGU>
fprintf(fid,'%s',content);
end

function removeAdapter(directory,entry)
rmpath(directory);
clear wtaf_v9_adapter
delete(entry);
rmdir(directory);
end
