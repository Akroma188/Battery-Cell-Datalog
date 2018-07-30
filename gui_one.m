function varargout = gui_one(varargin)
% GUI_ONE MATLAB code for gui_one.fig
%      GUI_ONE, by itself, creates a new GUI_ONE or raises the existing
%      singleton*.
%
%      H = GUI_ONE returns the handle to a new GUI_ONE or the handle to
%      the existing singleton*.
%
%      GUI_ONE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ONE.M with the given input arguments.
%
%      GUI_ONE('Property','Value',...) creates a new GUI_ONE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI_ONE before gui_one_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_one_OpeningFcn via varargin.
%
%      *See GUI_ONE Options on GUIDE's Tools menu.  Choose "GUI_ONE allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_one

% Last Modified by GUIDE v2.5 30-Jul-2018 20:11:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_one_OpeningFcn', @gui_one_OpeningFcn, ...
                   'gui_one_OutputFcn',  @gui_one_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_one is made visible.
function gui_one_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_one (see VARARGIN)

% Choose default command line output for gui_one
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_one wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_one_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.FileNames, handles.PathNames]=uigetfile('*.txt', 'Chose files to load:','MultiSelect','on');
set(handles.files,'String',handles.FileNames)
                              %Store location

% --- Executes on selection change in files.
function files_Callback(hObject, eventdata, handles)
% hObject    handle to files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    


% Hints: contents = cellstr(get(hObject,'String')) returns files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from files


% --- Executes during object creation, after setting all properties.
function files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
listStr = get(handles.files,'String')
ListVal = get(handles.files, 'Value');
if(iscell(listStr))
    fileName = listStr(ListVal)
    fileName=num2str(cell2mat(fileName))
    
    fileID = fopen(fileName,'r');
    T = readtable(fileName,'Delimiter','\t','ReadVariableNames',false);         %reads everything
    fclose(fileID);
    T = table2cell(T);
    [r,c] = size(T);
    Cell_Number1 = T(1,2);
    Cell_Number1 = num2str(cell2mat(Cell_Number1));
    
    Cell_Number2 = T(1,6);
    Cell_Number2 = num2str(cell2mat(Cell_Number2));
    
    Cell_Number3 = T(1,10);
    Cell_Number3 = num2str(cell2mat(Cell_Number3));
    cell=[Cell_Number1; Cell_Number2; Cell_Number3];
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
    handles.Voltage_TB1 = TB1(:,1);
    handles.Current_TB1= TB1(:,2);
    handles.Temperature_TB1 = TB1(:,3);
    handles.Time_TB1 = TB1(:,4);
    
    handles.Voltage_TB2 = TB2(:,1);
    handles.Current_TB2= TB2(:,2);
    handles.Temperature_TB2 = TB2(:,3);
    handles.Time_TB2 = TB2(:,4);
    
    handles.Voltage_TB3 = TB3(:,1);
    handles.Current_TB3= TB3(:,2);
    handles.Temperature_TB3 = TB3(:,3);
    handles.Time_TB3 = TB3(:,4);
    
    
    set(handles.cells,'String',cell);  
else
    fileName = listStr;
    fileID = fopen(fileName,'r');
    T = readtable(fileName,'Delimiter','\t','ReadVariableNames',false);         %reads everything
    fclose(fileID);
    T = table2cell(T);
    [r,c] = size(T);
    Cell_Number1 = T(1,2);
    Cell_Number1 = num2str(cell2mat(Cell_Number1));
    
    Cell_Number2 = T(1,6);
    Cell_Number2 = num2str(cell2mat(Cell_Number2));
    
    Cell_Number3 = T(1,10);
    Cell_Number3 = num2str(cell2mat(Cell_Number3));
    cell=[Cell_Number1; Cell_Number2; Cell_Number3];
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
    
    %Extract Measurements and save in structure
    handles.TB1=TB1;
    handles.Voltage_TB1 = TB1(:,1);
    handles.Current_TB1= TB1(:,2);
    handles.Temperature_TB1 = TB1(:,3);
    handles.Time_TB1 = TB1(:,4);
    handles.Cell_num1=Cell_Number1;
    
    handles.TB2=TB2;
    handles.Voltage_TB2 = TB2(:,1);
    handles.Current_TB2= TB2(:,2);
    handles.Temperature_TB2 = TB2(:,3);
    handles.Time_TB2 = TB2(:,4);
    handles.Cell_num2=Cell_Number2;
    
    handles.TB3=TB3;
    handles.Voltage_TB3 = TB3(:,1);
    handles.Current_TB3= TB3(:,2);
    handles.Temperature_TB3 = TB3(:,3);
    handles.Time_TB3 = TB3(:,4);
    handles.Cell_num3=Cell_Number3;
    %save data to structure
    guidata(gui,handles)
    set(handles.cells,'String',cell);
