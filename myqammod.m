function y = myqammod(x)
%MQAMMOD 此处显示有关此函数的摘要
%输入x的范围{-1，0，1}，每两个x输出一个y
L=length(x);
Ly=floor(L/2);
y=zeros(1,Ly);
for ii=1:Ly
y(ii)=x(2*ii-1)+1i*x(2*ii);
end

if mod(L,2)~=0
    y=[y,x(end)];
end
