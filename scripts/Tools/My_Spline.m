function varargout = My_Spline(varargin)
% MY_SPLINE MATLAB code for My_Spline.fig
%      MY_SPLINE, by itself, creates a new MY_SPLINE or raises the existing
%      singleton*.
%
%      H = MY_SPLINE returns the handle to a new MY_SPLINE or the handle to
%      the existing singleton*.
%
%      MY_SPLINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_SPLINE.M with the given input
%      arguments.
%
%      MY_SPLINE('Property','Value',...) creates a new MY_SPLINE or raises
%      the existing singleton*.  Starting from the left, property value
%      pairs are applied to the GUI before My_Spline_OpeningFcn gets
%      called.  An unrecognized property name or invalid value makes
%      property application stop.  All inputs are passed to
%      My_Spline_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help My_Spline

% Last Modified by GUIDE v2.5 25-Jan-2018 00:08:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @My_Spline_OpeningFcn, ...
                   'gui_OutputFcn',  @My_Spline_OutputFcn, ...
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


% --- Executes just before My_Spline is made visible.
function My_Spline_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for My_Spline
handles.output = hObject;
handles.xlim(1) = 0;
handles.xlim(2) = 1;
handles.ylim(1) = 0;
handles.ylim(2) = 1;
set(handles.edit_xlim1,'Visible','off');
set(handles.edit_xlim2,'Visible','off');
set(handles.edit_ylim1,'Visible','off');
set(handles.edit_ylim2,'Visible','off');
handles.x = [];
handles.y = [];


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes My_Spline wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = My_Spline_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT); hObject
% handle to figure eventdata  reserved - to be defined in a future version
% of MATLAB handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% several functions on axes_limits
function edit_xlim1_Callback(hObject, eventdata, handles)
handles.xlim(1) = str2double(get(hObject,'String'));
guidata(hObject, handles);
set(handles.axes,'xlim',[handles.xlim(1), handles.xlim(2)]);

function edit_xlim1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',num2str(0.0));

function edit_xlim2_Callback(hObject, eventdata, handles)
handles.xlim(2) = str2double(get(hObject,'String'));
guidata(hObject, handles);
set(handles.axes,'xlim',[handles.xlim(1), handles.xlim(2)]);

function edit_xlim2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',num2str(1.0));

function edit_ylim1_Callback(hObject, eventdata, handles)
handles.ylim(1) = str2double(get(hObject,'String'));
guidata(hObject, handles);
set(handles.axes,'ylim',[handles.ylim(1), handles.ylim(2)]);

function edit_ylim1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',num2str(0.0));

function edit_ylim2_Callback(hObject, eventdata, handles)
handles.ylim(2) = str2double(get(hObject,'String'));
guidata(hObject, handles);
set(handles.axes,'ylim',[handles.ylim(1), handles.ylim(2)]);

function edit_ylim2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',num2str(1.0));







%%
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
pstn = get(gcf, 'CurrentPoint');
p_axes = get(handles.axes, 'Position');
[rx, ry] = GetRatio(pstn, p_axes);
if rx > 0 && rx < 1 && ry >0 && ry < 1
	set(gcf, 'Pointer', 'crosshair');
else
	set(gcf, 'Pointer', 'arrow');
end


function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
pstn = get(gcf, 'CurrentPoint');
p_axes = get(handles.axes, 'Position');
[rx, ry] = GetRatio(pstn, p_axes);
if rx > 0 && rx < 1 && ry >0 && ry < 1
	handles.x(length(handles.x) + 1) = ...
		handles.xlim(1) * (1 - rx) + handles.xlim(2) * rx;
	handles.y(length(handles.y) + 1) = ...
		handles.ylim(1) * (1 - ry) + handles.ylim(2) * ry;
end
guidata(hObject, handles);
axes(handles.axes);
plot(handles.x,handles.y,'o'), ...
	axis([handles.xlim(1) handles.xlim(2) handles.ylim(1) handles.ylim(2)]);



function [rx, ry] = GetRatio(pstn, p_axes)
rx = (pstn(1) - p_axes(1)) / p_axes(3);
ry = (pstn(2) - p_axes(2)) / p_axes(4);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x_intp = linspace(handles.xlim(1), handles.xlim(2), 100);
y_intp = spline(handles.x, handles.y, x_intp);
axes(handles.axes);
plot(handles.x,handles.y,'o'), ...
	axis([handles.xlim(1) handles.xlim(2) handles.ylim(1) handles.ylim(2)]);
hold on
plot(x_intp, y_intp), ...
	axis([handles.xlim(1) handles.xlim(2) handles.ylim(1) handles.ylim(2)]);
hold off



% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if eventdata.Key == 'v'
	if strcmp(get(handles.edit_xlim2,'Visible'),'on');
		set(handles.edit_xlim1,'Visible','off');
		set(handles.edit_xlim2,'Visible','off');
		set(handles.edit_ylim1,'Visible','off');
		set(handles.edit_ylim2,'Visible','off');
	else
		set(handles.edit_xlim1,'Visible','on');
		set(handles.edit_xlim2,'Visible','on');
		set(handles.edit_ylim1,'Visible','on');
		set(handles.edit_ylim2,'Visible','on');
	end
end
