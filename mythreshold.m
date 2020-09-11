function threshold = mythreshold(N,SNR)
% threshold = mythreshold(N,SNR)
% �����û���������ȣ��������о����ٽ�ֵ
pd=zeros(N+1,1);
for ii=0:N
    for jj=0:floor((N-ii)/2)
        pd(ii+1)=pd(ii+1)+nchoosek(N,ii+jj)*nchoosek(N-ii-jj,jj)*0.25^(ii+2*jj)*0.5^(N-ii-2*jj);
    end
end

threshold=zeros(N,1);
pn=0.5*8/10^(SNR*0.1);%��������0.5�ǵ����ն˵Ĺ��ʣ�0.5*8�Ǿۺ��źŵĹ���
for ii=1:N
    threshold(ii,1)=log(pd(ii)/pd(ii+1))*pn+0.5*(ii-1+ii);
end
end

