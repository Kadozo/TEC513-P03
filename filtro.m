
clear; close all; clc;

import signal.*;

% Lendo um arquivo de áudio
[y, Fs] = audioread('SinalRuidoso.wav');

% Calcula a duração do arquivo em segundos
audio_info = audioinfo('SinalRuidoso.wav');
duration = audio_info.TotalSamples / Fs;

% Plotando o sinal ruidoso no tempo
figure('Name','Sinal com Ruido no tempo');
f = (0:length(y)-1)*(duration)/length(y);
plot(f,y);
xlabel('Tempo (S)');
ylabel('Amplitude');
ylim([-3,3])
grid on

% Plotando o sinal ruidoso na frequência
Y = fft(y); 
%f = (0:length(Y)-1)*(Fs/length(Y));
fVals =(-length(Y)/2:length(Y)/2-1);
figure('Name','Sinal com Ruido na frequência'); 
plot(fVals,abs(fftshift(Y)));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
grid on;

% Iniciando o processo de filtragem

% Dados do Projeto ==============================
M = length(y); %Comprimento do Filtro
wc = 0.23; %Frequência de Corte Normalizada (f1+f2)/2
% ================================================
n = (0:M-1);

%w = (1-cos((2*pi*n)/(M-1)))'*0.5; %Janela de Hannning

%Passa-Baixas:
fc = 3000;
%Y_filtered = Y;
%Y_filtered((fc/Fs)*length(yw)+1:end-(fc/Fs)*length(yw)) = 0;
%y_filtered = ifft(Y_filtered);

wn = fc/(Fs/2);
aten_min = 3;
aten_max = 80;
[n, Wn] = buttord(wn, wn*1.5, aten_min, aten_max, 's');
[b, a] = butter(n, Wn);
y_filtered = filter(b, a, xt);

%Tocando o áudio
sound(y_filtered, Fs);