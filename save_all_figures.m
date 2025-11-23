function save_all_figures()
    figs = findall(0, 'Type', 'figure');
    folder = fullfile(pwd, 'results');   % always use results/ subfolder

    if ~exist(folder, 'dir')
        mkdir(folder);
    end

    for i = 1:length(figs)
        fig = figs(i);
        filename = fullfile(folder, sprintf('figure_%d.png', fig.Number));
        saveas(fig, filename);
        fprintf('Saved: %s\n', filename);
    end

    fprintf('\nAll figures saved successfully in results/.\n');
end
