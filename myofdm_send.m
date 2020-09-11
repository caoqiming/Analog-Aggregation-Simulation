function Tx_cd = myofdm_send(data,P_f,P_f_station,data_station,runtime)
%MYOFDM_SEND myofdm_send(data,P_f,P_f_station,data_station)
%   输入mqam符号，输出ofdm符号
%% 插入导频
data_seq=zeros(1,64);
for ii=1:4        
    data_seq(1,P_f_station(ii))=P_f;%插入导频
end
for ii=1:48        
    data_seq(1,data_station(ii))=data(ii+(runtime-1)*48);%插入数据
end

%% IFFT
ifft_data=ifft(data_seq); 

%% 插入循环前缀
Tx_cd=[ifft_data(53:end),ifft_data];%把ifft的末尾12个数补充到最前面
end

