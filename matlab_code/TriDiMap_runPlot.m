%% Copyright 2014 MERCIER David
function TriDiMap_runPlot
%% Function to run the mapping
reset(gca);
TriDiMap_getParam;
gui = guidata(gcf);
config = gui.config;

if config.flag_data
    if config.property == 1 || config.property == 4
        if ~config.flagZplot
            data2use = gui.data.expValues_mat.YM;
        else
            data2use = gui.data3D.meanZVal_YM;
        end
    elseif config.property == 2 || config.property == 5
        if ~config.flagZplot
            data2use = gui.data.expValues_mat.H;
        else
            data2use = gui.data3D.meanZVal_H;
        end
    elseif config.property == 3
        data2use_E = gui.data.expValues_mat.YM;
        data2use_H = gui.data.expValues_mat.H;
    end
    if config.property ~= 3
        %% Crop data
        [data2use, config.flagCrop] = TriDiMap_cropping(data2use);
        if length(data2use) == 1
            config.flag_data = 0;
        end
    else
        [data2use_E, config.flagCrop] = TriDiMap_cropping(data2use_E);
        [data2use_H, config.flagCrop] = TriDiMap_cropping(data2use_H);
        if length(data2use_E) == 1 && length(data2use_H) == 1
            config.flag_data = 0;
        end
    end
end

if config.property < 3
    %% Clean data
    if config.flag_data
        if config.noNan
            data2use = TriDiMap_cleaningData(data2use);
        end
        
        %% Normalization of dataset
        if config.normalizationStep && ~config.translationStep
            if config.normalizationStepVal == 1
                data2use = data2use/min(min(data2use));
            elseif config.normalizationStepVal == 2
                data2use = data2use/mean(mean(data2use));
            elseif config.normalizationStepVal == 3
                data2use = data2use/max(max(data2use));
            end
            display('Translation not possible because normalization is active.');
        end
        
        %% Translation step
        if config.translationStep && ~config.normalizationStep
            data2use = data2use + config.translationStepVal;
            data2use((data2use)<0) = 0;
            display('Negative values for the property are replaced by 0.');
            display('Normalization not possible because translation is active.');
        end
        
        %% Interpolating, smoothing and binarizing steps of dataset
        if config.noNan
            [gui.data.expValuesInterp, gui.data.expValuesSmoothed, ...
                gui.data.expValuesInterpSmoothed] = ...
                TriDiMap_interpolation_smoothing(...
                data2use, ...
                config.interpBool, config.interpFact, ...
                config.smoothBool, config.smoothFact);
        else
            gui.data.expValuesInterp = data2use;
            gui.data.expValuesSmoothed = data2use;
            gui.data.expValuesInterpSmoothed = data2use;
        end
        
        %% Grid meshing
        x_step = config.XStep;
        y_step = config.YStep;
        
        if config.N_XStep_default == config.N_YStep_default
            gui.data.xData = 0:x_step:(size(data2use,1)-1)*x_step;
            gui.data.yData = 0:y_step:(size(data2use,2)-1)*y_step;
        elseif config.N_XStep_default ~= config.N_YStep_default
            gui.data.xData = 0:x_step:(size(data2use,1)-1)*x_step;
            gui.data.yData = 0:y_step:(size(data2use,2)-1)*y_step;
        end
        if config.flagZplot
            gui.data.yData = -gui.data.yData;
        end
        
        if config.N_XStep ~= config.N_YStep
            [gui.data.xData_markers, gui.data.yData_markers] = ...
                meshgrid(1:length(gui.data.xData),1:length(gui.data.yData));
            gui.data.xData_markers = (gui.data.xData_markers-1)*x_step;
            gui.data.yData_markers = (gui.data.yData_markers-1)*y_step;
        else
            [gui.data.xData_markers, gui.data.yData_markers] = ...
                meshgrid(gui.data.xData, gui.data.yData);
        end
        
        if config.rawData
            gui.data.xData_interp = gui.data.xData;
            gui.data.yData_interp = gui.data.yData;
            if get(gui.handles.cb_errorMap_GUI, 'Value')
                [xData_interp,  yData_interp] = ...
                    meshgrid(0:x_step:(size(gui.data.expValuesInterpSmoothed,1)-1)*x_step, ...
                    0:y_step:(size(gui.data.expValuesInterpSmoothed,2)-1)*y_step);
                gui.data.xData_interp = xData_interp./(2^(config.interpFact));
                gui.data.yData_interp = yData_interp./(2^(config.interpFact));
            end
        elseif ~config.rawData
            [xData_interp,  yData_interp] = ...
                meshgrid(0:x_step:(size(gui.data.expValuesInterpSmoothed,1)-1)*x_step, ...
                0:y_step:(size(gui.data.expValuesInterpSmoothed,2)-1)*y_step);
            if get(gui.handles.cb_interpMap_GUI, 'Value')
                gui.data.xData_interp = xData_interp./(2^(config.interpFact));
                gui.data.yData_interp = yData_interp./(2^(config.interpFact));
            else
                gui.data.xData_interp = xData_interp;
                gui.data.yData_interp = yData_interp;
            end
        end
    end
    
    %% Legend + Map
    if config.flag_data
        gui.data.data2plot = gui.data.expValuesInterpSmoothed;
        
        minVal = min(min(gui.data.data2plot));
        meanVal = mean(mean(gui.data.data2plot));
        maxVal = max(max(gui.data.data2plot));
        set(gui.handles.value_MinVal_GUI, 'String', num2str(minVal));
        set(gui.handles.value_MeanVal_GUI, 'String', num2str(meanVal));
        set(gui.handles.value_MaxVal_GUI, 'String', num2str(maxVal));
        
        if ~config.normalizationStep
            if config.property == 1
                config.legend = strcat({'Elastic modulus ('},config.strUnit_Property, ')');
                %config.legend = 'Module d''\''elasticit\''e (GPa)';
            elseif config.property == 2
                config.legend = strcat({'Hardness ('},config.strUnit_Property, ')');
                %config.legend = 'Duret\''e (GPa)';
            end
            
        elseif config.normalizationStep > 0
            if config.normalizationStepVal == 1
                if config.property == 1
                    config.legend = 'Normalized elastic modulus by minimum elastic modulus value';
                elseif config.property == 2
                    config.legend = 'Normalized hardness by minimum hardness value';
                end
            elseif config.normalizationStepVal == 2
                if config.property == 1
                    config.legend = 'Normalized elastic modulus by mean elastic modulus value';
                elseif config.property == 2
                    config.legend = 'Normalized hardness by mean hardness value';
                end
            elseif config.normalizationStepVal == 3
                if config.property == 1
                    config.legend = 'Normalized elastic modulus by maximum elastic modulus value';
                elseif config.property == 2
                    config.legend = 'Normalized hardness by maximum hardness value';
                end
            end
        end
        gui.config = config;
        guidata(gcf, gui);
        if get(gui.handles.cb_errorMap_GUI, 'Value')
            TriDiMap_error_plotting;
        else
            TriDiMap_mapping_plotting;
        end
        TriDiMap_option_plotting;
        gui = guidata(gcf);
    else
        errordlg(['First set indentation grid parameters and load an Excel file '...
            'to plot a property map !']);
    end
