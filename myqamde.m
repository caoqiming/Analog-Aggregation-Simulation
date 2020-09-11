function y = myqamde(N,x)
%MQAM½âÂëmyqamde(N,x)
L=length(x);
y=zeros(2*L,1);
for ii=1:L
y(2*ii-1)=round(real(x(ii)));
y(2*ii)=round(imag(x(ii)));
if abs(y(2*ii-1))>N
    y(2*ii-1)=sign(y(2*ii-1))*N;
end
if abs(y(2*ii))>N
    y(2*ii)=sign(y(2*ii))*N;
end
end
end
