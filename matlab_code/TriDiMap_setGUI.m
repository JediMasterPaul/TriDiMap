%% Copyright 2014 MERCIER David
function handles = TriDiMap_setGUI
%% Definition of the GUI and buttons
g = guidata(gcf);
handles = g.handles;

%% Title of the GUI
handles.title_GUI_1 = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.31 0.96 0.6 0.04],...
    'String', 'Mapping of mechanical properties from (nano)indentation experiments.',...
    'FontWeight', 'bold',...
    'FontSize', 12,...
    'HorizontalAlignment', 'center',...
    'ForegroundColor', 'red');

handles.title_GUI_2 = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.31 0.93 0.6 0.03],...
    'String', strcat('Version_', ...
    g.config.version_toolbox, ' - Copyright 2014 MERCIER David'),...
    'FontSize', 10);

set([handles.title_GUI_1, handles.title_GUI_2], ...
    'FontWeight', 'bold',...
    'HorizontalAlignment', 'center',...
    'ForegroundColor', 'red')

%% Date / Time
handles.date_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'String', datestr(datenum(clock),'mmm.dd,yyyy HH:MM'),...
    'Position', [0.92 0.975 0.075 0.02]);

%% Buttons to set type of files
handles.pm_set_file = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.02 0.95 0.08 0.04],...
    'String', {'Agilent MTS';'Hysitron';'ASMEC'},...
    'Value', 1,...
    'Callback', '');

%% Units
% Unit definition for the X and Y size
handles.title_unitLength_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.925 0.04 0.02],...
    'String', 'Length:',...
    'HorizontalAlignment', 'left');

handles.unitLength_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.06 0.925 0.05 0.02],...
    'String', listUnitLength,...
    'Value', 2,...
    'Callback', 'TriDiMap_runPlot');

% Unit definition for the property
handles.title_unitProp_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.12 0.925 0.04 0.02],...
    'String', 'Property:',...
    'HorizontalAlignment', 'left');

handles.unitProp_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.16 0.925 0.05 0.02],...
    'String', listUnitProperty,...
    'Value', 2,...
    'Callback', 'TriDiMap_runPlot');

%% Definition of the grid parameters
handles.title_numXindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.89 0.11 0.02],...
    'String', 'Number of indents along X axis:',...
    'HorizontalAlignment', 'left');

handles.value_numXindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.135 0.89 0.03 0.02],...
    'String', '25',...
    'Callback', 'TriDiMap_runPlot');

handles.title_numYindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.87 0.11 0.02],...
    'String', 'Number of indents along Y axis:',...
    'HorizontalAlignment', 'left');

handles.value_numYindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.135 0.87 0.03 0.02],...
    'String', '25',...
    'Callback', 'TriDiMap_runPlot');

handles.title_deltaXindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.85 0.14 0.02],...
    'String', 'Distance between indents along X axis:',...
    'HorizontalAlignment', 'left');

handles.value_deltaXindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.165 0.85 0.03 0.02],...
    'String', '2',...
    'Callback', 'TriDiMap_runPlot');

handles.unit_deltaXindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.195 0.85 0.03 0.02],...
    'String', '�m',...
    'HorizontalAlignment', 'center');

handles.title_deltaYindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.83 0.14 0.02],...
    'String', 'Distance between indents along Y axis:',...
    'HorizontalAlignment', 'left');

handles.value_deltaYindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.165 0.83 0.03 0.02],...
    'String', '2',...
    'Callback', 'TriDiMap_runPlot');

handles.unit_deltaYindents_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.195 0.83 0.03 0.02],...
    'String', '�m',...
    'HorizontalAlignment', 'center');

%% Buttons to browse file
handles.opendata_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.02 0.75 0.05 0.06],...
    'String', 'Select file',...
    'FontSize', 10,...
    'FontWeight','bold',...
    'BackgroundColor', [0.745 0.745 0.745],...
    'Callback', 'TriDiMap_loadingData');

handles.opendata_str_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.075 0.75 0.122 0.06],...
    'String', g.config.data.data_path,...
    'FontSize', 8,...
    'BackgroundColor', [0.9 0.9 0.9],...
    'HorizontalAlignment', 'left');

