function [P_f_r,y_r] = myofdm_receive(Rx_cd,P_f_station,data_station)
%MYOFDM_RECEIVE ����ofdm���������Ƶ������
%   �˴���ʾ��ϸ˵��[P_f_r,y_r] = myofdm_receive(Rx_cd,P_f_station,data_station)
%% �Ƴ�ѭ��ǰ׺
data_seq_R=Rx_cd(13:end);
%% FFT
fft_data=fft(data_seq_R); 
%% ��ȡ��Ƶ������
P_f_r=fft_data(P_f_station);
y_r=fft_data(data_station);

end

