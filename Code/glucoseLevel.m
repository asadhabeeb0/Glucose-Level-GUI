function glucoselevel()
    % Create the GUI figure
    fig = uifigure('Position', [100 100 600 400], 'Name', 'Glucose Level Monitor');
    
    % Add a text label for the input field
    uilabel(fig, 'Position', [50 320 100 22], 'Text', 'Glucose Level:');
    
    % Add an input field for the glucose level
    glucose_field = uieditfield(fig, 'numeric', 'Position', [160 320 100 22]);
    
    % Add a button to submit the glucose level
    submit_button = uibutton(fig, 'Position', [280 320 100 22], 'Text', 'Submit', 'ButtonPushedFcn', @submit_callback);
    
    % Add an axes for the graph
    axes_graph = uiaxes(fig, 'Position', [50 50 500 250]);
    xlabel(axes_graph, 'Time (minutes)');
    ylabel(axes_graph, 'Glucose Level');
    
    % Initialize variables for glucose data and time
    glucose_data = [];
    time_data = [];
    
    % Create a timer to prompt the user every 15 minutes
    t = timer('ExecutionMode', 'fixedRate', 'Period', 900, 'TimerFcn', @timer_callback);
    start(t);
    
    % Define the submit_callback function
    function submit_callback(src, event)
        % Get the glucose level from the input field
        glucose = glucose_field.Value;
        
        % Add the glucose level and current time to the data arrays
        glucose_data = [glucose_data, glucose];
        time_data = [time_data, datetime("now")];
        
        % Plot the glucose data on the graph
        plot(axes_graph, (time_data - time_data(1)) * 24 * 60, glucose_data, '-o');
    end
    
    % Define the timer_callback function
    function timer_callback(src, event)
        % Prompt the user to enter the glucose level
        glucose = inputdlg('Please enter your glucose level:');
        
        % Convert the glucose level to a number and add it to the data arrays
        glucose = str2double(glucose);
        glucose_data = [glucose_data, glucose];
        time_data = [time_data, datetime("now")];
        
        % Plot the glucose data on the graph
        plot(axes_graph, (time_data - time_data(1)) * 24 * 60, glucose_data, '-o');
    end
end
