%% Copyright 2014 MERCIER David
function TriDiMap_mapping_plotting
%% Function to plot a 3D map of material properties in function of X/Y coordinates
gui = guidata(gcf);

FontSizeVal = gui.config.FontSizeVal;
xData_interp = gui.data.xData_interp;
yData_interp = gui.data.yData_interp;
data2plot = gui.data.data2plot;
cMap = gui.config.colorMap;

if strcmp(get(gui.handles.binarization_GUI, 'String'), 'BINARIZATION')
    zString = gui.config.legend;
    cmin = gui.config.cmin;
    cmax = gui.config.cmax;
    intervalScaleBar = gui.config.intervalScaleBar;
    rawData = gui.config.rawData;
    contourPlot = gui.config.contourPlot;
    logZ = gui.config.logZ;
    
    %% 1 map (with or without markers)
    if gui.config.cminOld < 0
        gui.config.cminOld = 0;
    end
    if logZ
        if cmin < 1
            cmin = 1;
            set(gui.handles.value_colorMin_GUI, 'String', num2str(cmin));
        end
        if gui.config.cminOld == 0
            gui.config.cminOld = 1;
        end
    end
    
    if ~rawData
        if logZ
            hFig = imagesc(real(log(data2plot')),...
                'XData',xData_interp,'YData',yData_interp);
        else
            hFig = imagesc((data2plot'),...
                'XData',xData_interp,'YData',yData_interp);
            %             zVal = zeros(length(xData_interp));
            %             hFig = scatter3(xData_interp, yData_interp, zVal);
        end
        set(gca,'YDir','normal');
        set(hFig,'alphadata',~isnan(data2plot'));
        %view(2);
    else
        if ~contourPlot
            hFig = surf(xData_interp, yData_interp, data2plot',...
                'FaceColor','interp',...
                'EdgeColor','none',...
                'FaceLighting','gouraud');
            if gui.config.shadingData == 1
                shading flat;
            elseif gui.config.shadingData == 2
                shading interp;
            elseif gui.config.shadingData == 3
                shading faceted;
            end
            %view(3);
        else
            if logZ
                contourf(xData_interp, yData_interp, log(data2plot'),...
                    intervalScaleBar);
            else
                contourf(xData_interp, yData_interp, data2plot',...
                    intervalScaleBar);
            end
        end
    end
    
    hold on;
    
    axis equal;
    axis tight;
    if length(xData_interp) > 5*length(yData_interp) || length(yData_interp) > 5*length(xData_interp)
        axis normal;
    end
    if ~rawData
        view(2); % or view(0,90);
    end
    %zlim([0 2]);
    zlim auto;
    daspect([1 1 gui.config.zAxisRatioVal]);
    if logZ && ~contourPlot
        set(gca, 'zsc', 'log');
        %set(hFig, 'cdata', real(log10(get(hFig, 'cdata'))));
    end
    if logZ && ~rawData
        set(gca, 'zsc', 'linear');
    end
    hold on;
    
    if strcmp(gui.config.strUnit_Length, '�m')
        gui.config.strUnit_Length_Latex = '$\mu$m';
        hXLabel = xlabel(strcat({'X coordinates ('},gui.config.strUnit_Length_Latex, ')'));
        if ~gui.config.flagZplot
            hYLabel = ylabel(strcat({'Y coordinates ('},gui.config.strUnit_Length_Latex, ')'));
        else
            hYLabel = ylabel(strcat({'Z coordinates ('},gui.config.strUnit_Length_Latex, ')'));
        end
    else
        hXLabel = xlabel(strcat({'X coordinates ('},gui.config.strUnit_Length, ')'));
        if ~gui.config.flagZplot
            hYLabel = ylabel(strcat({'Y coordinates ('},gui.config.strUnit_Length, ')'));
        else
            hYLabel = ylabel(strcat({'Z coordinates ('},gui.config.strUnit_Length, ')'));
        end
    end
    hZLabel = zlabel(zString);
    hTitle(1) = title(strcat({'Mapping of '}, zString));
    set([hXLabel, hYLabel, hZLabel, hTitle(1)], ...
        'Color', [0,0,0], 'FontSize', FontSizeVal, ...
        'Interpreter', 'Latex');
    
    % Set number of intervals to 0 for a continuous scalebar.
    if intervalScaleBar > 0
        if rawData
            if ~contourPlot
                cmap = [cMap, '(',num2str(intervalScaleBar),')'];
            else
                if logZ
                    cmap = cMap;
                else
                    cmap = [cMap, '(',num2str(intervalScaleBar),')'];
                end
            end
        else
            if logZ
                cmap = cMap;
            else
                cmap = [cMap, '(',num2str(intervalScaleBar),')'];
            end
        end
        cmap_Flip = colormap(cmap);
        if ~gui.config.flipColor
            colormap(cmap_Flip);
        else
            colormap(flipud(cmap_Flip));
        end
    elseif intervalScaleBar == 0
        cmap_Flip = colormap([cMap, '(',num2str(10000),')']);
        if ~gui.config.flipColor
            colormap(cmap_Flip);
        else
            colormap(flipud(cmap_Flip));
        end
    end
    if ~gui.config.scaleAxis
        if cmin == round(min(data2plot(:)))
            cmin = gui.config.cminOld;
            set(gui.handles.value_colorMin_GUI, 'String', num2str(cmin));
        end
        if cmax == round(max(data2plot(:)))
            cmax = gui.config.cmaxOld;
            set(gui.handles.value_colorMax_GUI, 'String', num2str(cmax));
        end
        if cmin >= cmax
            cmax = cmin*1.2;
            warning('Minimum property value has to be lower than the maximum property value !');
            gui.config.cmax = cmax;
            set(gui.handles.value_colorMax_GUI, 'String', num2str(cmax));
        end
        if logZ && contourPlot
            caxis(log([cmin, cmax]));
        elseif logZ && ~rawData
            caxis(log([cmin, cmax]));
        else
            caxis([cmin, cmax]);
        end
    else
        if cmin ~= round(min(data2plot(:)))
            gui.config.cminOld = str2num(get(gui.handles.value_colorMin_GUI, 'String'));
        end
        if cmax ~= round(max(data2plot(:)))
            gui.config.cmaxOld = str2num(get(gui.handles.value_colorMax_GUI, 'String'));
        end
        set(gui.handles.value_colorMin_GUI, 'String', num2str(round(min(data2plot(:)))));
        set(gui.handles.value_colorMax_GUI, 'String', num2str(round(max(data2plot(:)))));
        gui.config.cmin = num2str(round(min(data2plot(:))));
        gui.config.cmax = num2str(round(max(data2plot(:))));
    end
    
    Contours = cmin:(cmax-cmin)/intervalScaleBar:cmax;
    if logZ && contourPlot
        hcb1 = colorbar('YTick',log(Contours),'YTickLabel',Contours);
    elseif logZ && ~rawData
        hcb1 = colorbar('YTick',log(Contours),'YTickLabel',Contours);
    else
        hcb1 = colorbar;
    end
    
    %if logScale
    %hcb1 = colorbar('Yscale','log');
    %end
    ylabel(hcb1, zString, 'Interpreter', 'Latex', 'FontSize', FontSizeVal);
    
    gui.handle.hcb1 = hcb1;
    set(gca, 'Fontsize', FontSizeVal);
    hold off;
    
else
    cMap = gui.config.colorMap;
    
    hFig = imagesc((data2plot'),...
        'XData',xData_interp,'YData',yData_interp);
    set(gca,'YDir','normal');
    set(hFig,'alphadata',~isnan(data2plot'));
    axisMap(cMap, ['Binarized ', gui.legend, ' ', 'map'], ...
        gui.config.FontSizeVal, ...
        (gui.config.N_XStep_default-1)*gui.config.XStep_default, ...
        (gui.config.N_YStep_default-1)*gui.config.YStep_default, ...
        gui.config.flipColor, gui.config.strUnit_Length);
    axis equal;
    axis tight;
end

guidata(gcf, gui);

end