function save_all_figures()
    figs = findall(0, 'Type', 'figure');   % find all open figures
    folder = pwd;                           % current folder

    for i = 1:length(figs)
        fig = figs(i);

        % Create filename like: figure_1.png, figure_2.png, ...
        filename = fullfile(folder, sprintf('figure_%d.png', fig.Number));

        % Save as high-resolution PNG
        saveas(fig, filename);
        fprintf('Saved: %s\n', filename);
    end

    fprintf('\nAll figures saved successfully.\n');
end
