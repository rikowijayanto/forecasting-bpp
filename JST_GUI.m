function varargout = JST_GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JST_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @JST_GUI_OutputFcn, ...
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


% --- Executes just before JST_GUI is made visible.
function JST_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
clc;
handles.output = hObject;
handles.output = hObject;
axes(handles.gambar)
imshow('logoits.png')
axes(handles.logomat)
imshow('logomat.png')
axes(handles.logobps)
imshow('logobps.png')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JST_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = JST_GUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function epoch_Callback(hObject, eventdata, handles)

function epoch_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function error_Callback(hObject, eventdata, handles)

function error_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)


function mse_uji_Callback(hObject, eventdata, handles)
function mse_uji_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in latih_tombol.
function latih_tombol_Callback(hObject, eventdata, handles)


% Membaca data latih dari excel
filename = 'database.xlsx';
sheet = 2;
xlRange = 'B5:K16';
 
Data = xlsread(filename, sheet, xlRange);
data_latih = Data(:,1:9)';
target_latih = Data(:,10)';
[m,n] = size(data_latih);
 
% Pembuatan JST

layer = str2double(get(handles.hidden,'String'));
net = newff(minmax(data_latih),[layer 1],{'logsig','purelin'},'traingdx');

filename = 'database.xlsx';
sheet = 3;
xlRange = 'A4:B243';

date = xlsread(filename, sheet, xlRange);
x = date(:,1)';
y = date(:,2)';
axes(handles.series)
plot(x,y)
grid on
xlabel('Data ke-')
ylabel('Jumlah Wisatawan')

% Memberikan nilai untuk mempengaruhi proses pelatihan
error = str2double(get(handles.edit_error,'String'));
iterasi = str2double(get(handles.edit_iterasi,'String'));
learning = str2double(get(handles.rate,'String'));


net.performFcn = 'mse';
net.trainParam.goal = error;
net.trainParam.show = 20;
net.trainParam.epochs = iterasi;
net.trainParam.mc = 0.95;
net.trainParam.lr = learning;

% Proses training
[net_keluaran,tr,Y,E] = train(net,data_latih,target_latih);

% Hasil setelah pelatihan
bobot_hidden = net_keluaran.IW{1,1};
bobot_keluaran = net_keluaran.LW{2,1};
bias_hidden = net_keluaran.b{1,1};
bias_keluaran = net_keluaran.b{2,1};
jumlah_iterasi = tr.num_epochs;
nilai_keluaran = Y;
nilai_error = E;
error_MSE = (1/n)*sum(nilai_error.^2);

save net.mat net_keluaran
save not.mat tr



% Hasil prediksi
hasil_latih = sim(net_keluaran,data_latih);
max_data = 519615;
min_data = 249491;
hasil_latih = (hasil_latih*(max_data-min_data))+min_data;
xlswrite('hasil latih',hasil_latih);

% Performansi hasil prediksi
filename = 'database.xlsx';
sheet = 3;
xlRange = 'E4:P4';

%Memasukkan data hasil training ke kotak
set(handles.iterasi_hasil,'String',jumlah_iterasi)
set(handles.error_hasil,'String',error_MSE)

target_latih_asli = xlsread(filename, sheet, xlRange); 


%Plot rasio ramalan dan aktual
axes(handles.rasio1)
plot(hasil_latih,'b.-')
hold on
plot(target_latih_asli,'r.-')
hold off
grid on
xlabel('Data ke-')
ylabel('Jumlah Wisatawan')
legend('Peramalan','Aktual','Location','Best')




function edit8_Callback(hObject, eventdata, handles)

function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hasil_iterasi_Callback(hObject, eventdata, handles)

function hasil_iterasi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hasil_error_Callback(hObject, eventdata, handles)
% hObject    handle to hasil_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hasil_error as text
%        str2double(get(hObject,'String')) returns contents of hasil_error as a double


% --- Executes during object creation, after setting all properties.
function hasil_error_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hasil_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function gambar_CreateFcn(hObject, eventdata, handles)


% Hint: place code in OpeningFcn to populate gambar


% --- Executes on button press in uji_tombol.
function uji_tombol_Callback(hObject, eventdata, handles)
 
% load jaringan yang sudah dibuat pada proses pelatihan
load net.mat
 
% Proses membaca data uji dari excel
filename = 'database.xlsx';
sheet = 2;
xlRange = 'B22:K33';
 
Data = xlsread(filename, sheet, xlRange);
data_uji = Data(:,1:9)';
target_uji = Data(:,10)';
[m,n] = size(data_uji);
 
% Hasil prediksi
hasil_uji = sim(net_keluaran,data_uji);
nilai_error = hasil_uji-target_uji;


