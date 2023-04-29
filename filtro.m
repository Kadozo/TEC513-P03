
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
%M = length(y); %Comprimento do Filtro
%wc = 0.23; %Frequência de Corte Normalizada (f1+f2)/2
% ================================================
%n = (0:M-1);

%w = (1-cos((2*pi*n)/(M-1)))'*0.5; %Janela de Hannning

%Passa-Baixas:
fc = 3000;

% % Definir parâmetros do filtro
N = 23; % Comprimento do filtro

w = 0.54 - 0.46*cos(2*pi*(0:N-1)/(N-1));

% Filtro passa-baixas ideal, se conseguir usando a sinc o código fica mais
% bonito
ideal_lp = 2*fc/Fs * (sin(pi*(2*fc/Fs*(-(N-1)/2:(N-1)/2))) / (pi*(2*fc/Fs*(-(N-1)/2:(N-1)/2))));

h = ideal_lp .* w';

h = h / sum(h);

y_filtered = filter(h, 1, y);

%Tocando o áudio
sound(y_filtered, Fs);