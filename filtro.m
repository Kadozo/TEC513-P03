clear; close all; clc;
import signal.*;
load handel.mat

%Lendo o Sinal Ruidoso
[y, Fs] = audioread('SinalRuidoso.wav');

%Calculando a duração do arquivo em segundos
audio_info = audioinfo('SinalRuidoso.wav');
duration = audio_info.TotalSamples / Fs;

%Plotando o sinal ruidoso no tempo
figure('Name','Sinal Ruidoso no tempo');
f = (0:length(y)-1)*(duration)/length(y);
plot(f,y);
xlabel('Tempo(s)');
ylabel('Amplitude');
ylim([-2,2])
grid on

%Plotando o sinal ruidoso na frequÃªncia
Y = fft(y); 
fVals =(-length(Y)/2:length(Y)/2-1);
figure('Name','Sinal com ruido na frequencia'); 
func_plotter_freq("$f$(Hz)", "Magnitude", "Espectro do sinal com ruido na frequencia", Y', Fs, fVals);
grid on;

%Iniciando o processo de filtragem======================

%Definir parametros do filtro
fr = 4000;%Frequencia de rejeicao
fa = 2600;%Frequencia de atenuacao
ft = fr - fa;%Frequencia de transicao
fc = (fr+fa)/2;%Frequencia de corte

wan = 8*pi*fa/Fs;%Frequencia de atenuacao normalizada
wrn = 8*pi*fr/Fs;%Frequencia de rejeicao normalizada
wtn = 8*pi*ft/Fs;%Frequencia de transicao normalizada
wcn = 8*pi*fc/Fs; %Frequencia de corte normalizada
M = ceil(8*pi/wtn); % Comprimento do filtro
N = M-1; % Ordem do filtro
ideal_lp = wcn * sinc(wcn.*((0:N)-N/2));%Passa-baixas
w = 0.54 - 0.46*cos(2*pi.*(0:N)/N); %Janela de Hamming
h = ideal_lp .* w;

%Filtrando o sinal======================================
%Convolução entre o sinal no domínio no tempo e o filtro
y_filtered = conv(h,y);

%Plotando o sinal filtrado no tempo
figure('Name','Sinal filtrado no tempo');
f = (0:length(y_filtered)-1)*(duration)/length(y_filtered);
plot(f, y_filtered);
ylim([-2,2]);
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

%Plotando o sinal filtrado na frequência
Y_filtered = fft(y_filtered);
figure('Name','Sinal Filtrado na frequência');
func_plotter_freq("$f$(Hz)", "Magnitude", "Espectro do sinal de entrada filtrado", Y_filtered', Fs, fVals);
grid on;

%Gerando espectograma do sinal==========================
figure('Name','Espectograma do Sinal Ruidoso');
%spectrogram(y, 'yaxis');
grid on;

figure('Name','Espectograma do Sinal Filtrado');
%spectrogram(y_filtered,'yaxis');
grid on;

%Tocando o audio
sound(y_filtered, Fs);