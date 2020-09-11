function y = myqamde2(x,threshold)
%MQAM����myqamde2(x,db),��������ʽ���
%������ֻ֧��289QAM���,�ʾ�������ȫд
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

    
    
    
    
    
    
    
    
