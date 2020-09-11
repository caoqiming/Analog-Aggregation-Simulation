function threshold = mythreshold(N,SNR)
% threshold = mythreshold(N,SNR)
% 输入用户数和信噪比，输出最佳判决的临界值
pd=zeros(N+1,1);
for ii=0:N
    for jj=0:floor((N-ii)/2)
        pd(ii+1)=pd(ii+1)+nchoosek(N,ii+jj)*nchoosek(N-ii-jj,jj)*0.25^(ii+2*jj)*0.5^(N-ii-2*jj);
    end
end

threshold=zeros(N,1);
pn=0.5*8/10^(SNR*0.1);%噪声功率0.5是单个终端的功率，0.5*8是聚合信号的功率
for ii=1:N
    threshold(ii,1)=log(pd(ii)/pd(ii+1))*pn+0.5*(ii-1+ii);
end
end

