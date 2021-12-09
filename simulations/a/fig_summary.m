function fig_summary(opt_struct, sim_output, y_attempt, target_data, y_best);
% Figure to draw example

sp = initialise_publication_quality_figure( ...
        'figure_handle', 10, ...
        'no_of_panels_wide', 1, ...
        'no_of_panels_high', 4, ...
        'right_margin', 1, ...
        'x_to_y_axes_ratio', 5, ...
        'panel_label_font_size', 0);

n = numel(sim_output)
cm = paruly(n);
% 
% m = 1;
% figure(11);
% clf
% for i = 1000:1500
%     y = squeeze(sim_output{m}.cb_pops(i,1,:));
%     plot(y,'b-');
%     text(0,0, sprintf('%i',i));
%     drawnow;
% end
% return

for i = 1 : n
    s = sim_output{i}
   
    subplot(sp(1));
    hold on;
    plot(s.time_s, s.muscle_length, '-', 'Color', cm(i,:));
    ylabel({'Muscle','length', '(nm)'});

    subplot(sp(2));
    hold on;
    plot(s.time_s, s.muscle_force,'-', 'Color', cm(i,:));
    ylabel({'Stress', '(N m^{-2})'});

    subplot(sp(3));
    hold on;
    plot(s.time_s, s.f_activated,'-', 'Color', cm(i,:));
    plot(s.time_s, s.f_bound,':', 'Color', cm(i,:));
    ylabel({'f_activated'});
    
    subplot(sp(4));
    hold on;
    plot(s.time_s, s.M1, 'r-');
    plot(s.time_s, s.M2, 'g-');
    plot(s.time_s, s.M3, 'b-');
    plot(s.time_s, s.M4, 'm-');
    ylabel({'f_activated'});
end


% return
% 
% s = sim_output{1};
% 
% gn = 'cb_distib.gif';
% 
% h = figure(34);
% clf
% fi = 900:1349;
% for i = 1 : 10 : numel(fi)
%     y = squeeze(s.cb_pops(fi(i), 1, :, :));
%     cla
%     hold on;
%     plot(y(1,:), 'r-');
%     plot(y(2,:), 'g-');
%     ylim([0 0.05]);
%     text(0, 0.04, sprintf('%.3f', s.time_s(fi(i))));
%     
%     frame = getframe(h);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im, 256);
%     
%     if (i==1)
%         imwrite(imind, cm, gn, 'gif', 'Loopcount', inf', 'DelayTime', 0.01);
%     else
%         imwrite(imind, cm, gn, 'gif', 'WriteMode', 'append', 'DelayTime', 0.01);
%     end
% end

    
figure(7);
clf
subplot(4,1,1);
hold on;
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r1 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'r-');
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r2 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'b-');
ylim([-1 4]);
xlim([-10, 10]);
subplot(4,1,2);
hold on;
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r3),'r-');
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r4),'b-');
ylim([-1 4]);
xlim([-10, 10]);
subplot(4,1,3);
hold on;
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
    log10(s.myosim_muscle.hs(1).rate_structure.r5),'r-');
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
    log10(s.myosim_muscle.hs(1).rate_structure.r6),'b-');
ylim([-1 4]);
xlim([-10, 10]);
subplot(4,1,4);
hold on;
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
    log10(s.myosim_muscle.hs(1).rate_structure.r7),'r-');
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
    log10(s.myosim_muscle.hs(1).rate_structure.r8),'b-');
ylim([-1 4]);
xlim([-10, 10]);




drawnow;
