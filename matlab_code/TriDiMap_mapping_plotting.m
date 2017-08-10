%% Copyright 2014 MERCIER David
function TriDiMap_mapping_plotting(xData_interp, yData_interp, ...
    expValuesInterpSmoothed, expProp, normStep, cmin, cmax, ...
    scaleAxis, FontSizeVal, Markers, xData_markers, yData_markers, ...
    expValues, expValuesInterp, intervalScaleBar, rawData, contourPlot, ...
    legendStr, fracCalc, logZ, minorTicks, pathStr, nameFile, savePlot, varargin)
%% Function to plot a 3D map of material properties in function of X/Y coordinates
% 1) et 2) xData_interp and yData_interp: Interpolated x and y values
% 3) expValuesInterpSmoothed: Interpolated and smoothed z values
% 4) expProp: 1 = Elastic (Young's modulus) or 2 = Plastic (hardness) properties
% 5) normStep: Variable to set step of normalization
% 6) et 7) cmin and cmax: Limits of colorbar
% 8) scaleAxis: Boolean to set colorbar
% 9) FontSizeVal: Size of the font (legend, axes labels...)
% 10) Markers: Boolean to plot markers
% 11) et 12) xData_markers and yData_markers: Coordinates of markers
% 13) expValues: Raw dataset
% 14) expValuesInterp: Interpolated dataset
% 15) intervalScaleBar: Number of interval on the scale bar
% 16) rawData: Boolean to plot raw dataset (no interpolation, no smoothing...)
% 17) contourPlot: Boolean to plot contour
% 18) legendStr: Strings for legend
% 19) fracCalc: Boolean to plot raw dataset in black and white and to calculate phase fraction
% 20) logZ: Boolean to set Z axis in a log scale
% 21) minorTicks: Boolean to set Z axis in a log scale
% 22) pathStr: File path
% 23) nameFile: File name
% 24) savePlot: Flag to save or not plot

if nargin < 21
    minorTicks = 0;
end

if nargin < 20
    logZ = 0;
end

if nargin < 19
    fracCalc = 0;
end

if nargin < 18
    legendStr = {'Phase1' , 'Phase2'};
end

if nargin < 17
    contourPlot = 0;
end

if nargin < 16
    rawData = 0;
end

if nargin < 15
    intervalScaleBar = 10;
end

if nargin < 13
    %expValues = randi(101,101);
    expValues = peaks(51);
end

if nargin < 12
    yData_markers = 1;
end

if nargin < 11
    xData_markers = 1;
end

if nargin < 10
    Markers = 1;
end

if nargin < 9
    FontSizeVal = 14;
end

if nargin < 8
    scaleAxis = 0;
end

if nargin < 7
    cmax = 0;
end

if nargin < 6
    cmin = 200;
end

if nargin < 5
    normStep = 0;
end

if nargin < 4
    expProp = 1;
end

if nargin < 3
    %expValuesInterpSmoothed =
end

if nargin < 2
    %yData_interp =
end

if nargin < 1
    %xData_interp =
end

%% Initialization of variables
maxPlots = 5;
h(1:maxPlots) = NaN;
hXLabel(1:maxPlots) = NaN;
hYLabel(1:maxPlots) = NaN;
hZLabel(1:maxPlots) = NaN;
hTitle(1:maxPlots) = NaN;

%% Figure properties
scrsize = get(0, 'ScreenSize'); % Get screen size
WX = 0.15 * scrsize(3); % X Position (bottom)
WY = 0.10 * scrsize(4); % Y Position (left)
WW = 0.70 * scrsize(3); % Width
WH = 0.80 * scrsize(4); % Height

if ~normStep
    if expProp == 1
        zString = 'Elastic modulus (GPa)';
        %zString = 'Module d''\''elasticit\''e (GPa)';
        plotName = 'E';
    elseif expProp == 2
        zString = 'Hardness (GPa)';
        %zString = 'Duret\''e (GPa)';
        plotName = 'H';
    end
elseif normStep > 0
    if normStep == 1
        if expProp == 1
            zString = 'Normalized elastic modulus by minimum elastic modulus value';
        elseif expProp == 2
            zString = 'Normalized hardness by minimum hardness value';
        end
    elseif normStep == 2
        if expProp == 1
            zString = 'Normalized elastic modulus by maximum elastic modulus value';
        elseif expProp == 2
            zString = 'Normalized hardness by maximum hardness value';
        end
    elseif normStep == 3
        if expProp == 1
            zString = 'Normalized elastic modulus by mean elastic modulus value';
        elseif expProp == 2
            zString = 'Normalized hardness by mean hardness value';
        end
    end
    
end

%% 1 map (with or without markers)
f(1) = figure('position', [WX, WY, WW, WH]);
colormap hsv;
Contours = cmin:(cmax-cmin)/intervalScaleBar:cmax;

