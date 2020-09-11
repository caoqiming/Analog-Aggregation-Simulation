function y = myqamde2(x,threshold)
%MQAM解码myqamde2(x,db),最大后验概率解码
%本函数只支持289QAM解调,问就是懒得全写
L=length(x);
y=zeros(2*L,1);
N=length(threshold);


for ii=1:L
    y_real_s=sign(real(x(ii)));
    y_imag_s=sign(imag(x(ii)));
    y_real_a=abs(real(x(ii)));
    y_imag_a=abs(imag(x(ii)));
    y(2*ii-1)=y_real_s*N;
    y(2*ii)=y_imag_s*N;
    for jj=1:N
        
        if(y_real_a<threshold(jj))
            y(2*ii-1)=y_real_s*(jj-1);
            break
        end
    end
    for jj=1:N
        if(y_imag_a<threshold(jj))
            y(2*ii)=y_imag_s*(jj-1);
            break
        end
    end
    
end

    
    
    
    
    
    
    
    
