%% sim_ws_ifm_6dof_animation_v6.m
% 基于用户提供的 v5 扫描、显示和光线追迹，修正其名义光路的 IFM 解算。
% sim_ws_ifm_6dof_animation_v6          显示修正 C1 的动画、时序和残差
% r = sim_ws_ifm_6dof_animation_v6(false)  批量返回 C0、原 C1 和修正 C1 及逐帧残差
% 位置和 IFM 读数用 mm，角度用 rad。输出端口中的 C0 Ryz 沿用 DOCX 字面数值约定。
%
function results = sim_ws_ifm_6dof_animation_v6(showAnimation)
    if nargin < 1
        showAnimation = true;
    end
    if showAnimation
        clc; close all;
    end

    %% ==================== 1. 用户可调仿真、标记点与夸张参数 ====================
    T_total  = 4.0;      % 单程扫描时长 (s)
    N_frames = 121;      % 单程帧数
    t = linspace(0, T_total, N_frames).';
    u = t / T_total;

    % WS 内部标记点（WS 局部坐标系，单位 mm）
    P_ws_local = [0.0; 0.0; -60.0];

    % 视觉夸张倍率（仅用于 Fig 1 动画显示；物理追迹与解算均使用真实小角度位姿）
    vis.X = 1.0;
    vis.Y = 1.0;
    vis.Z = 40.0;                    % Z 夸张 40 倍（0.15 mm -> 6.0 mm）
    vis.R = deg2rad(1.0) / 1.0e-3;   % 旋转夸张 ~17.45 倍（真实 1 mrad -> 动画 1 deg）

    loop_playback = true;  % Fig 1 循环播放（关闭 Fig 1 窗口自动停止）
    pause_dt      = 0.06;  % 播放速率设为 v4 的 50%（0.03 s -> 0.06 s/帧）
    save_gif      = false; % 设为 true 可在第 1 轮导出 'ws_ifm_6dof_motion_v6.gif'
    gif_file      = 'ws_ifm_6dof_motion_v6.gif';

    %% ==================== 2. CAD 精确几何参数与 Z/Ryz 装调标定 ====================
    cfg = init_ifm_geometry();
    [theta_Z, theta_Ryz] = calibrate_z_and_ryz_models(cfg);
    c0Params = nominal_c0_parameters(cfg);

    %% ==================== 3. 规划 WS 沿 +Y 单程扫描 + 5 自由度伴随运动 ====================
    Y_true  = -80.0   + 160.0 * (0.5 - 0.5*cos(pi*u));  % mm（+Y 单程）
    X_true  =  15.0   * sin(2*pi*u);                    % mm
    Z_true  =  0.15   * sin(3*pi*u);                    % mm
    Rx_true =  0.8e-3 * sin(2*pi*u + 0.3);              % rad（±0.8 mrad）
    Ry_true =  1.0e-3 * sin(3*pi*u);                    % rad（±1.0 mrad）
    Rz_true =  0.9e-3 * cos(2*pi*u);                    % rad（±0.9 mrad）

    pose_true = [X_true, Y_true, Z_true, Rx_true, Ry_true, Rz_true];

    %% ==================== 4. 逐时刻 8 光束追迹读数 + 8 通道（含 2 冗余）解算 ====================
    beams_hist = zeros(N_frames, 8);
    dof8_hist = zeros(N_frames, 8);
    c0 = zeros(N_frames, 8);
    c1 = zeros(N_frames, 8);
    for k = 1:N_frames
        m = measure_ifm(pose_true(k, :), cfg);
        beams_hist(k, :) = [m.x1, m.x2, m.x3, m.y1, m.y2, m.y3, m.z1, m.z2];
        c1(k,:) = solve_c1_v5(m,cfg,theta_Z,theta_Ryz);
        c0(k,:) = solve_ifm_c0(m,cfg,c0Params,c1(k,:));
        dof8_hist(k,:) = solve_ifm_c1_corrected(m,cfg);
    end

    % 计算全部 8 个通道的解算残差（位置单位 nm，角度单位 urad）
    res_X   = (dof8_hist(:,1) - X_true)  * 1e6;
    res_Y   = (dof8_hist(:,2) - Y_true)  * 1e6;
    res_Z   = (dof8_hist(:,3) - Z_true)  * 1e6;
    res_Rx  = (dof8_hist(:,4) - Rx_true) * 1e6;
    res_Ryx = (dof8_hist(:,5) - Ry_true) * 1e6;
    res_Ryz = (dof8_hist(:,6) - Ry_true) * 1e6;
    res_Rzx = (dof8_hist(:,7) - Rz_true) * 1e6;
    res_Rzy = (dof8_hist(:,8) - Rz_true) * 1e6;

    fprintf('============ v6 修正 C1 单程 +Y 扫描残差统计 (Max / RMS) ============\n');
    fprintf('  X   (平移投影)         : Max = %11.4g nm   | RMS = %11.4g nm\n',   max(abs(res_X)),   rms(res_X));
    fprintf('  Y   (平移投影)     : Max = %11.4g nm   | RMS = %11.4g nm\n',   max(abs(res_Y)),   rms(res_Y));
    fprintf('  Z   (Z 均值)         : Max = %11.4g nm   | RMS = %11.4g nm\n',   max(abs(res_Z)),   rms(res_Z));
    fprintf('  Rx  (Y1/Y2/Y3)     : Max = %11.4g urad | RMS = %11.4g urad\n', max(abs(res_Rx)),  rms(res_Rx));
    fprintf('  Ryx (X1/X2/X3 主控): Max = %11.4g urad | RMS = %11.4g urad\n', max(abs(res_Ryx)), rms(res_Ryx));
    fprintf('  Ryz (Z 差分冗余)  : Max = %11.4g urad | RMS = %11.4g urad\n', max(abs(res_Ryz)), rms(res_Ryz));
    fprintf('  Rzx (X 主偏航)  : Max = %11.4g urad | RMS = %11.4g urad\n', max(abs(res_Rzx)), rms(res_Rzx));
    fprintf('  Rzy (Y 偏航冗余)  : Max = %11.4g urad | RMS = %11.4g urad\n', max(abs(res_Rzy)), rms(res_Rzy));
    fprintf('========================================================================\n');

    truth8 = pose_true(:,[1,2,3,4,5,5,6,6]);
    results = struct('time_s',t,'truePose',pose_true,'truth8',truth8, ...
        'readout_mm',beams_hist,'C0',c0,'C1',c1,'C1Corrected',dof8_hist, ...
        'C0Error',c0-truth8,'C1Error',c1-truth8,'C1CorrectedError',dof8_hist-truth8, ...
        'C0Parameters',c0Params);
    if ~showAnimation
        return
    end

    %% ==================== 5. Fig 2：6 自由度预设真值（实线）vs 解算结果（点线） ====================
    fig2 = figure(2); clf(fig2);
    set(fig2, 'Name', 'Fig 2 (v6): 6-DOF 预设真值（实线）与 IFM 解算结果（点线，含冗余项）', ...
        'Color', 'w', 'Position', [740, 80, 720, 700]);

    col_true = [0.08, 0.43, 0.72];
    col_est  = [0.88, 0.33, 0.08];
    col_red  = [0.06, 0.56, 0.44];

    labels_pos = {'X (mm)', 'Y (mm) [+Y 单程主扫]', 'Z (mm)'};
    res_pos_cell = {res_X, res_Y, res_Z};
    for i = 1:3
        subplot(3, 2, i);
        plot(t, pose_true(:, i), '-', 'Color', col_true, 'LineWidth', 2.0); hold on;
        plot(t, dof8_hist(:, i), ':', 'Color', col_est,  'LineWidth', 2.4);
        grid on; xlabel('时间 t (s)'); ylabel(labels_pos{i});
        title(sprintf('%s | Max err = %.4g nm', labels_pos{i}, max(abs(res_pos_cell{i}))), ...
              'FontSize', 9.8, 'FontWeight', 'bold');
        if i == 1
            legend({'预设真值 (实线)', 'IFM 解算 (点线)'}, 'Location', 'best');
        end
    end

    subplot(3, 2, 4);
    plot(t, Rx_true*1e3, '-', 'Color', col_true, 'LineWidth', 2.0); hold on;
    plot(t, dof8_hist(:,4)*1e3, ':', 'Color', col_est, 'LineWidth', 2.4);
    grid on; xlabel('时间 t (s)'); ylabel('Rx (mrad)');
    title(sprintf('Rx (mrad) | Max err = %.4g \\murad', max(abs(res_Rx))), ...
          'FontSize', 9.8, 'FontWeight', 'bold');

    subplot(3, 2, 5);
    plot(t, Ry_true*1e3, '-', 'Color', col_true, 'LineWidth', 2.0); hold on;
    plot(t, dof8_hist(:,5)*1e3, ':',  'Color', col_est, 'LineWidth', 2.4);
    plot(t, dof8_hist(:,6)*1e3, '-.', 'Color', col_red, 'LineWidth', 1.4);
    grid on; xlabel('时间 t (s)'); ylabel('Ry (mrad)');
    title(sprintf('Ry | Ryx:%.4g / Ryz(冗余):%.4g \\murad', max(abs(res_Ryx)), max(abs(res_Ryz))), ...
          'FontSize', 9.5, 'FontWeight', 'bold');
    legend({'真值 (实线)', 'Ryx (点线)', 'Ryz 冗余 (点划线)'}, 'Location', 'best');

    subplot(3, 2, 6);
    plot(t, Rz_true*1e3, '-', 'Color', col_true, 'LineWidth', 2.0); hold on;
    plot(t, dof8_hist(:,7)*1e3, ':',  'Color', col_est, 'LineWidth', 2.4);
    plot(t, dof8_hist(:,8)*1e3, '-.', 'Color', col_red, 'LineWidth', 1.4);
    grid on; xlabel('时间 t (s)'); ylabel('Rz (mrad)');
    title(sprintf('Rz | Rzx:%.4g / Rzy(冗余):%.4g \\murad', max(abs(res_Rzx)), max(abs(res_Rzy))), ...
          'FontSize', 9.5, 'FontWeight', 'bold');
    legend({'真值 (实线)', 'Rzx (点线)', 'Rzy 冗余 (点划线)'}, 'Location', 'best');

    sgtitle('Fig 2 (v6)：WS +Y 单程扫描 6-DOF 预设真值（实线）与 8 通道 IFM 解算（点线）', ...
            'FontSize', 12, 'FontWeight', 'bold');

    %% ==================== 6. 新增 Fig 3：解算结果与真实结果的残差时序图 ====================
    fig3 = figure(3); clf(fig3);
    set(fig3, 'Name', 'Fig 3 (v6): IFM 解算残差时序图（解算值 - 真实值，含冗余通道）', ...
        'Color', 'w', 'Position', [820, 40, 720, 700]);

    % 1-ΔX, 2-ΔY, 3-ΔZ (nm)
    res_pos_titles = {'\DeltaX 残差', '\DeltaY 残差', '\DeltaZ 残差'};
    for i = 1:3
        subplot(3, 2, i);
        r = res_pos_cell{i};
        yline(0, '--', 'Color', [0.65, 0.70, 0.75], 'LineWidth', 0.9); hold on;
        plot(t, r, '-', 'Color', col_true, 'LineWidth', 1.7);
        grid on; xlabel('时间 t (s)'); ylabel('残差 (nm)');
        title(sprintf('%s | Max=%.4g / RMS=%.4g nm', res_pos_titles{i}, max(abs(r)), rms(r)), ...
              'FontSize', 9.4, 'FontWeight', 'bold');
    end

    % 4-ΔRx (urad)
    subplot(3, 2, 4);
    yline(0, '--', 'Color', [0.65, 0.70, 0.75], 'LineWidth', 0.9); hold on;
    plot(t, res_Rx, '-', 'Color', col_true, 'LineWidth', 1.7);
    grid on; xlabel('时间 t (s)'); ylabel('残差 (\murad)');
    title(sprintf('\\DeltaRx 残差 | Max=%.4g / RMS=%.4g \\murad', max(abs(res_Rx)), rms(res_Rx)), ...
          'FontSize', 9.4, 'FontWeight', 'bold');

    % 5-ΔRy (Ryx 主控 vs Ryz 冗余)
    subplot(3, 2, 5);
    yline(0, '--', 'Color', [0.65, 0.70, 0.75], 'LineWidth', 0.9); hold on;
    plot(t, res_Ryx, '-',  'Color', col_est, 'LineWidth', 1.7);
    plot(t, res_Ryz, '--', 'Color', col_red, 'LineWidth', 1.6);
    grid on; xlabel('时间 t (s)'); ylabel('残差 (\murad)');
    title(sprintf('\\DeltaRy | Ryx:%.4g / Ryz(冗余):%.4g \\murad', max(abs(res_Ryx)), max(abs(res_Ryz))), ...
          'FontSize', 9.3, 'FontWeight', 'bold');
    legend({'0 基准', '\DeltaRyx (主控)', '\DeltaRyz (冗余)'}, 'Location', 'best');

    % 6-ΔRz (Rzx 主偏航 vs Rzy 冗余)
    subplot(3, 2, 6);
    yline(0, '--', 'Color', [0.65, 0.70, 0.75], 'LineWidth', 0.9); hold on;
    plot(t, res_Rzx, '-',  'Color', col_est, 'LineWidth', 1.7);
    plot(t, res_Rzy, '--', 'Color', col_red, 'LineWidth', 1.6);
    grid on; xlabel('时间 t (s)'); ylabel('残差 (\murad)');
    title(sprintf('\\DeltaRz | Rzx:%.4g / Rzy(冗余):%.4g \\murad', max(abs(res_Rzx)), max(abs(res_Rzy))), ...
          'FontSize', 9.3, 'FontWeight', 'bold');
    legend({'0 基准', '\DeltaRzx (式 3)', '\DeltaRzy (式 4 冗余)'}, 'Location', 'best');

    sgtitle('Fig 3 (v6)：WS 六自由度解算残差时序图（解算结果 - 预设真值）', ...
            'FontSize', 12, 'FontWeight', 'bold');

    %% ==================== 7. 预计算 WS 内部标记点空间轨迹（夸张位姿） ====================
    traj_vis = zeros(3, N_frames);
    for k = 1:N_frames
        pt = pose_true(k, :);
        pose_vis_k = [pt(1)*vis.X, pt(2)*vis.Y, pt(3)*vis.Z, ...
                      pt(4)*vis.R, pt(5)*vis.R, pt(6)*vis.R];
        T_v = pose_vis_k(1:3).';
        R_v = rot_x(pose_vis_k(4)) * rot_y(pose_vis_k(5)) * rot_z(pose_vis_k(6));
        traj_vis(:, k) = R_v * (P_ws_local + T_v);
    end

    %% ==================== 8. Fig 1：左侧 3D 往返反射光路循环动画（50% 速率）+ 右侧实时面板 ====================
    fig1 = figure(1); clf(fig1);
    set(fig1, 'Name', 'Fig 1 (v6): WS +Y 单程循环动画（50% 速率，含入射/反射光路与 8 通道面板）', ...
        'Color', 'w', 'Position', [20, 60, 1150, 710]);

    ax = axes('Parent', fig1, 'Position', [0.04, 0.13, 0.61, 0.77]);
    hold(ax, 'on'); axis(ax, 'equal'); grid(ax, 'on');
    xlabel(ax, 'X (mm)'); ylabel(ax, 'Y (mm)'); zlabel(ax, 'Z (mm)');
    xlim(ax, [-560, 560]); ylim(ax, [-480, 320]); zlim(ax, [-260, 250]);
    view(ax, -120, 24);
    camproj(ax, 'orthographic');

    ax_hud = axes('Parent', fig1, 'Position', [0.68, 0.08, 0.30, 0.84], 'Visible', 'off');
    xlim(ax_hud, [0, 1]); ylim(ax_hud, [0, 1]);
    h_hud = text(ax_hud, 0.02, 0.98, '', ...
        'FontName', 'FixedWidth', 'FontSize', 9.3, ...
        'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.97, 0.98, 0.99], ...
        'EdgeColor', [0.76, 0.82, 0.88], 'Margin', 8, 'Interpreter', 'none');

    % 8.1 静止部件
    draw_static_box(ax, -542.5, -82.5, -64, -36, 178.5, 187.0, [0.22, 0.64, 0.52], 0.60);
    draw_static_box(ax,   82.5, 542.5, -64, -36, 178.5, 187.0, [0.22, 0.64, 0.52], 0.60);
    draw_static_cylinder(ax, -0.545, 0.077, 92, 192, 23, [0.42, 0.32, 0.72], 0.28);
    text(ax, -312, -50, 206, 'ZMirror\_Left (固定)',  'Color', [0.07, 0.37, 0.35], 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    text(ax,  312, -50, 206, 'ZMirror\_Right (固定)', 'Color', [0.07, 0.37, 0.35], 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    text(ax,    0,   0, 212, 'AA (Athena)',           'Color', [0.25, 0.16, 0.48], 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

    % 8.2 移动部件（半透明 WS 便于观察内部点轨迹）
    [V_ws0, F_ws, C_ws] = build_ws_mesh(cfg);
    th = linspace(0, 2*pi, 60);
    V_waf0 = [cfg.wafer_r*cos(th); cfg.wafer_r*sin(th); zeros(size(th))];

    h_ws  = patch(ax, 'Vertices', V_ws0.', 'Faces', F_ws, 'FaceVertexCData', C_ws, ...
                  'FaceColor', 'flat', 'EdgeColor', [0.25, 0.33, 0.42], 'FaceAlpha', 0.40, 'LineWidth', 0.8);
    h_waf = patch(ax, 'XData', V_waf0(1,:), 'YData', V_waf0(2,:), 'ZData', V_waf0(3,:), ...
                  'FaceColor', [0.58, 0.76, 0.87], 'EdgeColor', [0.12, 0.23, 0.37], 'FaceAlpha', 0.52);

    h_axX = plot3(ax, [0, 90], [0, 0],  [0, 0],  'Color', [0.85, 0.15, 0.15], 'LineWidth', 2.0);
    h_axY = plot3(ax, [0, 0],  [0, 90], [0, 0],  'Color', [0.10, 0.62, 0.24], 'LineWidth', 2.0);
    h_axZ = plot3(ax, [0, 0],  [0, 0],  [0, 90], 'Color', [0.15, 0.32, 0.85], 'LineWidth', 2.0);

    % 8.3 WS 内部标记点与三维点图轨迹
    plot3(ax, traj_vis(1,:), traj_vis(2,:), traj_vis(3,:), '.', ...
          'Color', [0.88, 0.55, 0.62], 'MarkerSize', 6);
    h_traj_dots = plot3(ax, nan, nan, nan, 'o', ...
          'MarkerSize', 4.5, 'MarkerFaceColor', [0.88, 0.10, 0.26], 'MarkerEdgeColor', 'none');
    h_ws_point  = plot3(ax, nan, nan, nan, 'o', ...
          'MarkerSize', 9.5, 'MarkerFaceColor', [1.00, 0.15, 0.25], 'MarkerEdgeColor', 'k', 'LineWidth', 1.2);

    % 8.4 10 条入射/去程光（实线）+ 10 条镜面反射回程光（虚线）
    col_X     = [0.08, 0.43, 0.72];  col_X_ret  = [0.22, 0.66, 0.95];
    col_Y     = [0.48, 0.25, 0.63];  col_Y_ret  = [0.76, 0.45, 0.90];
    col_ZF    = [0.88, 0.33, 0.08];  col_ZF_ret = [0.98, 0.60, 0.14];
    col_ZR    = [0.04, 0.55, 0.56];  col_ZR_ret = [0.20, 0.80, 0.76];

    h_ray_X_in  = gobjects(3, 1);  h_ray_X_ret  = gobjects(3, 1);
    h_ray_Y_in  = gobjects(3, 1);  h_ray_Y_ret  = gobjects(3, 1);
    h_ray_ZF_in = gobjects(2, 1);  h_ray_ZF_ret = gobjects(2, 1);
    h_ray_ZR_in = gobjects(2, 1);  h_ray_ZR_ret = gobjects(2, 1);

    for i = 1:3
        h_ray_X_in(i)  = plot3(ax, nan, nan, nan, '-',  'Color', col_X,     'LineWidth', 1.9, 'Marker', 'o', 'MarkerSize', 3.6);
        h_ray_X_ret(i) = plot3(ax, nan, nan, nan, '--', 'Color', col_X_ret, 'LineWidth', 1.4, 'Marker', '^', 'MarkerSize', 3.2);
        h_ray_Y_in(i)  = plot3(ax, nan, nan, nan, '-',  'Color', col_Y,     'LineWidth', 1.9, 'Marker', 'o', 'MarkerSize', 3.6);
        h_ray_Y_ret(i) = plot3(ax, nan, nan, nan, '--', 'Color', col_Y_ret, 'LineWidth', 1.4, 'Marker', '^', 'MarkerSize', 3.2);
    end
    for i = 1:2
        h_ray_ZF_in(i)  = plot3(ax, nan, nan, nan, '-',  'Color', col_ZF,     'LineWidth', 2.1, 'Marker', 'o', 'MarkerSize', 3.6);
        h_ray_ZF_ret(i) = plot3(ax, nan, nan, nan, '--', 'Color', col_ZF_ret, 'LineWidth', 1.5, 'Marker', '^', 'MarkerSize', 3.2);
        h_ray_ZR_in(i)  = plot3(ax, nan, nan, nan, '-',  'Color', col_ZR,     'LineWidth', 1.7, 'Marker', 'o', 'MarkerSize', 3.0);
        h_ray_ZR_ret(i) = plot3(ax, nan, nan, nan, '--', 'Color', col_ZR_ret, 'LineWidth', 1.3, 'Marker', '^', 'MarkerSize', 2.8);
    end

    legend(ax, [h_ray_X_in(1), h_ray_Y_in(1), h_ray_ZF_in(1), h_ray_ZR_in(1), ...
                h_ray_X_ret(1), h_ray_ZF_ret(1), h_ws_point, h_traj_dots], ...
           {'X1-X3 入射', 'Y1-Y3 入射', 'Z1/Z2 折返去程', 'Z1/Z2 参考入射', ...
            'XY 反射回程(虚线)', 'Z 反射回程(虚线)', 'WS 内部点', '内部点轨迹(点图)'}, ...
           'Location', 'southoutside', 'NumColumns', 4, 'FontSize', 8.5);

    % 8.5 循环播放主循环（50% 播放速率）
    loop_idx = 0;
    while ishandle(fig1)
        loop_idx = loop_idx + 1;
        for k = 1:N_frames
            if ~ishandle(fig1), break; end
            pt = pose_true(k, :);
            pose_vis = [pt(1)*vis.X, pt(2)*vis.Y, pt(3)*vis.Z, ...
                        pt(4)*vis.R, pt(5)*vis.R, pt(6)*vis.R];

            T_v = pose_vis(1:3).';
            R_v = rot_x(pose_vis(4)) * rot_y(pose_vis(5)) * rot_z(pose_vis(6));
            V_ws_now  = R_v * (V_ws0  + T_v);
            V_waf_now = R_v * (V_waf0 + T_v);
            set(h_ws,  'Vertices', V_ws_now.');
            set(h_waf, 'XData', V_waf_now(1,:), 'YData', V_waf_now(2,:), 'ZData', V_waf_now(3,:));

            O_v = R_v * T_v;
            ex  = O_v + R_v * [90; 0; 0];
            ey  = O_v + R_v * [0; 90; 0];
            ez  = O_v + R_v * [0; 0; 90];
            set(h_axX, 'XData', [O_v(1), ex(1)], 'YData', [O_v(2), ex(2)], 'ZData', [O_v(3), ex(3)]);
            set(h_axY, 'XData', [O_v(1), ey(1)], 'YData', [O_v(2), ey(2)], 'ZData', [O_v(3), ey(3)]);
            set(h_axZ, 'XData', [O_v(1), ez(1)], 'YData', [O_v(2), ez(2)], 'ZData', [O_v(3), ez(3)]);

            set(h_traj_dots, 'XData', traj_vis(1, 1:k), 'YData', traj_vis(2, 1:k), 'ZData', traj_vis(3, 1:k));
            set(h_ws_point,  'XData', traj_vis(1, k),   'YData', traj_vis(2, k),   'ZData', traj_vis(3, k));

            paths = trace_visual_paths_with_reflection(pose_vis, cfg);
            for i = 1:3
                set(h_ray_X_in(i),  'XData', paths.X_in{i}(1,:),  'YData', paths.X_in{i}(2,:),  'ZData', paths.X_in{i}(3,:));
                set(h_ray_X_ret(i), 'XData', paths.X_ret{i}(1,:), 'YData', paths.X_ret{i}(2,:), 'ZData', paths.X_ret{i}(3,:));
                set(h_ray_Y_in(i),  'XData', paths.Y_in{i}(1,:),  'YData', paths.Y_in{i}(2,:),  'ZData', paths.Y_in{i}(3,:));
                set(h_ray_Y_ret(i), 'XData', paths.Y_ret{i}(1,:), 'YData', paths.Y_ret{i}(2,:), 'ZData', paths.Y_ret{i}(3,:));
            end
            for i = 1:2
                set(h_ray_ZF_in(i),  'XData', paths.ZF_in{i}(1,:),  'YData', paths.ZF_in{i}(2,:),  'ZData', paths.ZF_in{i}(3,:));
                set(h_ray_ZF_ret(i), 'XData', paths.ZF_ret{i}(1,:), 'YData', paths.ZF_ret{i}(2,:), 'ZData', paths.ZF_ret{i}(3,:));
                set(h_ray_ZR_in(i),  'XData', paths.ZR_in{i}(1,:),  'YData', paths.ZR_in{i}(2,:),  'ZData', paths.ZR_in{i}(3,:));
                set(h_ray_ZR_ret(i), 'XData', paths.ZR_ret{i}(1,:), 'YData', paths.ZR_ret{i}(2,:), 'ZData', paths.ZR_ret{i}(3,:));
            end

            title(ax, sprintf('Fig 1 (v6)：+Y 单程循环 [第 %d 轮, 0.5x 速率]  t=%.2fs  (实线入射 / 虚线反射)', ...
                  loop_idx, t(k)), 'FontSize', 10.2, 'FontWeight', 'bold');

            b = beams_hist(k, :);
            d = dof8_hist(k, :);
            hud_lines = { ...
                sprintf('====== 实时状态 (t = %.2f s) ======', t(k)), ...
                '【8 个 IFM 读数头单程光程变化】', ...
                sprintf('  X1 (上排) : %+10.6f mm', b(1)), ...
                sprintf('  X2 (上排) : %+10.6f mm', b(2)), ...
                sprintf('  X3 (下排) : %+10.6f mm', b(3)), ...
                sprintf('  Y1 (上排) : %+10.6f mm', b(4)), ...
                sprintf('  Y2 (上排) : %+10.6f mm', b(5)), ...
                sprintf('  Y3 (下排) : %+10.6f mm', b(6)), ...
                sprintf('  Z1 (净值) : %+10.6f mm', b(7)), ...
                sprintf('  Z2 (净值) : %+10.6f mm', b(8)), ...
                '------------------------------------', ...
                '【8 个自由度解算结果 (含 2 冗余)】', ...
                sprintf('  1. X   [式1]     : %+9.5f mm',   d(1)), ...
                sprintf('  2. Y   [式2]     : %+9.5f mm',   d(2)), ...
                sprintf('  3. Z   [式5]     : %+9.5f mm',   d(3)), ...
                sprintf('  4. Rx  [Y1-Y3]   : %+9.5f mrad', d(4)*1e3), ...
                sprintf('  5. Ryx [X1-X3主] : %+9.5f mrad', d(5)*1e3), ...
                sprintf('  6. Ryz [式6冗余] : %+9.5f mrad', d(6)*1e3), ...
                sprintf('  7. Rzx [式3主]   : %+9.5f mrad', d(7)*1e3), ...
                sprintf('  8. Rzy [式4冗余] : %+9.5f mrad', d(8)*1e3), ...
                '------------------------------------', ...
                '【冗余一致性实时差值】', ...
                sprintf('  |Ryz - Ryx| : %7.4f urad', abs(d(6)-d(5))*1e6), ...
                sprintf('  |Rzy - Rzx| : %7.4f urad', abs(d(8)-d(7))*1e6) };
            set(h_hud, 'String', hud_lines);

            drawnow;
            if save_gif && loop_idx == 1
                frame = getframe(fig1);
                [imind, cm] = rgb2ind(frame2im(frame), 256);
                if k == 1
                    imwrite(imind, cm, gif_file, 'gif', 'Loopcount', inf, 'DelayTime', pause_dt);
                else
                    imwrite(imind, cm, gif_file, 'gif', 'WriteMode', 'append', 'DelayTime', pause_dt);
                end
            else
                pause(pause_dt);
            end
        end
        if ~loop_playback
            break;
        end
    end
end

%% ========================================================================
%  几何初始化（严格对应 build_ifm_agent.FCMacro）
% =========================================================================
function cfg = init_ifm_geometry()
    cfg.wafer_r = 122.0;
    cfg.kx   = 400.0;  cfg.ly = 380.0;
    cfg.Kx   = 480.0;  cfg.Ly = 425.0;
    cfg.ax   = 43.5;   cfg.ay = 32.5;
    cfg.cx   = 210.0 / 4.0;  cfg.cy = 180.0 / 4.0;
    cfg.y_x1 = -105.0; cfg.y_x2 = 105.0; cfg.y_x3 = -20.0; cfg.z_x3 = -98.5;
    cfg.x_y1 =  -90.0; cfg.x_y2 =  90.0; cfg.x_y3 =  15.0; cfg.z_y3 = -100.5;
    cfg.dz_x = (-cfg.ax) - cfg.z_x3;
    cfg.dz_y = (-cfg.ay) - cfg.z_y3;

    cfg.z_head_x = 490.0;
    cfg.z_y      = -50.0;
    cfg.z_fold_x = 232.5;
    cfg.z_fold_z = -159.0;
    cfg.z_ref_z  = -114.5;
    cfg.z_top    = 178.5;
    cfg.kze      = 2.0 * cfg.z_fold_x;

    cfg.opl0 = trace_all_beams([0,0,0,0,0,0], cfg, true);
end

%% ========================================================================
%  8 光束 IFM 闭环解算全部 8 通道（6 自由度 + 2 冗余项 Ryz, Rzy）
% =========================================================================
function dof8 = solve_c1_v5(m, cfg, theta_Z, theta_Ryz)
    Rzy_est = m.my2 / (4.0 * cfg.cy);
    Ryx_est = ((m.mx1 - m.x3) - cfg.y_x3 * Rzy_est) / cfg.dz_x;
    Rx_est  = -((m.my1 - m.y3) + cfg.x_y3 * Rzy_est) / cfg.dz_y + Ryx_est * Rzy_est;
    Rzx_est = m.mx2 / (4.0 * cfg.cx) - Rx_est * Ryx_est;
    Rz_use  = Rzx_est;

    X_est = m.mx1;
    Y_est = m.my1;
    for iter = 1:3
        X_est = m.mx1 ...
              + ((X_est + cfg.Kx - cfg.kx/2)/2.0) * (Ryx_est^2 + Rz_use^2) ...
              + (cfg.Kx/2.0) * (Ryx_est^2 + Rz_use^2) ...
              + cfg.ax * Ryx_est;
        Y_est = m.my1 ...
              + ((Y_est + cfg.Ly - cfg.ly/2)/2.0) * (Rx_est^2 + Rz_use^2) ...
              + (cfg.Ly/2.0) * (Rx_est^2 + Rz_use^2) ...
              - cfg.ay * Rx_est;
    end

    Phi_Z = [m.mz1 + X_est*Rx_est*Rz_use, ...
             Y_est, X_est, Rx_est, Ryx_est, Rz_use, ...
             X_est*Ryx_est, X_est*Rz_use, Y_est*Ryx_est, X_est*Rx_est, ...
             Ryx_est^2, Rz_use^2, Rx_est^2, Rx_est*Rz_use];
    Z_est = Phi_Z * theta_Z;

    lead_ryz = (m.mz2 / cfg.kze) * (1.0 - 2.0*Z_est/cfg.kze) ...
             + (2.0/cfg.kze)*X_est*(Rx_est^2) + (4.0/cfg.kze)*X_est*(Ryx_est^2);
    Phi_Ryz = [lead_ryz, ...
               X_est, Y_est, Z_est, ...
               Rx_est, Rz_use, ...
               X_est*Rx_est, X_est*Ryx_est, X_est*Rz_use, ...
               Rx_est^2, Rx_est*Rz_use, Ryx_est^2];
    Ryz_est = Phi_Ryz * theta_Ryz;

    dof8 = [X_est, Y_est, Z_est, Rx_est, Ryx_est, Ryz_est, Rzx_est, Rzy_est];
end

function params = nominal_c0_parameters(cfg)
    % Keep C0's coefficient roles. Obtain its nominal Z coefficients from
    % zero-pose path derivatives, independently of the evaluated trajectory.
    zError = @(q) c0_z_residual(q,cfg);
    zDiff  = @(q) z_difference(q,cfg);
    h = [1,1,.1,1e-4,1e-4,1e-4];
    params.kx = 530;  % DOCX stage body width; cfg.kx is the spacing of X faces
    params.kze = derivative1(zDiff,5,1e-6);
    params.sfryz = 1; % literal numeric comparison; the DOCX omits its value/unit
    params.z = [derivative1(zError,2,h(2)), derivative1(zError,1,h(1)), ...
                derivative1(zError,4,h(4)), derivative1(zError,5,h(5)),...
                derivative1(zError,6,h(6)), ...
                derivative2(zError,1,5,h), derivative2(zError,1,6,h),...
                derivative2(zError,2,5,h), derivative2(zError,1,4,h),...
                derivative2(zError,5,5,h)/2, derivative2(zError,6,6,h)/2,...
                derivative2(zError,4,4,h)/2, derivative2(zError,4,6,h)];
    params.drxza = -derivative2(zDiff,4,6,h)/params.kze;
end

function val = c0_z_residual(q,cfg)
    m = measure_ifm(q,cfg);
    val = q(3) - m.mz1 - q(1)*q(4)*q(6);
end

function val = z_difference(q,cfg)
    m = measure_ifm(q,cfg);
    val = m.mz2;
end

function val = derivative1(fun,j,step)
    delta = zeros(1,6);
    delta(j) = step;
    val = (fun(delta)-fun(-delta))/(2*step);
end

function val = derivative2(fun,i,j,steps)
    a = zeros(1,6);
    b = zeros(1,6);
    a(i) = steps(i);
    b(j) = steps(j);
    val = (fun(a+b)-fun(a-b)-fun(-a+b)+fun(-a-b))/(4*steps(i)*steps(j));
end

function dof = solve_ifm_c0(m,cfg,params,c1)
    % C0: DOCX pages 1 and 4. Ideal zero scale errors/misalignment.
    % Both historical formulas use the same readout-derived Rx/Ryx.
    rx = c1(4);
    ry = c1(5);
    rzx = m.mx2/(4*cfg.cx)-rx*ry;
    rzy = m.my2/(4*cfg.cy);
    rz = rzx;
    axSelf = (ry^2+rz^2)/2;
    aySelf = (rx^2+rz^2)/2;
    x = (m.mx1+(cfg.Kx-params.kx/2)*axSelf+cfg.Kx*axSelf-cfg.ax*ry)/(1-axSelf);
    y = (m.my1+(-cfg.Ly+cfg.ly/2)*aySelf-cfg.Ly*axSelf+cfg.ay*ry)/(1-aySelf);
    z = m.mz1 + x*rx*rz + [y,x,rx,ry,rz,x*ry,x*rz,y*ry,x*rx,ry^2,rz^2,rx^2,rx*rz]*params.z.';
    arm = params.kze;
    ryz = params.sfryz*(m.mz2*((1-2*z/arm)/arm)^2 ...
           + 2*x*rx^2/arm + 4*x*ry^2/arm + params.drxza*rx*rz);
    dof = [x,y,z,rx,ry,ryz,rzx,rzy];
end

function dof = solve_ifm_c1_corrected(m,cfg)
    % Invert the actual v5 quarter path. With head h and face point p,
    % optical path/4 = (n.'*d)*(n.'*(p-h)) for the two-return trace.
    ux = m.mx2/(4*cfg.cx);
    vx = (m.x3-m.mx1 + cfg.y_x3*ux)/cfg.dz_x;
    uy = m.my2/(4*cfg.cy);
    vy = (m.y3-m.my1 - cfg.x_y3*uy)/cfg.dz_y;
    ax = near_axis_component(ux,vx);
    ay = near_axis_component(uy,vy);
    nx = [ax; ux/ax; vx/ax];
    ny = [-uy/ay; ay; vy/ay];
    nz = cross(nx,ny);
    rx = atan2(-nz(2),nz(3));
    ry = atan2(nz(1),hypot(nz(2),nz(3)));

    % Remove Rx and Ry using the v5 Rx*Ry*Rz order, then use each mirror.
    U = rot_y(-ry)*rot_x(-rx);
    xHeading = U*nx;
    yHeading = U*ny;
    rzx = atan2(xHeading(2),xHeading(1));
    rzy = atan2(-yHeading(1),yHeading(2));

    x = (m.mx1 + (cfg.opl0.x1+cfg.opl0.x2)/8)/ax + cfg.kx/2-cfg.Kx*ax-cfg.ax*nx(3);
    y = (m.my1 + (cfg.opl0.y1+cfg.opl0.y2)/8)/ay + cfg.ly/2-cfg.Ly*ay-cfg.ay*ny(3);

    % At fixed angles all signed plane intersections are affine in Z.
    at_zero_z = measure_ifm([x,y,0,rx,ry,rzx],cfg);
    at_one_z = measure_ifm([x,y,1,rx,ry,rzx],cfg);
    zGain = at_one_z.mz1-at_zero_z.mz1;
    if abs(zGain) < 0.5
        error('WSIFM:ZGain','The geometry does not give a usable Z mean gain.');
    end
    z = (m.mz1-at_zero_z.mz1)/zGain;

    % Independently read pitch from Z difference on the small-attitude branch.
    target = @(pitch) z_difference([x,y,z,rx,pitch,rzx],cfg)-m.mz2;
    branch = [-5e-3,5e-3];
    if target(branch(1))*target(branch(2)) > 0
        error('WSIFM:RyzRange','Z difference is outside the modelled pitch branch.');
    end
    [ryz, rootError, rootStatus] = fzero(target,branch,optimset('TolX',1e-14,'Display','off'));
    if rootStatus <= 0 || abs(rootError) > 1e-9
        error('WSIFM:RyzSolve','The Z-difference equation did not converge.');
    end
    dof = [x,y,z,rx,ry,ryz,rzx,rzy];
end

function n = near_axis_component(u,v)
    discriminant = 1-4*(u*u+v*v);
    if ~isfinite(discriminant) || discriminant < 0
        error('WSIFM:NormalDomain','The readouts cannot reconstruct the near-axis mirror normal.');
    end
    n = sqrt((1+sqrt(discriminant))/2);
end

function [theta_Z, theta_Ryz] = calibrate_z_and_ryz_models(cfg)
    rng(7);
    N_cal = 250;
    p_cal = [(2*rand(N_cal,1)-1)*100, (2*rand(N_cal,1)-1)*100, (2*rand(N_cal,1)-1)*0.4, ...
             (2*rand(N_cal,1)-1)*1.2e-3, (2*rand(N_cal,1)-1)*1.2e-3, (2*rand(N_cal,1)-1)*1.2e-3];
    mz1_cal = zeros(N_cal, 1);
    mz2_cal = zeros(N_cal, 1);
    for k = 1:N_cal
        mk = measure_ifm(p_cal(k,:), cfg);
        mz1_cal(k) = mk.mz1;
        mz2_cal(k) = mk.mz2;
    end
    X = p_cal(:,1); Y = p_cal(:,2); Z = p_cal(:,3);
    Rx = p_cal(:,4); Ry = p_cal(:,5); Rz = p_cal(:,6);

    Phi_Z = [mz1_cal + X.*Rx.*Rz, Y, X, Rx, Ry, Rz, ...
             X.*Ry, X.*Rz, Y.*Ry, X.*Rx, Ry.^2, Rz.^2, Rx.^2, Rx.*Rz];
    theta_Z = Phi_Z \ Z;

    lead_ryz = (mz2_cal ./ cfg.kze) .* (1.0 - 2.0.*Z./cfg.kze) ...
             + (2.0/cfg.kze).*X.*(Rx.^2) + (4.0/cfg.kze).*X.*(Ry.^2);
    Phi_Ryz = [lead_ryz, X, Y, Z, Rx, Rz, ...
               X.*Rx, X.*Ry, X.*Rz, Rx.^2, Rx.*Rz, Ry.^2];
    theta_Ryz = Phi_Ryz \ Ry;
end

%% ========================================================================
%  物理光线追迹（假设 IFM 总能接收反射光并解算光程变化）
% =========================================================================
function m = measure_ifm(pose, cfg)
    opl = trace_all_beams(pose, cfg, false);
    m.x1 = (opl.x1 - cfg.opl0.x1) / 4.0;
    m.x2 = (opl.x2 - cfg.opl0.x2) / 4.0;
    m.x3 = (opl.x3 - cfg.opl0.x3) / 4.0;
    m.y1 = (opl.y1 - cfg.opl0.y1) / 4.0;
    m.y2 = (opl.y2 - cfg.opl0.y2) / 4.0;
    m.y3 = (opl.y3 - cfg.opl0.y3) / 4.0;

    m.mx1 = 0.5 * (m.x1 + m.x2);
    m.mx2 = m.x1 - m.x2;
    m.my1 = 0.5 * (m.y1 + m.y2);
    m.my2 = m.y2 - m.y1;

    m.z1  = -((opl.z1_f - cfg.opl0.z1_f) - (opl.z1_r - cfg.opl0.z1_r)) / 2.0;
    m.z2  = -((opl.z2_f - cfg.opl0.z2_f) - (opl.z2_r - cfg.opl0.z2_r)) / 2.0;
    m.mz1 = 0.5 * (m.z1 + m.z2);
    m.mz2 = m.z1 - m.z2;
end

function opl = trace_all_beams(pose, cfg, is_zero)
    if is_zero
        T = [0;0;0]; R = eye(3);
    else
        T = pose(1:3).';
        R = rot_x(pose(4)) * rot_y(pose(5)) * rot_z(pose(6));
    end
    xform = @(p) R * (p + T);

    mp_xm = xform([-cfg.kx/2; 0; 0]); mn_xm = R * [-1; 0; 0];
    mp_xp = xform([ cfg.kx/2; 0; 0]); mn_xp = R * [ 1; 0; 0];
    mp_ym = xform([0; -cfg.ly/2; 0]); mn_ym = R * [0; -1; 0];

    dx = [1;0;0]; ref_px = [-cfg.Kx;0;0]; ref_nx = [1;0;0];
    p_x1 = [-cfg.Kx; cfg.y_x1; -cfg.ax];
    p_x2 = [-cfg.Kx; cfg.y_x2; -cfg.ax];
    p_x3 = [-cfg.Kx; cfg.y_x3; cfg.z_x3];
    opl.x1 = trace_cc_double_pass(p_x1, dx, mp_xm, mn_xm, p_x1, ref_px, ref_nx);
    opl.x2 = trace_cc_double_pass(p_x2, dx, mp_xm, mn_xm, p_x2, ref_px, ref_nx);
    opl.x3 = trace_cc_double_pass(p_x3, dx, mp_xm, mn_xm, p_x3, ref_px, ref_nx);

    dy = [0;1;0]; ref_py = [0;-cfg.Ly;0]; ref_ny = [0;1;0];
    p_y1 = [cfg.x_y1; -cfg.Ly; -cfg.ay];
    p_y2 = [cfg.x_y2; -cfg.Ly; -cfg.ay];
    p_y3 = [cfg.x_y3; -cfg.Ly; cfg.z_y3];
    opl.y1 = trace_cc_double_pass(p_y1, dy, mp_ym, mn_ym, p_y1, ref_py, ref_ny);
    opl.y2 = trace_cc_double_pass(p_y2, dy, mp_ym, mn_ym, p_y2, ref_py, ref_ny);
    opl.y3 = trace_cc_double_pass(p_y3, dy, mp_ym, mn_ym, p_y3, ref_py, ref_ny);

    zmir_p = [0; 0; cfg.z_top]; zmir_n = [0; 0; -1];
    bp1 = xform([-cfg.z_fold_x; cfg.z_y; cfg.z_fold_z]); bn1 = R * ([-1; 0; 1]/sqrt(2));
    bp2 = xform([ cfg.z_fold_x; cfg.z_y; cfg.z_fold_z]); bn2 = R * ([ 1; 0; 1]/sqrt(2));

    ref_z1p = [-cfg.z_head_x; 0; 0]; ref_z1n = [ 1;0;0];
    ref_z2p = [ cfg.z_head_x; 0; 0]; ref_z2n = [-1;0;0];
    opl.z1_f = trace_z_folded([-cfg.z_head_x; cfg.z_y; cfg.z_fold_z], [ 1;0;0], bp1, bn1, zmir_p, zmir_n, ref_z1p, ref_z1n);
    opl.z1_r = trace_single_pass([-cfg.z_head_x; cfg.z_y; cfg.z_ref_z], [ 1;0;0], mp_xm, mn_xm, ref_z1p, ref_z1n);
    opl.z2_f = trace_z_folded([ cfg.z_head_x; cfg.z_y; cfg.z_fold_z], [-1;0;0], bp2, bn2, zmir_p, zmir_n, ref_z2p, ref_z2n);
    opl.z2_r = trace_single_pass([ cfg.z_head_x; cfg.z_y; cfg.z_ref_z], [-1;0;0], mp_xp, mn_xp, ref_z2p, ref_z2n);
end

%% ========================================================================
%  Fig 1 可视化追迹：严格按三维反射定律生成入射（去程）与反射（回程）光路
% =========================================================================
function paths = trace_visual_paths_with_reflection(pose_vis, cfg)
    T = pose_vis(1:3).';
    R = rot_x(pose_vis(4)) * rot_y(pose_vis(5)) * rot_z(pose_vis(6));
    xform = @(p) R * (p + T);

    mp_xm = xform([-cfg.kx/2; 0; 0]); mn_xm = R * [-1; 0; 0];
    mp_xp = xform([ cfg.kx/2; 0; 0]); mn_xp = R * [ 1; 0; 0];
    mp_ym = xform([0; -cfg.ly/2; 0]); mn_ym = R * [0; -1; 0];

    ref_px = [-cfg.Kx; 0; 0]; ref_nx = [1; 0; 0];
    ref_py = [0; -cfg.Ly; 0]; ref_ny = [0; 1; 0];

    x_starts = {[-cfg.Kx; cfg.y_x1; -cfg.ax], [-cfg.Kx; cfg.y_x2; -cfg.ax], [-cfg.Kx; cfg.y_x3; cfg.z_x3]};
    y_starts = {[cfg.x_y1; -cfg.Ly; -cfg.ay], [cfg.x_y2; -cfg.Ly; -cfg.ay], [cfg.x_y3; -cfg.Ly; cfg.z_y3]};
    for i = 1:3
        [~, p1] = intersect_plane(x_starts{i}, [1;0;0], mp_xm, mn_xm);
        d1 = reflect_ray([1;0;0], mn_xm);
        [~, p2] = intersect_plane(p1, d1, ref_px, ref_nx);
        paths.X_in{i}  = [x_starts{i}, p1];
        paths.X_ret{i} = [p1, p2];

        [~, q1] = intersect_plane(y_starts{i}, [0;1;0], mp_ym, mn_ym);
        dq1 = reflect_ray([0;1;0], mn_ym);
        [~, q2] = intersect_plane(q1, dq1, ref_py, ref_ny);
        paths.Y_in{i}  = [y_starts{i}, q1];
        paths.Y_ret{i} = [q1, q2];
    end

    zmir_p = [0; 0; cfg.z_top]; zmir_n = [0; 0; -1];
    sides = [-1, 1];
    for i = 1:2
        s = sides(i);
        p0_f = [s*cfg.z_head_x; cfg.z_y; cfg.z_fold_z];
        p0_r = [s*cfg.z_head_x; cfg.z_y; cfg.z_ref_z];
        d_in = [-s; 0; 0];
        ref_zp = [s*cfg.z_head_x; 0; 0];
        ref_zn = [-s; 0; 0];

        bp = xform([s*cfg.z_fold_x; cfg.z_y; cfg.z_fold_z]);
        bn = R * ([s; 0; 1]/sqrt(2));
        [~, p1] = intersect_plane(p0_f, d_in, bp, bn);
        d1 = reflect_ray(d_in, bn);
        [~, p2] = intersect_plane(p1, d1, zmir_p, zmir_n);
        paths.ZF_in{i} = [p0_f, p1, p2];

        d2 = reflect_ray(d1, zmir_n);
        [~, p3] = intersect_plane(p2, d2, bp, bn);
        d3 = reflect_ray(d2, bn);
        [~, p4] = intersect_plane(p3, d3, ref_zp, ref_zn);
        paths.ZF_ret{i} = [p2, p3, p4];

        if s == -1
            [~, pr1] = intersect_plane(p0_r, d_in, mp_xm, mn_xm);
            dr1 = reflect_ray(d_in, mn_xm);
        else
            [~, pr1] = intersect_plane(p0_r, d_in, mp_xp, mn_xp);
            dr1 = reflect_ray(d_in, mn_xp);
        end
        [~, pr2] = intersect_plane(pr1, dr1, ref_zp, ref_zn);
        paths.ZR_in{i}  = [p0_r, pr1];
        paths.ZR_ret{i} = [pr1, pr2];
    end
end

%% ========================================================================
%  3D 网格构建与底层几何工具
% =========================================================================
function [V, F, C] = build_ws_mesh(cfg)
    sec = [-200, -1.5; 200, -1.5; 200, -126.5; 265, -191.5; -265, -191.5; -200, -126.5];
    y0 = -cfg.ly/2; y1 = cfg.ly/2;
    V_front = [sec(:,1), repmat(y0, 6, 1), sec(:,2)].';
    V_back  = [sec(:,1), repmat(y1, 6, 1), sec(:,2)].';
    V = [V_front, V_back];

    F = [1, 2, 3, 4, 5, 6; 7, 8, 9, 10, 11, 12];
    col_ws    = [0.78, 0.85, 0.90];
    col_bevel = [0.92, 0.69, 0.19];
    C = [col_ws; col_ws];

    for i = 1:6
        j = mod(i, 6) + 1;
        F = [F; i, j, j+6, i+6, i+6, i+6]; %#ok<AGROW>
        if i == 3 || i == 5
            C = [C; col_bevel]; %#ok<AGROW>
        else
            C = [C; col_ws]; %#ok<AGROW>
        end
    end
end

function draw_static_box(ax, x0, x1, y0, y1, z0, z1, col, alph)
    V = [x0,y0,z0; x1,y0,z0; x1,y1,z0; x0,y1,z0; x0,y0,z1; x1,y0,z1; x1,y1,z1; x0,y1,z1];
    F = [1,2,3,4; 5,6,7,8; 1,2,6,5; 3,4,8,7; 1,4,8,5; 2,3,7,6];
    patch(ax, 'Vertices', V, 'Faces', F, 'FaceColor', col, 'EdgeColor', col*0.45, 'FaceAlpha', alph);
end

function draw_static_cylinder(ax, cx, cy, z0, z1, r, col, alph)
    [Xc, Yc, Zc] = cylinder(r, 28);
    surf(ax, Xc + cx, Yc + cy, Zc*(z1 - z0) + z0, 'FaceColor', col, 'EdgeColor', 'none', 'FaceAlpha', alph);
end

function opl = trace_cc_double_pass(p0, d0, mp, mn, apex, ref_p, ref_n)
    [t1, p1] = intersect_plane(p0, d0, mp, mn);
    d1 = reflect_ray(d0, mn);
    [t23, p2] = intersect_plane(2.0*apex - p1, -d1, mp, mn);
    d3 = reflect_ray(-d1, mn);
    [t4, ~] = intersect_plane(p2, d3, ref_p, ref_n);
    opl = t1 + t23 + t4;
end

function opl = trace_single_pass(p0, d0, mp, mn, ref_p, ref_n)
    [t1, p1] = intersect_plane(p0, d0, mp, mn);
    d1 = reflect_ray(d0, mn);
    [t2, ~] = intersect_plane(p1, d1, ref_p, ref_n);
    opl = t1 + t2;
end

function opl = trace_z_folded(p0, d0, bp, bn, zmir_p, zmir_n, ref_p, ref_n)
    [t1, p1] = intersect_plane(p0, d0, bp, bn);
    d1 = reflect_ray(d0, bn);
    [t2, p2] = intersect_plane(p1, d1, zmir_p, zmir_n);
    d2 = reflect_ray(d1, zmir_n);
    [t3, p3] = intersect_plane(p2, d2, bp, bn);
    d3 = reflect_ray(d2, bn);
    [t4, ~] = intersect_plane(p3, d3, ref_p, ref_n);
    opl = t1 + t2 + t3 + t4;
end

function [t, p_hit] = intersect_plane(p0, d, plane_p, plane_n)
    t = dot(plane_p - p0, plane_n) / dot(d, plane_n);
    p_hit = p0 + t * d;
end

function d_out = reflect_ray(d_in, n)
    d_out = d_in - 2.0 * dot(d_in, n) * n;
end

function R = rot_x(a), c=cos(a); s=sin(a); R=[1,0,0; 0,c,-s; 0,s,c]; end
function R = rot_y(a), c=cos(a); s=sin(a); R=[c,0,s; 0,1,0; -s,0,c]; end
function R = rot_z(a), c=cos(a); s=sin(a); R=[c,-s,0; s,c,0; 0,0,1]; end
