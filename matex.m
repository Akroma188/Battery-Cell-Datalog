%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Script to import .txt files to excel and plot data into figures
%      
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Note
%   dialog box h = msgbox('Invalid Value', 'Error','error');


function matex

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box to browse files
[FileNames, PathNames]=uigetfile('*.txt', 'Chose files to load:','MultiSelect','on'); %select multiple files
if ischar(FileNames)
    N = 1 ;
else
    N = length(FileNames) ;
end
%h = waitbar(0,'Making Atomic Computacion');
%Cycle starts here, goes through all files
for file = 1:N                         
    if N ==1
        fullpath = [PathNames,FileNames] 
    else
        fullpath = [PathNames,FileNames{file}];    %define the path to file
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %formatSpec = '%s%[~\n\r]';              %for textscan
    %delimiter = '\t';
    %startRow = 0;                               %start of data
    %endRow = inf;                               %end of data
    
    fileID = fopen(fullpath,'r');   %open the file53
    
    % line_read = textscan(fileID,formatSpec,'delimiter',delimiter) %read the file as strings
    %T = cellstr(T);
    T = readtable(fullpath,'Delimiter','\t','ReadVariableNames',false);         %reads everything
    T = table2cell(T);
    
    %Name for directory folder
    Cell_Number1 = T(1,2);
    Cell_Number1 = num2str(cell2mat(Cell_Number1));
    mkdir(Cell_Number1);
    
    Cell_Number2 = T(1,6);
    Cell_Number2 = num2str(cell2mat(Cell_Number2));
    mkdir(Cell_Number2);
    
    Cell_Number3 = T(1,10);
    Cell_Number3 = num2str(cell2mat(Cell_Number3));
    mkdir(Cell_Number3);
    
    %Extract to excel
    [r,c] = size(T);     % r = rows c = columns
    extract_xls(T,Cell_Number1,Cell_Number2,Cell_Number3)
    
    file_out = strcat('ex','.xlsx');
    xlswrite(file_out,T);
    fclose(fileID);
    
%     %Ttype of test
%     Type = T(1,3);
%     Type = num2str(cell2mat(Type));

    %From cell to Matrix (format double)
    TB1 = zeros(r-2,c-8);     %eliminates the 2 rows of unecessary info
    for i = 1:(r-2)
        for j=1:(c-8)
            TB1(i,j) = str2double(cell2mat(T(i+2,j))); 
        end
    end
    
    TB2 = zeros(r-2,c-8);     %eliminates the 2 rows of unecessary info
    for i = 1:(r-2)
        for j=1:(c-8)
            TB2(i,j) = str2double(cell2mat(T(i+2,j+4))); 
        end
    end
    
    TB3 = zeros(r-2,c-8);     %eliminates the 2 rows of unecessary info
    for i = 1:(r-2)
        for j=1:(c-8)
            TB3(i,j) = str2double(cell2mat(T(i+2,j+8))); 
        end
    end
    
    %Extract Measurements
    Voltage_TB1 = TB1(:,1);
    Current_TB1= TB1(:,2);
    Temperature_TB1 = TB1(:,3);
    Time_TB1 = TB1(:,4);
    
    Voltage_TB2 = TB2(:,1);
    Current_TB2= TB2(:,2);
    Temperature_TB2 = TB2(:,3);
    Time_TB2 = TB2(:,4);
    
    Voltage_TB3 = TB3(:,1);
    Current_TB3= TB3(:,2);
    Temperature_TB3 = TB3(:,3);
    Time_TB3 = TB3(:,4);
    
    
    
    %Plot
    %Plotting TB1
    %Make directory for cell information
    cd(Cell_Number1);
    plot_Voltage(Time_TB1,Voltage_TB1,Cell_Number1);    
    plot_Current(Time_TB1,Current_TB1,Cell_Number1);
    plot_Temperature(Time_TB1,Temperature_TB1,Cell_Number1);
    cd ..
    
    %Plotting TB2
    %Make directory for cell information
    cd(Cell_Number2);
    plot_Voltage(Time_TB2,Voltage_TB2,Cell_Number2);    
    plot_Current(Time_TB2,Current_TB2,Cell_Number2);
    plot_Temperature(Time_TB2,Temperature_TB2,Cell_Number2);
    cd ..
    
    %Plotting TB3
    %Make directory for cell information
    cd(Cell_Number3);
    plot_Voltage(Time_TB3,Voltage_TB3,Cell_Number3);    
    plot_Current(Time_TB3,Current_TB3,Cell_Number3);
    plot_Temperature(Time_TB3,Temperature_TB3,Cell_Number3);
    cd ..
   

    %Linenum = 6;                                    %sets the line number
    %name = line_read{1}{Linenum};                   %reads the line 6
    
    %Creates excel file with the .txt info


