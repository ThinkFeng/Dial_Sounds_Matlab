function varargout = dial(varargin)
% DIAL MATLAB code for dial.fig
%      DIAL, by itself, creates a new DIAL or raises the existing
%      singleton*.
%
%      H = DIAL returns the handle to a new DIAL or the handle to
%      the existing singleton*.
%
%      DIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIAL.M with the given input arguments.
%
%      DIAL('Property','Value',...) creates a new DIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dial

% Last Modified by GUIDE v2.5 07-Feb-2014 18:05:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dial_OpeningFcn, ...
                   'gui_OutputFcn',  @dial_OutputFcn, ...
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


% --- Executes just before dial is made visible.
function dial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dial (see VARARGIN)

% Choose default command line output for dial
handles.output = hObject;

% Update handles structure

guidata(hObject, handles);
 clear;clc
% UIWAIT makes dial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in record_wav.
function record_wav_Callback(hObject, eventdata, handles)
% hObject    handle to record_wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of record_wav


% --- Executes on button press in load_wav.
function load_wav_Callback(hObject, eventdata, handles)
% hObject    handle to load_wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of load_wav
if isempty(get(handles.load_wav,'value'))
    set(handles.load_wav,'value',1)
    set(handles.record_wav,'value',0)
    set(handles.scan,'enable','on')
else
    
end


function ads_Callback(hObject, eventdata, handles)
% hObject    handle to ads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ads as text
%        str2double(get(hObject,'String')) returns contents of ads as a double


% --- Executes during object creation, after setting all properties.
function ads_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in scan.
function scan_Callback(hObject, eventdata, handles)
% hObject    handle to scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x fs
[filename,filepath]=uigetfile('*.wav','打开文件');
path = strcat(filepath,filename);
if isempty(path)
    set(handles.sybx,'enable','off')
    return
else
    set(handles.sybx,'enable','on')
end
str=filename(end-2:end);
if strcmp(str,'wav')
    set(handles.ads,'string',path);
    [x,fs,bits]=wavread(path);
    %x=reshape(x,size(x,1)*2,1);
else
    msgbox('目前只支持WAV格式，您的导入有误，请重新导入！','警告')
    return
end


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
set(handles.sybx,'enable','off')
set(handles.ansys,'enable','off')
set(handles.result,'string','分析结果')
if get(handles.load_wav,'value')==1
    set(handles.up2,'visible','on')
    set(handles.up3,'visible','off')
else
    set(handles.up3,'visible','on')
    set(handles.up2,'visible','off')
end


% --- Executes on button press in ansys.
function ansys_Callback(hObject, eventdata, handles)
% hObject    handle to ansys (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global posi posj x fs
global hard
if str2double(get(handles.hard,'string'))>0 &&...
        str2double(get(handles.hard,'string'))<=1
    hard = str2double(get(handles.hard,'string'));
else
    msgbox('线性硬度值应该在0~1之间')
    set(handles.hard,'string',0.01)
    return
end
set(handles.ansys,'string','Ansysing','enable','off')
set(handles.sybx,'enable','off')
pause(0)
keyboard = {1 2 3;
           4 5 6;
           7 8 9;
           '*' 0 '#'};
       pos1= '';
n = 1;
z=10*x;
trial=10;
while (trial<=(length(x)-fs/4))
    if z(trial)>=str2double(get(handles.wave_avg,'string'))
        y=x(trial:(fs/4)+trial,1);
        [posi,posj]=ShowCosines(y,fs);
        if posi==0||posj==0
            trial=trial+20;
        else
            if posi==4 && (posj==1||posj==3)
                if posi==4 && posj==1
                    pos1(n) = '*';
                else
                    pos1(n) = '#';
                end
            else
            pos{n}=keyboard{posi,posj};
            pos1(n)=mat2str(cell2mat(pos(n)));
            end
            n=n+1;
            trial=trial+floor(fs/4);
        end
    else
        trial=trial+20;
    end
end
if size(pos1)<1
    pos1 = '没有检测到拨号，请重新调整参数！';
end
set(handles.ansys,'string','分 析','enable','on')
set(handles.result,'string',pos1)
set(handles.sybx,'enable','on')

function hard_Callback(hObject, eventdata, handles)
% hObject    handle to hard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hard as text
%        str2double(get(hObject,'String')) returns contents of hard as a double


% --- Executes during object creation, after setting all properties.
function hard_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rec_time_Callback(hObject, eventdata, handles)
% hObject    handle to rec_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rec_time as text
%        str2double(get(hObject,'String')) returns contents of rec_time as a double


% --- Executes during object creation, after setting all properties.
function rec_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rec_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rec_start.
function rec_start_Callback(hObject, eventdata, handles)
% hObject    handle to rec_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x fs
sc = str2double(get(handles.rec_time,'string'));
if sc ~= 0
    %% 录音
    set(handles.rec_start,'string','正在录音','enable','off','backgroundcolor','r')
    pause(0)
    fs = 44100;
    x  = wavrecord(sc*fs, fs, 'double');
    x(length(x)+1) = 0;%补一个空值
    set(handles.rec_start,'string','开始录音','enable','on','backgroundcolor',[0.94 0.94 0.94])
    set(handles.sybx,'enable','on')
else
    msgbox('录音时长输入有误，请重新输入！','Warning','warn')
end


% --- Executes on button press in rec_flag.
function rec_flag_Callback(hObject, eventdata, handles)
% hObject    handle to rec_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rec_flag



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sybx.
function sybx_Callback(hObject, eventdata, handles)
% hObject    handle to sybx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x fs
t = (0:length(x)-1)/fs;
figure
plot(t,20*x)
title('由此图确定线性度阀值')
grid on
set(handles.ansys,'enable','on')


function [posi,posj]= ShowCosines(y,fs)%线性度比较函数
global hard
tVals = 0:(1/fs):0.25;
tau = 2*pi*tVals';
fR = [697 770 852 941];
trueR = [sin(tau*fR(1)) sin(tau*fR(2)) sin(tau*fR(3)) sin(tau*fR(4))];
fC = [1209 1336 1477];
trueC = [sin(tau*fC(1)) sin(tau*fC(2)) sin(tau*fC(3))];
for i =1:4
    rowcosine(i)=cos_xy(y,trueR(:,i));
end
for j=1:3
    colcosine(j)=cos_xy(y,trueC(:,j));
end

if max(rowcosine)>hard
    [numi posi]=max(rowcosine);
else
    posi=0;
end

if max(colcosine)>hard
    [numj posj]=max(colcosine);
else
    posj=0;
end

function c = cos_xy(x,y)
c = abs(sum(x.*y))/(sqrt(sum(x.*x))*sqrt(sum(y.*y)));



function wave_avg_Callback(hObject, eventdata, handles)
% hObject    handle to wave_avg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wave_avg as text
%        str2double(get(hObject,'String')) returns contents of wave_avg as a double


% --- Executes during object creation, after setting all properties.
function wave_avg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wave_avg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on hard and none of its controls.


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
