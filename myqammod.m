function y = myqammod(x)
%MQAMMOD �˴���ʾ�йش˺�����ժҪ
%����x�ķ�Χ{-1��0��1}��ÿ����x���һ��y
L=length(x);
Ly=floor(L/2);
y=zeros(1,Ly);
for ii=1:Ly
y(ii)=x(2*ii-1)+1i*x(2*ii);
end

if mod(L,2)~=0
    y=[y,x(end)];
end
