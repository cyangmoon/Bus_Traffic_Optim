%越界处理
function is_in_domain = domain_limit(x)

    global y_kj_all;

    is_in_domain = 1;
    for j=1:66
        a=0;
        if j~=53
            for k=1:13
               a=a+x(k)*y_kj_all(k,j);
            end
            if a>1
               is_in_domain = 0;
               return;
            end
        end
    end
end
