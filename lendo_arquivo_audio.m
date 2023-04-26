% Lendo um arquivo de áudio
[y, Fs] = audioread('SinalRuidoso.wav');
audio_info = audioinfo('SinalRuidoso.wav');
% Calcula a duração do arquivo em segundos
duration = audio_info.TotalSamples / Fs;

Y = fft(y);
figure('Name','Sinal com Ruido no tempo');
f = (0:length(y)-1)*(duration)/length(y); % vetor de frequências
plot(f,y); % Plotando
xlabel('Tempo (S)'); % adiciona rótulo ao eixo y
ylabel('Amplitude'); % adiciona rótulo ao eixo y



figure('Name','Sinal com Ruido na frequência'); 
plot(abs(Y)); % traça o espectro de frequência
xlabel('Frequência (Hz)'); % adiciona rótulo ao eixo x
ylabel('Magnitude'); % adiciona rótulo ao eixo y


% Tocando o áudio
%sound(y, Fs);