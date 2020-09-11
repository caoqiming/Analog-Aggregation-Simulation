function y = myrandfloatbit(N_data)
%MYRANDFLOATBIT 以概率0.25，0.5，0.25生成-1，0，1，形状为（1*N_data）
%  y = myrandfloatbit(N_data)
y=randi([-1,2],1,N_data);
for ii =1:N_data
    if(y(ii)==2)
        y(ii)=0;
    end
end
end

