
%
function prettify_axis_limits(XLimits, YLimits, CLimits, LegendReplace, LegendLocation, ...
    all_axes, currFig, ax_pos, xlims_subplot, ylims_subplot, clims_subplot)
% make x and y lims the same
if ismember(XLimits, {'all', 'row', 'col'}) || ismember(YLimits, {'all', 'row', 'col'}) || ismember(CLimits, {'all', 'row', 'col'})
    % get rows and cols
    col_subplots = unique(ax_pos(:, 1));
    row_subplots = unique(ax_pos(:, 2));

    col_xlims = arrayfun(@(x) [min(min(xlims_subplot(ax_pos(:, 1) == col_subplots(x), :))), ...
        max(max(xlims_subplot(ax_pos(:, 1) == col_subplots(x), :)))], 1:size(col_subplots, 1), 'UniformOutput', false);
    row_xlims = arrayfun(@(x) [min(min(xlims_subplot(ax_pos(:, 2) == row_subplots(x), :))), ...
        max(max(xlims_subplot(ax_pos(:, 2) == row_subplots(x), :)))], 1:size(row_subplots, 1), 'UniformOutput', false);
    col_ylims = arrayfun(@(x) [min(min(ylims_subplot(ax_pos(:, 1) == col_subplots(x), :))), ...
        max(max(ylims_subplot(ax_pos(:, 1) == col_subplots(x), :)))], 1:size(col_subplots, 1), 'UniformOutput', false);
    row_ylims = arrayfun(@(x) [min(min(ylims_subplot(ax_pos(:, 2) == row_subplots(x), :))), ...
        max(max(ylims_subplot(ax_pos(:, 2) == row_subplots(x), :)))], 1:size(row_subplots, 1), 'UniformOutput', false);
    col_clims = arrayfun(@(x) [min(min(clims_subplot(ax_pos(:, 1) == col_subplots(x), :))), ...
        max(max(clims_subplot(ax_pos(:, 1) == col_subplots(x), :)))], 1:size(col_subplots, 1), 'UniformOutput', false);
    row_clims = arrayfun(@(x) [min(min(clims_subplot(ax_pos(:, 2) == row_subplots(x), :))), ...
        max(max(clims_subplot(ax_pos(:, 2) == row_subplots(x), :)))], 1:size(row_subplots, 1), 'UniformOutput', false);
  

    for iAx = 1:size(all_axes, 2)
        thisAx = all_axes(iAx);
        currAx = currFig.Children(thisAx);
        if ~isempty(currAx)
            if ismember(XLimits, {'all'})
                set(currAx, 'Xlim', [min(min(xlims_subplot)), max(max(xlims_subplot))]);
            end
            if ismember(YLimits, {'all'})
                set(currAx, 'Ylim', [min(min(ylims_subplot)), max(max(ylims_subplot))]);
            end
            if ismember(CLimits, {'all'})
                set(currAx, 'Clim', [min(min(clims_subplot)), max(max(clims_subplot))]);
            end
            if ismember(XLimits, {'row'})
                set(currAx, 'Xlim', row_xlims{ax_pos(iAx, 2) == row_subplots});
            end
            if ismember(YLimits, {'row'})
                set(currAx, 'Ylim', row_ylims{ax_pos(iAx, 2) == row_subplots});
            end
            if ismember(CLimits, {'row'})
                set(currAx, 'Clim', row_clims{ax_pos(iAx, 2) == row_subplots});
            end
            if ismember(XLimits, {'col'})
                set(currAx, 'Xlim', col_xlims{ax_pos(iAx, 1) == col_subplots});
            end
            if ismember(YLimits, {'col'})
                set(currAx, 'Ylim', col_ylims{ax_pos(iAx, 1) == col_subplots});
            end
            if ismember(CLimits, {'col'})
                set(currAx, 'Clim', col_clims{ax_pos(iAx, 1) == col_subplots});
            end
        end
        if ~isempty(currAx.Legend)
            if LegendReplace
                prettify_legend(currAx)
            else
                set(currAx.Legend, 'Location', LegendLocation)
            end
        end
    end
end
end
