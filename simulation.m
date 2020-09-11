clc;
clear;
%% ��������
N=8;%�û��� �����޸�������55 75 
N_sc=48;      %Я���źŵ����ز���
N_fft=64;            % FFT ����
N_cp=12;             % ѭ��ǰ׺����
N_symbo=N_fft+N_cp;        % 1������OFDM���ų���
SNR=10:30;         %���������
err_rate_history=zeros(1,length(SNR));
err_rate_history2=zeros(1,length(SNR));
Nd=50000;               %OFDM������
P_f=1+1i;            %��Ƶ
P_f_station=[8,22,44,58];%��Ƶλ��
data_station=[2:7,9:21,23:27,39:43,45:57,59:64];%������64ifft�е�λ��
stage = 3;          % m���еĽ���
ptap1 = [1 3];      % m���еļĴ������ӷ�ʽ
regi1 = [1 1 1];    % m���еļĴ�����ʼֵ
N_data=2*N_sc*Nd;%ÿ���û�������������
x_decode=zeros(N_data,1);%������Ž���֮������� ��ѽ���
x_decode2=zeros(N_data,1);%��ͨ����
y_rr_history=zeros(1,Nd*N_sc);
%% �����������ݲ���
x1=myrandfloatbit(N_data);
x2=myrandfloatbit(N_data);
x3=myrandfloatbit(N_data);
x4=myrandfloatbit(N_data);
x5=myrandfloatbit(N_data);
x6=myrandfloatbit(N_data);
x7=myrandfloatbit(N_data);
x8=myrandfloatbit(N_data);
%% 9QAM����
y1=myqammod(x1);
y2=myqammod(x2);
y3=myqammod(x3);
y4=myqammod(x4);
y5=myqammod(x5);
y6=myqammod(x6);
y7=myqammod(x7);
y8=myqammod(x8);
%% ofdm�����ź�

for jj=1:length(SNR)
    threshold = mythreshold(N,SNR(jj));
    for runtime=1:Nd
        Tx_cd1=myofdm_send(y1,P_f,P_f_station,data_station,runtime);
        Tx_cd2=myofdm_send(y2,P_f,P_f_station,data_station,runtime);
        Tx_cd3=myofdm_send(y3,P_f,P_f_station,data_station,runtime);
        Tx_cd4=myofdm_send(y4,P_f,P_f_station,data_station,runtime);
        Tx_cd5=myofdm_send(y5,P_f,P_f_station,data_station,runtime);
        Tx_cd6=myofdm_send(y6,P_f,P_f_station,data_station,runtime);
        Tx_cd7=myofdm_send(y7,P_f,P_f_station,data_station,runtime);
        Tx_cd8=myofdm_send(y7,P_f,P_f_station,data_station,runtime);
        
        
        %% �ŵ����źž��������ŵ���
        Tx_cd=Tx_cd1+Tx_cd2+Tx_cd3+Tx_cd4+Tx_cd5+Tx_cd6+Tx_cd7+Tx_cd8;
        Tx_cd=awgn(Tx_cd,SNR(jj),10*log10(2*0.5*N/N_fft));%��Ӹ�˹������ �������������źŹ���dbw��ofdm����ǰ����Ϊ0.5����Ϊ��������*2��ifft���ʳ��Գ���
        rchan = comm.RayleighChannel('PathDelays',[0 2 4 8],'AveragePathGains',[0 -100 -200 -300],'MaximumDopplerShift',1e-5);
        Rx_cd=rchan(Tx_cd.');
        %% ofdm�����ź�
        [P_f_r,y_r] = myofdm_receive(Rx_cd,P_f_station,data_station);
        %% �ŵ����������
        a_change=abs(P_f_r)/abs(N*P_f);
        p_change=P_f_r/(N*P_f)./a_change;%e^i*sita2
        a_change_data=interp1( P_f_station,a_change.',data_station,'linear');%���ݲ��ַ��ȱ仯�Ĳ�ֵ
        p_change_data=interp1( P_f_station,p_change.',data_station,'linear');%���ݲ�����λ�仯�Ĳ�ֵ
        y_rr=zeros(1,48);
        y_rr(7:42)=y_r(7:42).'./a_change_data(7:42)./p_change_data(7:42);%���յ������ݽ��н���
        y_rr(1:6)=y_r(1:6).'/a_change(1)/p_change(1);
        y_rr(43:48)=y_r(43:48).'/a_change(4)/p_change(4);
        y_rr_history((runtime-1)*N_sc+1:runtime*N_sc)=y_rr;
        %% MQAM���
        x_decode((runtime-1)*2*N_sc+1:runtime*2*N_sc) =myqamde2(y_rr.',threshold);
        x_decode2((runtime-1)*2*N_sc+1:runtime*2*N_sc) =myqamde(N,y_rr.'); 
    end
    right_x=(x1+x2+x3+x4+x5+x6+x7+x8).';
    check=[right_x,x_decode];
    check2=[right_x,x_decode2];
    
    scatterplot(y_rr_history.'),grid;
    err=0;
    err2=0;
    for ii=1:N_data
        if(check(ii,1)~=check(ii,2))
            err=err+1;
        end
        if(check2(ii,1)~=check2(ii,2))
            err2=err2+1;
        end
    end
    err_rate=err/N_data;
    err_rate_history(1,jj)=err_rate;
    err_rate2=err2/N_data;
    err_rate_history2(1,jj)=err_rate2;
end

figure
semilogy(SNR,err_rate_history,'b-s');
hold on;
semilogy(SNR,err_rate_history2,'g-s');