max_data = 1190865;
min_data = 421555;
hasil_uji = (hasil_uji*(max_data-min_data))+min_data;
xlswrite('hasil uji',hasil_uji);
 
% Performansi hasil prediksi
error_MSE = (1/n)*sum(nilai_error.^2);
 
filename = 'database.xlsx';
sheet = 3;
xlRange = 'E6:P6';
 
target_uji_asli = xlsread(filename, sheet, xlRange);
set(handles.error_uji,'String',error_MSE)

%figure,
axes(handles.rasio3)
plot(hasil_uji,'b.-')
hold on
plot(target_uji_asli,'r.-')
hold off
grid on
%title(strcat(['Grafik Keluaran JST vs Target dengan nilai MSE = ',...
num2str(error_MSE);
xlabel('Data ke-')
ylabel('Jumlah Wisatawan')
legend('Peramalan','Aktual','Location','Best')



function edit_iterasi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iterasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iterasi as text
%        str2double(get(hObject,'String')) returns contents of edit_iterasi as a double


% --- Executes during object creation, after setting all properties.
function edit_iterasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iterasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_error_Callback(hObject, eventdata, handles)
% hObject    handle to edit_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_error as text
%        str2double(get(hObject,'String')) returns contents of edit_error as a double


% --- Executes during object creation, after setting all properties.
function edit_error_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in latih_tombol.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to latih_tombol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function iterasi_hasil_Callback(hObject, eventdata, handles)
% hObject    handle to iterasi_hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterasi_hasil as text
%        str2double(get(hObject,'String')) returns contents of iterasi_hasil as a double


% --- Executes during object creation, after setting all properties.
function iterasi_hasil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterasi_hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function error_hasil_Callback(hObject, eventdata, handles)
% hObject    handle to error_hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of error_hasil as text
%        str2double(get(hObject,'String')) returns contents of error_hasil as a double


% --- Executes during object creation, after setting all properties.
function error_hasil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to error_hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function error_uji_Callback(hObject, eventdata, handles)
% hObject    handle to error_uji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of error_uji as text
%        str2double(get(hObject,'String')) returns contents of error_uji as a double


% --- Executes during object creation, after setting all properties.
function error_uji_CreateFcn(hObject, eventdata, handles)
% hObject    handle to error_uji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in uji_tombol.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to uji_tombol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function rate_Callback(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rate as text
%        str2double(get(hObject,'String')) returns contents of rate as a double


% --- Executes during object creation, after setting all properties.
function rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hidden_Callback(hObject, eventdata, handles)
% hObject    handle to hidden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hidden as text
%        str2double(get(hObject,'String')) returns contents of hidden as a double


% --- Executes during object creation, after setting all properties.
function hidden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hidden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function regresi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to regresi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate regresi


% --- Executes on button press in perform.
function perform_Callback(hObject, eventdata, handles)
load not.mat
figure,
plotperform(tr);


% --- Executes on button press in regresi.
function regresi_Callback(hObject, eventdata, handles)
filename = 'database.xlsx';
sheet = 2;
xlRange = 'B5:K16';
 
Data = xlsread(filename, sheet, xlRange);
data_latih = Data(:,1:9)';

load net.mat

filename = 'database.xlsx';
sheet = 3;
xlRange = 'E4:P4';

hasil_latih = sim(net_keluaran,data_latih);

max_data = 519615;
min_data = 249491;
hasil_latih = (hasil_latih*(max_data-min_data))+min_data;


target_latih_asli = xlsread(filename, sheet, xlRange); 

figure,
plotregression(target_latih_asli,hasil_latih,'Regression') 


% --- Executes on button press in state.
function state_Callback(hObject, eventdata, handles)
load not.mat
figure,
plottrainstate(tr)


% --- Executes on button press in ramal.
function ramal_Callback(hObject, eventdata, handles)
% load jaringan yang sudah dibuat pada proses pelatihan
load net.mat
 
% Proses membaca data uji dari excel
filename = 'database.xlsx';
sheet = 2;
xlRange = 'B38:U49';
 
Data = xlsread(filename, sheet, xlRange);
data_uji = Data(:,1:20)';
[m,n] = size(data_uji);
 
% Hasil prediksi
hasil_uji = sim(net_keluaran,data_uji);


max_data = 1190865;
min_data = 249491;
hasil_uji = (hasil_uji*(max_data-min_data))+min_data;
xlswrite('hasil ramal',hasil_uji);


%figure,
axes(handles.ramalan)
plot(hasil_uji,'b.-')
grid on
xlabel('Data ke-')
ylabel('Jumlah Wisatawan')
legend('Peramalan','Aktual','Location','Best')



% --- Executes on button press in reset.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
