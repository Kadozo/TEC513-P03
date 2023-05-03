function func_plotter_freq(xxlabel, yylabel, ttitle, funcFreq, Fs, t) 
  yaux=fliplr(funcFreq(1,2:end));
  X=[yaux funcFreq];
  faixa=ceil(length(X)/4);
  X(1,1:faixa)=0;
  X(1,3*faixa:end)=0;
  length(X);
  omega=0:Fs/length(funcFreq):Fs-(Fs/length(funcFreq));
  waux=-fliplr(omega(1,2:end));
  w=[waux omega];
  length(w);
  plot(w,abs(X/length(t))); grid on;
  xlabel(xxlabel,'interpreter','latex');
  ylabel(yylabel);
  title(ttitle,'interpreter','latex');
end