elseif config.property == 3
    if gui.config.logZ
        loglog(data2use_H, data2use_E, 'k+', 'Linewidth', 1.5);
    else
        plot(data2use_H, data2use_E, 'k+', 'Linewidth', 1.5);
    end
    hXLabel = xlabel(strcat({'Hardness ('},gui.config.strUnit_Property, ')'));
    hYLabel = ylabel(strcat({'Elastic modulus ('},gui.config.strUnit_Property, ')'));
    set([hXLabel, hYLabel], ...
        'Color', [0,0,0], 'FontSize', gui.config.FontSizeVal, ...
        'Interpreter', 'Latex');
    
    if gui.config.grid
        grid on;
    else
        grid off;
    end
    
elseif config.property == 4 || config.property == 5
    % Histograms plot
    numberVal = size(data2use,1)*size(data2use,2);
    data2useHist = reshape(data2use, [1,numberVal]);
    binsize = gui.config.binSize;
    minbin = round(min(data2useHist));
    maxbin = round(max(data2useHist));
    CatBin = minbin:binsize:maxbin;
    Hist_i = histc(data2useHist,CatBin);
    Prop_pdf = Hist_i/numberVal;
    Prop_pdf = Prop_pdf/binsize;
    SumProp_pdf = sum(Prop_pdf);
    SumTot = SumProp_pdf .* binsize;
    bar(CatBin,Prop_pdf,'FaceColor',[0.5 0.5 0.5],'EdgeColor','none', ...
        'LineWidth', 1.5);
    set(gcf, 'renderer', 'opengl');
    xlim([0 maxbin]);
end

coordSyst(gui.handles.MainWindow);
gui = guidata(gcf);
guidata(gcf, gui);
end