%% Definition of the property
handles.title_property_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.71 0.04 0.02],...
    'String', 'Property:',...
    'HorizontalAlignment', 'left');

handles.property_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.06 0.71 0.05 0.02],...
    'String', {'Elastic modulus';'Hardness'},...
    'Value', 2,...
    'Callback', 'TriDiMap_runPlot');

%% Pixelized data
handles.cb_pixData_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.67 0.18 0.02],...
    'String', 'Pixelized data',...
    'Value', 1,...
    'Callback', 'TriDiMap_runPlot');

%% Remove NaN pixels (blank pixels)
handles.cb_pixNaN_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.64 0.18 0.02],...
    'String', 'Remove NaN pixels',...
    'Value', 1,...
    'Callback', 'TriDiMap_runPlot');

%% Interpolation
minValI = 1;
maxValI = 4;
handles.cb_interpMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.61 0.18 0.02],...
    'String', 'Interpolation of the map',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.slider_interpMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'slider',...
    'Min',minValI,'Max',maxValI,'Value',2,...
    'SliderStep', [1/maxValI, 10/maxValI], ...
    'Position', [0.02 0.58 0.18 0.02],...
    'Callback', 'TriDiMap_runPlot');

%% Smoothing
minValS = 1;
maxValS = 3;
handles.cb_smoothMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.55 0.18 0.02],...
    'String', 'Smoothing of the map',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.slider_smoothMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'slider',...
    'Min',minValS,'Max',maxValS,'Value',(minValS+maxValS)/2,...
    'SliderStep', [1/maxValS, 10/maxValS], ...
    'Position', [0.02 0.52 0.18 0.02],...
    'Callback', 'TriDiMap_runPlot');

handles.cb_errorMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.49 0.18 0.02],...
    'String', 'Plot of the error map',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

%% Contour Plot
handles.cb_contourPlotMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.46 0.18 0.02],...
    'String', 'Contour plot of the map',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

%% Colorbar options
handles.title_colormap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.41 0.04 0.02],...
    'String', 'Colormap:',...
    'HorizontalAlignment', 'left');

handles.colormap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.06 0.41 0.05 0.02],...
    'String', listColormap,...
    'Value', 1,...
    'Callback', 'TriDiMap_runPlot');

handles.cb_flipColormap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.115 0.41 0.085 0.02],...
    'String', 'Flip colormap',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.cb_autoColorbar_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.38 0.085 0.02],...
    'String', 'Auto colorbar',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.title_colorMin_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.35 0.09 0.02],...
    'String', 'Minimum property value:',...
    'HorizontalAlignment', 'left');

handles.value_colorMin_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.115 0.35 0.03 0.02],...
    'String', num2str(g.config.cminOld),...
    'Callback', 'TriDiMap_runPlot');

handles.unit_colorMin_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.145 0.35 0.03 0.02],...
    'String', 'GPa',...
    'HorizontalAlignment', 'center');

handles.title_colorMax_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.33 0.09 0.02],...
    'String', 'Maximum property value:',...
    'HorizontalAlignment', 'left');

handles.value_colorMax_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.115 0.33 0.03 0.02],...
    'String', num2str(g.config.cmaxOld),...
    'Callback', 'TriDiMap_runPlot');

handles.unit_colorMax_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.145 0.33 0.03 0.02],...
    'String', 'GPa',...
    'HorizontalAlignment', 'center');

handles.title_colorNum_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.30 0.09 0.02],...
    'String', 'Number of intervals:',...
    'HorizontalAlignment', 'left');

handles.value_colorNum_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.115 0.30 0.03 0.02],...
    'String', '10',...
    'Callback', 'TriDiMap_runPlot');

%% Normalization of the colorbar
handles.cb_normMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.27 0.11 0.02],...
    'String', 'Normalization of the colorbar',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.pm_normMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.13 0.27 0.05 0.02],...
    'String', listVal,...
    'Value', 2,...
    'Callback', 'TriDiMap_runPlot');

