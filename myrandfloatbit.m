function y = myrandfloatbit(N_data)
%MYRANDFLOATBIT �Ը���0.25��0.5��0.25����-1��0��1����״Ϊ��1*N_data��
%  y = myrandfloatbit(N_data)
y=randi([-1,2],1,N_data);
for ii =1:N_data
    if(y(ii)==2)
        y(ii)=0;
    end
end
end

