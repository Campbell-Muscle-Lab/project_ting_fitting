function fig_summary(opt_struct, sim_output, y_attempt, target_data, y_best);
% Figure to draw example

sp = initialise_publication_quality_figure( ...
        'figure_handle', 10, ...
        'no_of_panels_wide', 1, ...
        'no_of_panels_high', 4, ...
        'right_margin', 4.5, ...
        'x_to_y_axes_ratio', 1.5, ...
        'axes_padding_top', 0.2, ...
        'axes_padding_bottom', 0.2, ...
        'axes_padding_right', 0.75, ...
        'panel_label_font_size', 0);

n = numel(sim_output);
cm = jet(n);
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

for i = 1 : 1
    s = sim_output{i};
%     mm = s.myosim_muscle.hs(1).rate_structure;
   
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
    ns = 3;
    cm = jet(ns);
    for i = 1 : ns
        fn{i} = sprintf('M%i',i);
        h(i) = plot(s.time_s, s.(fn{i}), '-');
    end
    ylabel({'M_states'});
end
legendflex(h, fn, 'anchor',{'e','w'}, 'xscale',0.3, 'buffer', [10 0]);


%return

s = sim_output{1};

gn = 'cb_distib.gif';

h = figure(34);
clf
fi = 900:2116;
for i = 1 : 10 : numel(fi)
    xx = linspace(-10,10,21);
    y = squeeze(s.cb_pops(fi(i), 1, :, :));
    cla
    hold on;
%     plot(y(1,:), 'r-');
%     plot(y(2,:), 'g-');
    plot(xx,y, 'g-');
    ylim([0 0.05]);
    text(0, 0.04, sprintf('%.3f', s.time_s(fi(i))));
    
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im, 256);
    
    if (i==1)
        imwrite(imind, cm, gn, 'gif', 'Loopcount', inf', 'DelayTime', 0.01);
    else
        imwrite(imind, cm, gn, 'gif', 'WriteMode', 'append', 'DelayTime', 0.01);
    end
end


s = sim_output{1};

    
figure(7);
clf
r=4;
subplot(r,1,1);
hold on;
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r1 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'r-');
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r1_0 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'r:');
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r2 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'b-');
ylim([-1 4]);
xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
ylabel('r1/2');

subplot(r,1,2);
hold on;
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r3),'r-');
plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r4),'b-');
ylim([-1 4]);
xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
ylabel('r3/4');

if isfield(s.myosim_muscle.hs(1).rate_structure, 'r5')
    subplot(r,1,3);
    hold on;
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r5),'r-');
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r6),'b-');
    ylim([-1 4]);
    xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
    ylabel('r5/6');
end
    
if isfield(s.myosim_muscle.hs(1).rate_structure, 'r7')
    subplot(r,1,4);
    hold on;
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r7 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'r-');
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r8 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'b-');
    ylim([-1 4]);
    xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
    ylabel('r7/8');
end

if isfield(s.myosim_muscle.hs(1).rate_structure, 'r9')
    subplot(r,1,5);
    hold on;
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r9),'r-');
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r10),'b-');
    ylim([-1 4]);
    xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
    ylabel('r9/10');
end

if isfield(s.myosim_muscle.hs(1).rate_structure, 'r11')
    subplot(r,1,6);
    hold on;
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r11 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'r-');
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r12 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'b-');
    ylim([-1 4]);
    xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
    ylabel('r11/12');
end

if isfield(s.myosim_muscle.hs(1).rate_structure, 'r13')
    subplot(r,1,7);
    hold on;
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r13),'r-');
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r14),'b-');
    ylim([-1 4]);
    xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
    ylabel('r13/14');
end

if isfield(s.myosim_muscle.hs(1).rate_structure, 'r15')
    subplot(r,1,8);
    hold on;
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r15 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'r-');
    plot(s.myosim_muscle.hs(1).myofilaments.x, ...
        log10(s.myosim_muscle.hs(1).rate_structure.r16 * ...
            ones(numel(s.myosim_muscle.hs(1).myofilaments.x),1)),'b-');
    ylim([-1 4]);
    xlim(max(s.myosim_muscle.hs(1).myofilaments.x)*[-1 1]);
    ylabel('r15/16');
end

