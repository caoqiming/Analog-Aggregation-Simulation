function Tx_cd = myofdm_send(data,P_f,P_f_station,data_station,runtime)
%MYOFDM_SEND myofdm_send(data,P_f,P_f_station,data_station)
%   ����mqam���ţ����ofdm����
%% ���뵼Ƶ
data_seq=zeros(1,64);
for ii=1:4        
    data_seq(1,P_f_station(ii))=P_f;%���뵼Ƶ
end
for ii=1:48        
    data_seq(1,data_station(ii))=data(ii+(runtime-1)*48);%��������
end

%% IFFT
ifft_data=ifft(data_seq); 

%% ����ѭ��ǰ׺
Tx_cd=[ifft_data(53:end),ifft_data];%��ifft��ĩβ12�������䵽��ǰ��
end