end

end




function plot_Voltage(Time_TB1,Voltage_TB1,Cell_Number)

    string='Cell Number: ';
    Title= strcat(string,Cell_Number);

    Volt=figure;
    set(Volt, 'Visible', 'off');
    Volt=plot(Time_TB1,Voltage_TB1);
    set(Volt,'LineWidth',2);
    title({Title;'Voltage Over Time'})                 
    xlabel('Time');
    ylabel({'Voltage','(V)'});
    str='voltage_';
    type='.png';
    str1=strcat(str,Cell_Number);
    str2=strcat(str1,type);
    saveas(Volt,str2);


    
end

function plot_Current(Time,Current,Cell_Number)

    string='Cell Number: ';
    Title= strcat(string,Cell_Number);

    Curr=figure;
    set(Curr, 'Visible', 'off');
    Curr=plot(Time,Current);
    set(Curr,'LineWidth',2);
    title({Title;'Current Over Time'})          
    xlabel('Time');
    ylabel({'Current','(A)'});
    str='current_';
    type='.png';
    str1=strcat(str,Cell_Number);
    str2=strcat(str1,type);
    saveas(Curr,str2);

end

function plot_Temperature(Time,Temp,Cell_Number)

    string='Cell Number: ';
    Title= strcat(string,Cell_Number);

    Tempe=figure;
    set(Tempe, 'Visible', 'off');
    Tempe=plot(Time,Temp);
    set(Tempe,'LineWidth',2);
    title({Title;'Temperature Over Time'})         
    xlabel('Time');
    ylabel({'Temperature','(ºC)'});
    str='temperature_';
    type='.png';
    str1=strcat(str,Cell_Number);
    str2=strcat(str1,type);
    saveas(Tempe,str2);

end

function extract_xls(T,Cell_Number1,Cell_Number2,Cell_Number3)
[r,c] = size(T);
    TB1 = cell(4,r);     %eliminates the 2 rows of unecessary info
    for i = 1:(r-2)
        for j=1:(c-8)
            TB1(i,j) = T(i,j); 
        end
    end
    
    TB2 = cell(4,r);     %eliminates the 2 rows of unecessary info
    for i = 1:(r)
        for j=1:(c-8)
            TB2(i,j) = T(i,j+4); 
        end
    end
    
    TB3 = cell(r,4);     %eliminates the 2 rows of unecessary info
    for i = 1:(r)
        for j=1:(c-8)
            TB3(i,j) = T(i,j+8); 
        end
    end

    cd(Cell_Number1)
    file_out = strcat(Cell_Number1,'.xlsx');
    xlswrite(file_out,TB1);
    cd ..
    
    cd(Cell_Number2)
    file_out = strcat(Cell_Number2,'.xlsx');
    xlswrite(file_out,TB2);
    cd ..
    
    cd(Cell_Number3)
    file_out = strcat(Cell_Number2,'.xlsx');
    xlswrite(file_out,TB2);
    cd ..
    
end