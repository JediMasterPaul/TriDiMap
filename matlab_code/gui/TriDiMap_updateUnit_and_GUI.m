%% Copyright 2014 MERCIER David
function TriDiMap_updateUnit_and_GUI
%% Function to get units from the GUI and set automatically in the plot
gui = guidata(gcf);
h = gui.handles;

strUnit_Length = get_value_popupmenu(h.unitLength_GUI, listUnitLength);
strUnit_Property = get_value_popupmenu(h.unitProp_GUI, listUnitProperty);

set(h.unit_deltaXindents_GUI, 'string', strUnit_Length);
set(h.unit_deltaYindents_GUI, 'string', strUnit_Length);

if strcmp(get(h.binarization_GUI, 'String'), 'BINARIZATION')
    gui.config.propertyOld = gui.config.property;
    gui.config.property = get(h.property_GUI, 'Value');
    if gui.config.property == 1 || gui.config.property == 2
        set([h.unit_x_values_GUI, h.unit_y_values_GUI], ...
            'string', strUnit_Length);
    elseif gui.config.property == 3
        set([h.unit_x_values_GUI, h.unit_y_values_GUI], ...
            'string', strUnit_Property);
    elseif gui.config.property > 3
        set(h.unit_x_values_GUI, 'string', strUnit_Property);
        set(h.unit_y_values_GUI, 'string', '');
    end
    set([h.unit_colorMin_GUI, h.unit_colorMax_GUI, ...
        h.unit_z_values_GUI, h.unit_transMap_GUI, ...
        h.unit_MinVal_GUI, h.unit_MeanVal_GUI, ...
        h.unit_MaxVal_GUI, h.unit_BinSizeHist_GUI, ...
        h.unit_MinValHist_GUI, h.unit_MaxValHist_GUI, ...
        h.unit_Hth_ValEH_GUI, h.unit_Eth_ValEH_GUI], ...
        'string', strUnit_Property);
    if get(h.property_GUI, 'Value') < 3
        set([h.bg_property_GUI_1_2, h.bg2_property_GUI_1_2],...
            'Visible', 'on');
        set([h.bg_property_GUI_3, h.bg2_property_GUI_3],...
            'Visible', 'off');
        set([h.bg_property_GUI_4_5, h.bg2_property_GUI_4_5],...
            'Visible', 'off');
        set([h.bg_property_GUI_6_7, h.bg2_property_GUI_6_7],...
            'Visible', 'off');
    elseif get(h.property_GUI, 'Value') == 3
        set([h.bg_property_GUI_1_2, h.bg2_property_GUI_1_2],...
            'Visible', 'off');
        set([h.bg_property_GUI_3, h.bg2_property_GUI_3],...
            'Visible', 'on');
        set([h.bg_property_GUI_4_5, h.bg2_property_GUI_4_5],...
            'Visible', 'off');
        set([h.bg_property_GUI_6_7, h.bg2_property_GUI_6_7],...
            'Visible', 'off');
    elseif (get(h.property_GUI, 'Value') > 3 && get(h.property_GUI, 'Value') < 6) || get(h.property_GUI, 'Value') > 7
        set([h.bg_property_GUI_1_2, h.bg2_property_GUI_1_2],...
            'Visible', 'off');
        set([h.bg_property_GUI_3, h.bg2_property_GUI_3],...
            'Visible', 'off');
        set([h.bg_property_GUI_4_5, h.bg2_property_GUI_4_5],...
            'Visible', 'on');
        set([h.bg_property_GUI_6_7, h.bg2_property_GUI_6_7],...
            'Visible', 'off');
    elseif get(h.property_GUI, 'Value') > 6 && get(h.property_GUI, 'Value') < 8
        set([h.bg_property_GUI_1_2, h.bg2_property_GUI_1_2],...
            'Visible', 'off');
        set([h.bg_property_GUI_3, h.bg2_property_GUI_3],...
            'Visible', 'off');
        set([h.bg_property_GUI_4_5, h.bg2_property_GUI_4_5],...
            'Visible', 'off');
        set([h.bg_property_GUI_6_7, h.bg2_property_GUI_6_7],...
            'Visible', 'on');
    end
else
    set([h.unit_criterionE_GUI, h.unit_criterionH_GUI,...
        h.unit_valMeanLow_E_GUI, h.unit_valMeanHigh_E_GUI, ...
        h.unit_valMeanLow_H_GUI, h.unit_valMeanHigh_H_GUI], ...
        'string', strUnit_Property);
end
set(h.date_GUI, 'String', datestr(datenum(clock),'mmm.dd,yyyy HH:MM'))
gui.config.strUnit_Length = strUnit_Length;
gui.config.strUnit_Property = strUnit_Property;
guidata(gcf, gui);

end