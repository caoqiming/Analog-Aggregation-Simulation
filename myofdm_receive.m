function [P_f_r,y_r] = myofdm_receive(Rx_cd,P_f_station,data_station)
%MYOFDM_RECEIVE 输入ofdm符号输出导频和数据
%   此处显示详细说明[P_f_r,y_r] = myofdm_receive(Rx_cd,P_f_station,data_station)
%% 移除循环前缀
data_seq_R=Rx_cd(13:end);
%% FFT
fft_data=fft(data_seq_R); 
%% 提取导频和数据
P_f_r=fft_data(P_f_station);
y_r=fft_data(data_station);

end