%% Translation of the colorbar
handles.cb_transMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.24 0.11 0.02],...
    'String', 'Translation of the colorbar',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.value_transMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.13 0.24 0.03 0.02],...
    'String', '10',...
    'Callback', 'TriDiMap_runPlot');

handles.unit_transMap_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.16 0.24 0.03 0.02],...
    'String', 'GPa',...
    'HorizontalAlignment', 'center');

%% Options of the plot
handles.cb_log_plot_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.21 0.04 0.02],...
    'String', 'Log',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.cb_grid_plot_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.06 0.21 0.04 0.02],...
    'String', 'Grid',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.cb_markers_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.10 0.21 0.05 0.02],...
    'String', 'Markers',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.cb_MinMax_plot_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.15 0.21 0.05 0.02],...
    'String', 'Min/Max',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

handles.cb_tickColorBar_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.18 0.05 0.02],...
    'String', 'Ticks',...
    'Value', 0,...
    'Callback', 'TriDiMap_runPlot');

%% Location of the legend
% handles.title_legend_location = uicontrol('Parent', gcf,...
%     'Units', 'normalized',...
%     'Style', 'text',...
%     'Position', [0.02 0.22 0.04 0.02],...
%     'String', 'Legend location:',...
%     'HorizontalAlignment', 'left');
% 
% handles.legend_GUI = uicontrol('Parent', gcf,...
%     'Units', 'normalized',...
%     'Style', 'popupmenu',...
%     'Position', [0.06 0.22 0.05 0.02],...
%     'String', listLocationLegend,...
%     'Value', 2,...
%     'Callback', 'TriDiMap_runPlot');

%% Get values from plot
handles.pb_get_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.02 0.14 0.1 0.03],...
    'String', 'Get x and y values',...
    'Callback', 'plot_get_values');

handles.title_x_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.12 0.03 0.02],...
    'String', 'X value:',...
    'HorizontalAlignment', 'left');

handles.value_x_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.05 0.12 0.03 0.02],...
    'String', '');

handles.unit_x_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.08 0.12 0.03 0.02],...
    'String', '',...
    'HorizontalAlignment', 'left');

handles.title_y_values_prop_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.10 0.03 0.02],...
    'String', 'Y value:',...
    'HorizontalAlignment', 'left');

handles.value_y_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.05 0.10 0.03 0.02],...
    'String', '');

handles.unit_y_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.08 0.10 0.03 0.02],...
    'String', '',...
    'HorizontalAlignment', 'left');

handles.title_z_values_prop_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.12 0.11 0.03 0.02],...
    'String', 'Property:',...
    'HorizontalAlignment', 'left');

handles.value_z_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.15 0.11 0.03 0.02],...
    'String', '');

handles.unit_z_values_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.18 0.11 0.03 0.02],...
    'String', '',...
    'HorizontalAlignment', 'left');

%% Plot configuration
handles.AxisPlot_GUI = axes('Parent', gcf,...
    'Position', [0.33 0.10 0.60 0.75]);

set(gcf,'CurrentAxes', handles.AxisPlot_GUI);

%% Others buttons
% Save
handles.save_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.02 0.03 0.12 0.06],...
    'String', 'SAVE',...
    'Callback', 'save_figure', ...
    'FontSize', 12,...
    'BackgroundColor', [0.745 0.745 0.745]);

%% Coordinates system
xVal = 0.93;
yVal = 0.89;
arrowLength = 0.03;

xX = [xVal, xVal + arrowLength];
yX = [yVal, yVal];
handles.arrowX = annotation('textarrow',xX,yX);
handles.textX = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [xVal+arrowLength yVal-0.01 0.02 0.02],...
    'String', 'X');

xY = [xVal, xVal];
yY = [yVal, yVal + 2*arrowLength];
handles.arrowY = annotation('textarrow',xY,yY);
handles.textY = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [xVal-0.01 yVal+2*arrowLength 0.02 0.02],...
    'String', 'Y');

%% Guidata
g.handles = handles;
guidata(gcf, g);

%% Update units
TriDiMap_updateUnit;

end