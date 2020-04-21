function varargout = projrct1(varargin)
    % PROJRCT1 M-file for projrct1.fig
    %      PROJRCT1, by itself, creates a new PROJRCT1 or raises the existing
    %      singleton*.
    %
    %      H = PROJRCT1 returns the handle to a new PROJRCT1 or the handle to
    %      the existing singleton*.
    %
    %      PROJRCT1('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in PROJRCT1.M with the given filenameinput arguments.
    %
    %      PROJRCT1('Property','Value',...) creates a new PROJRCT1 or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before projrct1_OpeningFunction gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to projrct1_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to reset (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Copyright 2002-2003 The MathWorks, Inc.

    % Edit the above text to modify the response to help projrct1

    % Last Modified by GUIDE v2.5 19-Apr-2020 15:52:18

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                    'gui_Singleton',  gui_Singleton, ...
                    'gui_OpeningFcn', @projrct1_OpeningFcn, ...
                    'gui_OutputFcn',  @projrct1_OutputFcn, ...
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


% --- Executes just before projrct1 is made visible.
function projrct1_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to projrct1 (see VARARGIN)

    % Choose default command line output for projrct1
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes projrct1 wait for user response (see UIRESUME)
    % uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = projrct1_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;



function FileNameInput_Callback(hObject, eventdata, handles)
    % hObject    handle to FileNameInput (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of FileNameInput as text
    %        str2double(get(hObject,'String')) returns contents of FileNameInput as a double


% --- Executes during object creation, after setting all properties.
function FileNameInput_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to FileNameInput (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc
        set(hObject,'BackgroundColor','white');
    else
        set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
    end


function Parameter_Callback(hObject, eventdata, handles)
    % hObject    handle to Parameter (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of Parameter as text
    %        str2double(get(hObject,'String')) returns contents of Parameter as a double


% --- Executes during object creation, after setting all properties.
function Parameter_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to Parameter (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc
        set(hObject,'BackgroundColor','white');
    else
        set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
    end


% --- Executes on button press in Open.
function Open_Callback(hObject, eventdata, handles)
    % hObject    handle to Open (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global fig;
    global tmp_fig;
    fileName = get(handles.FileNameInput, 'String');
    fig = imread(fileName);
    tmp_fig=fig;
    axes(handles.Fig);
    imshow(fig);
    axes(handles.NewFig);
    imshow(tmp_fig);
    OperationName=strvcat('Open',fileName);
    set(handles.Test,'String', OperationName);


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
    % hObject    handle to Reset (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global fig;
    global tmp_fig;
    new_fig=fig;
    axes(handles.NewFig);
    imshow(new_fig);
    tmp_fig=new_fig;
    OperationName='Reset';
    set(handles.Test,'String', OperationName);


% --- Executes on button press in py.
function py_Callback(hObject, eventdata, handles)
    % hObject    handle to py (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global tmp_fig;
    [m,n]=size(tmp_fig);
    new_fig=ones(m,n)*255;
    para=get(handles.Parameter, 'String');
    dx=str2num(para); dy=dx;
    % T = [ 1 0 0; 0 1 0; dx dy 1 ];
    % pingyi = maketform('affine', T);
    % [new_fig xdata ydata]= imtransform(tmp_fig, pingyi);
    new_fig(dx+1:m,dy+1:n)=tmp_fig(1:m-dx,1:n-dy);
    new_fig=uint8(new_fig);
    axes(handles.NewFig);
    imshow(new_fig);
    tmp_fig=new_fig;
    OperationName=strvcat('Ping Yi',num2str(dx));
    set(handles.Test,'String', OperationName);



% --- Executes on button press in xz.
function xz_Callback(hObject, eventdata, handles)
    % hObject    handle to xz (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global tmp_fig;
    [m,n]=size(tmp_fig);
    new_fig=ones(m,n)*255;
    para=get(handles.Parameter, 'String');
    ang=str2num(para);
    T = [ cosd(ang) sind(ang) 0; -sind(ang) cosd(ang) 0; 0 0 1 ];
    xuanzhuan = maketform('affine', T);
    [new_fig xdata ydata]= imtransform(tmp_fig, xuanzhuan);
    % new_fig=imrotate(tmp_fig,ang);
    new_fig=uint8(new_fig);
    axes(handles.NewFig);
    imshow(new_fig);
    tmp_fig=new_fig;
    OperationName=strvcat('Xuan Zhuan',num2str(ang));
    set(handles.Test,'String', OperationName);


% --- Executes on button press in sf.
function sf_Callback(hObject, eventdata, handles)
    % hObject    handle to sf (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global tmp_fig;
    [m,n]=size(tmp_fig);
    new_fig=ones(m,n)*255;
    para=get(handles.Parameter, 'String');
    ratio=str2num(para);
    T = [ ratio 0 0; 0 ratio 0; 0 0 1 ];
    suofang = maketform('affine', T);
    [new_fig xdata ydata]= imtransform(tmp_fig, suofang);
    % new_fig=imresize(tmp_fig,ratio);
    new_fig=uint8(new_fig);
    axes(handles.NewFig);
    imshow(new_fig);
    tmp_fig=new_fig;
    OperationName=strvcat('Suo Fang',num2str(ratio));
    set(handles.Test,'String', OperationName);


% --- Executes on button press in jq.
function jq_Callback(hObject, eventdata, handles)
    % hObject    handle to jq (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global tmp_fig;
    [m,n]=size(tmp_fig);
    new_fig=ones(m,n)*255;
    new_fig=imcrop(tmp_fig); % drag mouse
    new_fig=uint8(new_fig);
    axes(handles.NewFig);
    imshow(uint8(new_fig));
    tmp_fig=new_fig;
    OperationName='Jian Qie';
    set(handles.Test,'String', OperationName);


% --- Executes on button press in ty.
function ty_Callback(hObject, eventdata, handles)
    % hObject    handle to ty (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global tmp_fig;
    [m,n]=size(tmp_fig);
    new_fig=ones(m,n)*255;
    T = [ 0.4788 0.0135 -0.0009; 0.0135 0.4788 -0.0009; 0.5059 0.5059 1 ];
    % T = [ -2.7390 0.2929 -0.6373; 0.7426 -0.7500 0.8088; 2.8750 0.7500 1 ];
    touying = maketform('projective', T);
    [new_fig xdata ydata]= imtransform(tmp_fig, touying);
    new_fig=uint8(new_fig);
    axes(handles.NewFig);
    imshow(new_fig);
    tmp_fig=new_fig;
    OperationName='Tou Ying';
    set(handles.Test,'String', OperationName);


% --- Executes on button press in fs.
function fs_Callback(hObject, eventdata, handles)
    % hObject    handle to fs (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global tmp_fig;
    [m,n]=size(tmp_fig);
    new_fig=ones(m,n)*255;
    T = [ 1 0 0; 0.5 1 0; 0 0 1 ];
    touying = maketform('affine', T);
    [new_fig xdata ydata]= imtransform(tmp_fig, touying);
    new_fig=uint8(new_fig);
    axes(handles.NewFig);
    imshow(new_fig);
    tmp_fig=new_fig;
    OperationName='Fang She';
    set(handles.Test,'String', OperationName);


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
    % hObject    handle to Save (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global tmp_fig;
    imwrite(tmp_fig, 'saved.jpg', 'jpg');
    OperationName='Save';
    set(handles.Test,'String', OperationName);

