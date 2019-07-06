function varargout = Jiang(varargin)

%global I;
%global J;
%global K;
% JIANG MATLAB code for Jiang.fig
%      JIANG, by itself, creates a new JIANG or raises the existing
%      singleton*.
%
%      H = JIANG returns the handle to a new JIANG or the handle to
%      the existing singleton*.
%
%      JIANG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JIANG.M with the given input arguments.
%
%      JIANG('Property','Value',...) creates a new JIANG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Jiang_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Jiang_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Jiang

% Last Modified by GUIDE v2.5 30-Dec-2018 19:38:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Jiang_OpeningFcn, ...
                   'gui_OutputFcn',  @Jiang_OutputFcn, ...
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


% --- Executes just before Jiang is made visible.
function Jiang_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Jiang (see VARARGIN)

% Choose default command line output for Jiang
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Jiang wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Jiang_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[file,path] = uigetfile({'*.jpg';'*.png'});
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end
   filePath = [path ,file];
   global I;
   I = imread(filePath);
   axes(handles.original);
   imshow(I);
   title(date,'color','r');
   
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)

% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
   %[file,path] = uigetfile('*.jpg');
   %I1 = imnoise(I,'gaussian',0,0.01);
   %I = imread('C:\Users\Administrator\Documents\MATLAB\1.jpg');
   global I;
   global J;
   global K;
   % J = imnoise(I,'gaussian',0,0.001);
   % K = imnoise(I,'gaussian',0,0.005);
   J = imnoise(I,'salt & pepper');
   K = imnoise(I,'salt & pepper');
   axes(handles.addnoise1);
   imshow(J);
   title([date,'  σ1=0.001'],'color','r');
   
   axes(handles.addnoise2);
   imshow(K);
   title([date,'  σ2=0.005'],'color','r');
 
   %global J;
   %global K;
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
method = get(handles.method,'value');
%global I;
global J;
global resultJ;
if method == 2
    resultJ = median_filter(J,3);
    axes(handles.denoise1);
    imshow(resultJ);
    title(date,'color','r');
    msgbox('meidian filter finished', 'tip');
else if method == 3
        d = 1;
        sigma = [3 0.1];
        J = double(J)/255;
        J(J<0) = 0; J(J>1) = 1;
        resultJ = BilateralFilt2(double(J), d, sigma);
        axes(handles.denoise1);
        imshow(resultJ);
        title(date,'color','r');
        %figure, imshow(resultI,[])
        %title('双边滤波后的图像')
else if method == 4
       % Read an RGB image and scale its intensities in range [0,1]
       %yRGB = im2double(imread('image_House256rgb.png')); 
%      % Generate the same seed used in the experimental results of [1]
       randn('seed', 0);
%      % Standard deviation of the noise --- corresponding to intensity 
%      %  range [0,255], despite that the input was scaled in [0,1]
      sigma = 25;
%      % Add the AWGN with zero mean and standard deviation 'sigma'
      %zRGB = yRGB + (sigma/255)*randn(size(yRGB));
%      % Denoise 'zRGB'. The denoised image is 'yRGB_est', and 'NA = 1'  
%      %  because the true image was not provided
      temp = im2double(J);
      [NA, resultJ] = CBM3D(1, temp, sigma); 
%      % Compute the putput PSNR
      %PSNR = 10*log10(1/mean((yRGB(:)-yRGB_est(:)).^2))
%      % show the noisy image 'zRGB' and the denoised 'yRGB_est'
%      figure; imshow(min(max(zRGB,0),1));   
%      figure; imshow(min(max(yRGB_est,0),1));
       resultJ = min(max(resultJ,0),1);
       axes(handles.denoise1);
       imshow(resultJ);
       title(date,'color','r');
       msgbox('bm3d filter finished', 'tip');
    else
        msgbox('Please import image and set denoised method', 'warning');
     
end
end
end




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
method = get(handles.method,'value');
%global I;
global K;
global resultK;
if method == 2
    %imshow(I);
    resultK = median_filter(K,3);
    axes(handles.denoise2);
    imshow(resultK);
    title(date,'color','r');
    msgbox('meidian filter finished', 'tip');
else if method == 3
        %imshow(J);
        d = 1;
        sigma = [3 0.1];
        K = double(K)/255;
        K(K<0) = 0; K(K>1) = 1;
        resultK = BilateralFilt2(double(K), d, sigma);
        axes(handles.denoise2);
        imshow(resultK);
        title(date,'color','r');
        %figure, imshow(resultI,[])
        %title('双边滤波后的图像')
else if method == 4
  % Read an RGB image and scale its intensities in range [0,1]
       %yRGB = im2double(imread('image_House256rgb.png')); 
%      % Generate the same seed used in the experimental results of [1]
       randn('seed', 0);
%      % Standard deviation of the noise --- corresponding to intensity 
%      %  range [0,255], despite that the input was scaled in [0,1]
      sigma = 25;
%      % Add the AWGN with zero mean and standard deviation 'sigma'
      %zRGB = yRGB + (sigma/255)*randn(size(yRGB));
%      % Denoise 'zRGB'. The denoised image is 'yRGB_est', and 'NA = 1'  
%      %  because the true image was not provided
      temp = im2double(K);
      [NA, resultK] = CBM3D(1, temp, sigma); 
%      % Compute the putput PSNR
      %PSNR = 10*log10(1/mean((yRGB(:)-yRGB_est(:)).^2))
%      % show the noisy image 'zRGB' and the denoised 'yRGB_est'
%      figure; imshow(min(max(zRGB,0),1));   
%      figure; imshow(min(max(yRGB_est,0),1));
       resultK = min(max(resultK,0),1);
       axes(handles.denoise2);
       imshow(resultK);
       title(date,'color','r');
       msgbox('meidian filter finished', 'tip');
    else
        msgbox('Please import image and set denoised method', 'warning');
    end
    end
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global J;
global resultJ;
%set(handles.text1,'string','床前明月光，','FontSize',12);
J = im2uint8(J);
[psnrIAndJ,snr] = psnr(I,J);
set(handles.text1,'string',['original and noise image PSNR：',num2str(psnrIAndJ)],'FontSize',12);
temp = im2uint8(resultJ);
[psnrIAndResultJ,snr] = psnr(I,temp); 
set(handles.text2,'string',['denoised and original image PSNR：',num2str(psnrIAndResultJ)],'FontSize',12);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global K;
global resultK;
K = im2uint8(K);
%set(handles.text1,'string','床前明月光，','FontSize',12);
[psnrIAndK,snr] = psnr(I,K);
set(handles.text3,'string',['original and noise image PSNR：',num2str(psnrIAndK)],'FontSize',12);
temp = im2uint8(resultK);
[psnrIAndResultK,snr] = psnr(I,temp); 
set(handles.text4,'string',['denoised and original image PSNR：',num2str(psnrIAndResultK)],'FontSize',12);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resultJ;
imwrite(resultJ,'resultJ.jpg');
msgbox('save success!', 'tip');

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resultK;
imwrite(resultK,'resultK.jpg');
msgbox('save success!', 'tip');

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J;
imwrite(J,'J.jpg');
msgbox('save success!', 'tip');

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global K;
imwrite(K,'K.jpg');
msgbox('save success!', 'tip');
