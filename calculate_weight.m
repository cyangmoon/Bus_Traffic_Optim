function weight_output = calculate_weight(normalized_value)
%UNTITLED2 此处显示有关此函数的摘要
%   weight_output  输出权重值
%   normalized_value    输入归一化的矩阵

f = (1+normalized_value)./repmat(sum(1+normalized_value),size(normalized_value,1),1);
H = -sum(f.*log(f))./log(size(f,1));
weight_output = (1-H)./sum(1-H);
end