end


% Hint: get(hObject,'Value') returns toggle state of load


% --- Executes on button press in export.
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.folder_name = uigetdir('C:\','Select directory to save');           %Get directory to save
cd(handles.folder_name)
path=handles.folder_name
%%PLOT and SAVE TB1
Volt1=handles.Voltage_TB1;
Curr1=handles.Current_TB1;
Temp1=handles.Temperature_TB1;
Time1=handles.Time_TB1;
Cell_Number=handles.Cell_num1;

plot_Voltage(Time1,Volt1,Cell_Number,path)
plot_Current(Time1,Curr1,Cell_Number,path)
plot_Temperature(Time1,Temp1,Cell_Number,path)

%%PLOT and SAVE TB2
Volt2=handles.Voltage_TB2;
Curr2=handles.Current_TB2;
Temp2=handles.Temperature_TB2;
Time2=handles.Time_TB2;
Cell_Number=handles.Cell_num2;

plot_Voltage(Time2,Volt2,Cell_Number,path)
plot_Current(Time2,Curr2,Cell_Number,path)
plot_Temperature(Time2,Temp2,Cell_Number,path)

%%PLOT and SAVE TB3
Volt3=handles.Voltage_TB3;
Curr3=handles.Current_TB3;
Temp3=handles.Temperature_TB3;
Time3=handles.Time_TB3;
Cell_Number=handles.Cell_num;

plot_Voltage(Time3,Volt3,Cell_Number,path)
plot_Current(Time3,Curr3,Cell_Number,path)
plot_Temperature(Time3,Temp3,Cell_Number,path)

%Extract all to excel
cd(handles.Cell_num1)
file_out = strcat(handles.Cell_num1,'.xlsx');
xlswrite(file_out,handles.TB1);
cd ..

cd(handles.Cell_num2)
file_out = strcat(handles.Cell_num2,'.xlsx');
xlswrite(file_out,handles.TB2);
cd ..

cd(handles.Cell_num3)
file_out = strcat(handles.Cell_num3,'.xlsx');
xlswrite(file_out,handles.TB3);
cd ..

set(handles.aux,'String',handles.folder_name);


% --- Executes on button press in plot2.
function plot2_Callback(hObject, eventdata, handles)
% hObject    handle to plot2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cellVal= get(handles.cells, 'Value');
cellStr= get(handles.cells, 'String');%Select cell to plot


voltVal = get(handles.volt2, 'Value');
currVal = get(handles.curr2, 'Value');
tempVal = get(handles.temp2, 'Value');
capVal = get(handles.cap2, 'Value');

cellnum=str2num(cellStr)
cellnum=num2str(cellnum(cellVal))
string='Cell Number: ';
Title= strcat(string,cellnum)

if(cellVal==1)
    cellVal
    Volt=handles.Voltage_TB1;
    Curr=handles.Current_TB1;
    Temp=handles.Temperature_TB1;
    Time=handles.Time_TB1;
elseif(cellVal==2)
    cellVal
    Volt=handles.Voltage_TB2;
    Curr=handles.Current_TB2;
    Temp=handles.Temperature_TB2;
    Time=handles.Time_TB2;
else
    cellVal
    Volt=handles.Voltage_TB3;
    Curr=handles.Current_TB3;
    Temp=handles.Temperature_TB3;
    Time=handles.Time_TB3;
end

axes(handles.axes2)
if(voltVal==1)
    plot(Time,Volt,'linewidth',2);
    xlabel(handles.axes2,'Time');
    ylabel(handles.axes2,'Voltage');
    title1=strcat(Title,'                                     Voltage Over Time');
    title(title1); 
elseif(currVal==1)
    plot(Time,Curr,'linewidth',2);
    xlabel(handles.axes2,'Time');
    ylabel(handles.axes2,'Current');
    title1=strcat(Title,'                                     Current Over Time');
    title(title1);          
elseif(tempVal==1)
    plot(Time,Temp,'linewidth',2);
    xlabel(handles.axes2,'Time');
    ylabel(handles.axes2,'Temperature');
    title1=strcat(Title,'                            Temperature Over Time');
    title(title1);
else
    plot(Time,Cap);
end


% --- Executes on button press in volt1.
function volt1_Callback(hObject, eventdata, handles)
% hObject    handle to volt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of volt1


% --- Executes on button press in curr1.
function curr1_Callback(hObject, eventdata, handles)
% hObject    handle to curr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of curr1


% --- Executes on button press in temp1.
function temp1_Callback(hObject, eventdata, handles)
% hObject    handle to temp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of temp1


% --- Executes on button press in cap1.
function cap1_Callback(hObject, eventdata, handles)
% hObject    handle to cap1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cap1


% --- Executes on button press in plot1.
function plot1_Callback(hObject, eventdata, handles)
% hObject    handle to plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cellVal= get(handles.cells, 'Value');           %Select cell to plot
cellStr= get(handles.cells, 'String');

voltVal = get(handles.volt1, 'Value');
currVal = get(handles.curr1, 'Value');
tempVal = get(handles.temp1, 'Value');
capVal = get(handles.cap1, 'Value');

cellnum=str2num(cellStr)
cellnum=num2str(cellnum(cellVal))
string='Cell Number: ';
Title= strcat(string,cellnum)

if(cellVal==1)
    cellVal
    Volt=handles.Voltage_TB1;
    Curr=handles.Current_TB1;
    Temp=handles.Temperature_TB1;
    Time=handles.Time_TB1;
elseif(cellVal==2)
    cellVal
    Volt=handles.Voltage_TB2;
    Curr=handles.Current_TB2;
    Temp=handles.Temperature_TB2;
    Time=handles.Time_TB2;
else
    cellVal
    Volt=handles.Voltage_TB3;
    Curr=handles.Current_TB3;
    Temp=handles.Temperature_TB3;
    Time=handles.Time_TB3;
end

axes(handles.axes1)
if(voltVal==1)
    plot(Time,Volt,'linewidth',2);
    xlabel(handles.axes2,'Time');
    ylabel(handles.axes2,'Voltage')
    title1=strcat(Title,'                                     Voltage Over Time');
    title(title1); 
elseif(currVal==1)
    plot(Time,Curr,'linewidth',2);
    xlabel(handles.axes2,'Time');
    ylabel(handles.axes2,'Current');
    title1=strcat(Title,'                                     Current Over Time');
    title(title1);
elseif(tempVal==1)
    plot(Time,Temp,'linewidth',2);
    xlabel(handles.axes2,'Time');
    ylabel(handles.axes2,'Temperature');
    title1=strcat(Title,'                            Temperature Over Time');
    title(title1);
else
    plot(Time,Cap);
end
    



% --- Executes on selection change in cells.
function cells_Callback(hObject, eventdata, handles)
% hObject    handle to cells (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns cells contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cells


% --- Executes during object creation, after setting all properties.
function cells_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cells (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function plot_Voltage(Time_TB1,Voltage_TB1,Cell_Number,path)

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
    file_destination=strcat(path,str2);
    saveas(Volt,file_destination);

function plot_Current(Time,Current,Cell_Number,path)

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
    file_destination=strcat(path,str2);
    saveas(Curr,file_destination);
    
function plot_Temperature(Time,Temp,Cell_Number,path)

    string='Cell Number: ';
    Title= strcat(string,Cell_Number);

    Tempe=figure;
    set(Tempe, 'Visible', 'off');
    Tempe=plot(Time,Temp);
    set(Tempe,'LineWidth',2);
    title({Title;'Temperature Over Time'})         
    xlabel('Time');
    ylabel({'Temperature','(�C)'});
    str='temperature_';
    type='.png';
    str1=strcat(str,Cell_Number);
    str2=strcat(str1,type);
    file_destination=strcat(path,str2);
    saveas(Tempe,file_destination);
