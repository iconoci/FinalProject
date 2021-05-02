function plotProject()

global gui;
%All the string GUI. 
gui.title = figure('numbertitle', 'off', 'name', 'Plot');
gui.plot = plot(0,0);
gui.xAxisBox = uicontrol('style', 'text', 'units', 'normalized', 'position', [0, 0.93, 0.1, 0.05], 'string', 'X Values:', 'horizontalalignment', 'right');
gui.yAxisBox = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.2, 0.93, 0.1, 0.05], 'string', 'Y Values:', 'horizontalalignment', 'right');
gui.colorText = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.92, 0.83, 0.06, 0.06], 'string', 'Color', 'horizontalalignment', 'right');
gui.lineText = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.92, 0.53, 0.06, 0.06], 'string', 'Line', 'horizontalalignment', 'right');
gui.plotTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.35, 0.93, 0.1, 0.05], 'string', 'Title:', 'horizontalalignment', 'right');
gui.plotTitle = uicontrol('style', 'edit', 'units', 'normalized', 'position', [0.45, 0.94, 0.2, 0.05], 'horizontalalignment', 'right');
gui.xAxisTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.3, 0, 0.1, 0.05], 'string', 'X Axis:', 'horizontalalignment', 'right');
gui.xAxisEdit = uicontrol('style', 'edit', 'units', 'normalized', 'position', [0.4, 0.005, 0.1, 0.05], 'horizontalalignment', 'right');
gui.yAxisTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [-0.02, 0.6, 0.1, 0.05], 'string', 'Y Axis:', 'horizontalalignment', 'right');
gui.yAxisEdit = uicontrol('style', 'edit', 'units', 'normalized', 'position', [0, 0.57, 0.085, 0.05], 'horizontalalignment', 'right');

%Axis limit GUI
gui.xLimitText = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0, 0.1, 0.05], 'string', 'X Limit:', 'horizontalalignment', 'right');
gui.xLimitEdit = uicontrol('style', 'edit', 'units', 'normalized', 'position', [0.605, 0.005, 0.1, 0.05], 'horizontalalignment', 'right', 'callback', {@xLim});
gui.yLimitText = uicontrol('style', 'text', 'units', 'normalized', 'position', [-0.02, .5, 0.1, 0.05], 'string', 'Y Limit:', 'horizontalalignment', 'right');
gui.yLimitEdit = uicontrol('style', 'edit', 'units', 'normalized', 'position', [0, 0.47, 0.085, 0.05], 'horizontalalignment', 'right', 'callback', {@yLim});

%Functions for limits
    function[xLimits] = xLim(source, event)
        gui.xLimits = str2num(get(gui.xLimitEdit,'string'));
        assignin('base', 'xLimits', gui.xValues);
        gui.minX = min(gui.xLimits);
        gui.maxX = max(gui.xLimits);
    end

    function[yLimits] = yLim(source, event)
        gui.yLimits = str2num(get(gui.yLimitEdit,'string'));
        assignin('base', 'yLimits', gui.yValues);
        gui.minY = min(gui.yLimits);
        gui.maxY = max(gui.yLimits);
    end

%Push botton gui to reset and graph
gui.resetButton = uicontrol('style', 'push', 'units', 'normalized', 'position', [0, 0, 0.1, 0.06], 'string', 'Reset', 'callback', {@reset});
gui.graphButton = uicontrol('style', 'push', 'units', 'normalized', 'position', [0.1, 0, 0.1, 0.06], 'string', 'Graph', 'callback', {@graphValues});

%GUI for the X and Y input text boxes
gui.xInputBox = uicontrol('style', 'edit', 'units', 'normalized', 'position', [0.1, 0.94, 0.1, 0.05], 'horizontalalignment', 'right', 'callback', {@xValue});
gui.yInputBox = uicontrol('style', 'edit', 'units', 'normalized', 'position', [0.3, 0.94, 0.1, 0.05], 'horizontalalignment', 'right', 'callback', {@yValue});

%Default Color Red
gui.color = 'red';
%Radio Button Group for Color
gui.colorGroup = uibuttongroup('Visible','on','Position', [.91, .5, .09, .4], 'SelectionChangedFcn', @setColor);
%Radio Buttons for Color
gui.red = uicontrol(gui.colorGroup, 'style', 'radiobutton', 'units', 'normalized', 'position', [0.1, 0.6, 1, 0.1], 'string', 'red', 'horizontalalignment', 'right')
gui.blue = uicontrol(gui.colorGroup, 'style', 'radiobutton', 'units', 'normalized', 'position', [0.1, 0.5, 1, 0.1], 'string', 'blue', 'horizontalalignment', 'right')
gui.green = uicontrol(gui.colorGroup, 'style', 'radiobutton', 'units', 'normalized', 'position', [0.1, 0.4, 1, 0.1], 'string', 'green', 'horizontalalignment', 'right')

%Default Dash
gui.line = '-';
%Radio Button Group for Line
gui.lineGroup = uibuttongroup('Visible','on','Position', [.91, .1, .09, .4], 'SelectionChangedFcn', @setLine);
%Radio Buttons for Line
gui.solid = uicontrol(gui.lineGroup, 'style', 'radio', 'units', 'normalized', 'position', [0.1, 0.6, 1, 0.1], 'string', '-', 'horizontalalignment', 'right');
gui.dashed = uicontrol(gui.lineGroup, 'style', 'radio', 'units', 'normalized', 'position', [0.1, 0.5, 1, 0.1], 'string', '-- ', 'horizontalalignment', 'right');
gui.dashdot = uicontrol(gui.lineGroup, 'style', 'radio', 'units', 'normalized', 'position', [0.1, 0.4, 1, 0.1], 'string', '-.', 'horizontalalignment', 'right');

    function[color] = setColor(source, event) 
        gui.color = event.NewValue.String;
    end

    function[line] = setLine(source, event) 
        gui.line = event.NewValue.String;
    end

% Function that gets called in order to determine x values
    function[xValues] = xValue(source, event)
        gui.xValues = str2num(get(gui.xInputBox,'string'));
        assignin('base', 'xValues', gui.xValues);
    end

% Function that gets called in order to determine y values
    function[yValues] = yValue(source, event)
        gui.yValues = str2num(get(gui.yInputBox,'string'));
        assignin('base', 'yValues', gui.yValues);
    end

%Function to plot the x and y values, includes limits and check for same
%amount of x/y values
    function [] = graphValues(source, event)
        if length(gui.xValues) == 0 || length(gui.yValues) == 0
            msgbox('Values must be numbers.','modal');     
        elseif length(gui.xValues) ~= length(gui.yValues)
            msgbox('Must have the same amount of x and y values.','modal');
        elseif length(gui.xLimits) ~= 2 || length(gui.yLimits) ~= 2
            msgbox('Must have two values for the limts.','modal');
        else
            gui.lineColor = append(gui.line, gui.color);
            gui.plot = plot(gui.xValues, gui.yValues, gui.lineColor);
            xlim([gui.minX, gui.maxX]); 
            ylim([gui.minY, gui.maxY]);
        end
    
    end

%Reset function that clears the figure of previous data
    function [] = reset(source, event)
        close all;

        plotProject;
    end

end