if ~rawData
    if ~contourPlot
        h(1) = surf(xData_interp, yData_interp, expValuesInterpSmoothed',...
            'FaceColor','interp',...
            'EdgeColor','none',...
            'FaceLighting','gouraud');
        % 'Marker', '+'
        shading interp;
    else
        if logZ
            contourf(xData_interp, yData_interp, log(expValuesInterpSmoothed'),...
                intervalScaleBar);
        else
            contourf(xData_interp, yData_interp, expValuesInterpSmoothed',...
                intervalScaleBar);
        end
    end
else
    if logZ
        h(1) = imagesc(real(log(expValuesInterpSmoothed')),...
            'XData',xData_interp,'YData',yData_interp);
    else
        h(1) = imagesc((expValuesInterpSmoothed'),...
            'XData',xData_interp,'YData',yData_interp);
    end
    set(gca,'YDir','normal');
    set(h(1),'alphadata',~isnan(expValuesInterpSmoothed'))
end

hold on;
maxVal = max(max(expValuesInterpSmoothed));

% Set z positions of markers
if ~contourPlot
    markersVal = ones(length(expValues)) * maxVal;
else
    markersVal = ones(length(expValues));
end
hold on;

if Markers
    plot3(xData_markers, yData_markers, markersVal,'k+');
    hold on;
end

axis equal;
axis tight;
if length(xData_interp) > 5*length(yData_interp) || length(yData_interp) > 5*length(xData_interp)
    axis normal;
end
view(0,90);
%zlim([0 2]);
zlim auto;
if logZ && ~contourPlot
    set(gca, 'zsc', 'log');
    %set(h(1), 'cdata', real(log10(get(h(1), 'cdata'))));
end
if logZ && rawData
    set(gca, 'zsc', 'linear');
end
hold on;

hXLabel(1) = xlabel('X coordinates ($\mu$m)');
hYLabel(1) = ylabel('Y coordinates ($\mu$m)');
hZLabel(1) = zlabel(zString);
hTitle(1) = title(['Mapping of ', zString]);
set([hXLabel(1), hYLabel(1), hZLabel(1), hTitle(1)], ...
    'Color', [0,0,0], 'FontSize', FontSizeVal, ...
    'Interpreter', 'Latex');

if intervalScaleBar > 0
    if ~rawData
        if ~contourPlot
            cmap = ['jet(',num2str(intervalScaleBar),')'];
        else
            if logZ
                cmap = 'jet';
            else
                cmap = ['jet(',num2str(intervalScaleBar),')'];
            end
        end
    else
        if fracCalc
            cmap = [1,1,1;0,0,0]; % Black and white
        else
            if logZ
                cmap = 'jet';
            else
                cmap = ['jet(',num2str(intervalScaleBar),')'];
            end
        end
    end
    colormap(cmap);
else
    colormap('jet');
    % Use flipud to reverse colormap
end
if scaleAxis
    if logZ && contourPlot
        caxis(log([cmin, cmax]));
    elseif logZ && rawData
        caxis(log([cmin, cmax]));
    else
        caxis([cmin, cmax]);
    end
end
if ~fracCalc
    if logZ && contourPlot
        hcb1 = colorbar('YTick',log(Contours),'YTickLabel',Contours);
    elseif logZ && rawData
        hcb1 = colorbar('YTick',log(Contours),'YTickLabel',Contours);
    else
        hcb1 = colorbar;
    end
    
    if minorTicks
        set(hcb1, 'YMinorTick', 'on');
    end
    %if logScale
    %hcb1 = colorbar('Yscale','log');
    %end
    ylabel(hcb1, zString, 'Interpreter', 'Latex', 'FontSize', FontSizeVal);
end
if fracCalc
    %set(hcb1,'YTick',[0:maxVal/2:maxVal]);
    legendBinaryMap('w', 'k', 's', 's', legendStr, FontSizeVal);
end

set(gca, 'Fontsize', FontSizeVal);
hold off;
if rawData && fracCalc
    fracBW = sum(sum(expValuesInterpSmoothed))/(size(expValuesInterpSmoothed,1)*size(expValuesInterpSmoothed,2)*255);
    display(['Fraction of particles (', zString, ' map) :']);
    disp(fracBW);
    display(['Fraction of matrix (', zString, ' map) :']);
    disp(1-fracBW);
end

if savePlot
    saveas(gcf,[pathStr,nameFile,'_',plotName],'png');
    set(gca,'position',[0 0 1 1],'units','normalized')
    saveas(gcf,[pathStr,nameFile,'_',plotName,'_cropped'],'png');
end

%% Plot difference between interpolated data and smoothed data
if ~rawData
    differenceVal = (expValuesInterpSmoothed' - expValuesInterp'); %./expValuesInterp
    
    f(2) = figure('position', [WX, WY, WW, WH]);
    colormap hsv;
    
    h(2) = surf(xData_interp, yData_interp, differenceVal,...
        'FaceColor','interp',...
        'EdgeColor','none',...
        'FaceLighting','gouraud');
    
    axis equal;
    shading interp;
    view(0,90);
    
    hXLabel(2) = xlabel('X coordinates ($\mu$m)');
    hYLabel(2) = ylabel('Y coordinates ($\mu$m)');
    hZLabel(2) = zlabel(zString);
    hTitle(2) = title(['Mapping of difference', ...
        ' between interpolated and smoothed data']);
    set([hXLabel(2), hYLabel(2), hZLabel(2), hTitle(2)], ...
        'Color', [0,0,0], 'FontSize', FontSizeVal, ...
        'Interpreter', 'Latex');
    
    colormap('jet'); % Use flipud to reverse colormap
    hcb5 = colorbar;
    ylabel(hcb5, 'Difference (GPa)', ...
        'Interpreter', 'Latex', ...
        'FontSize', FontSizeVal);
end

end