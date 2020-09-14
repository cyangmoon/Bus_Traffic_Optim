function Offspring = Cross_mutation(MatingPool)

global ProC;
global ProM;
global num_flag;

% 交叉,变异并生成新的种群
% 输入: MatingPool,   交配池, 其中每第i个和第i+1个个体交叉产生两个子代, i为奇数
% 输出: Offspring, 产生的子代新种群

num_p = size(MatingPool,1);

%交叉
pair = randperm(num_p);
for i=1:num_p/2
    ii=2*i-1;
    if rand()<ProC
        aa=0;
        bb=0;
        aa = find(MatingPool(pair(ii),:)==1);
        bb = find(MatingPool(pair(ii+1),:)==1);
        if aa(1)~=bb(2) && aa(2)~=bb(1)
            temp_crooss_1 = false(1,13);
            temp_crooss_2 = false(1,13);
            temp_crooss_1(aa(1))=1;
            temp_crooss_1(bb(2))=1;
            temp_crooss_2(aa(2))=1;
            temp_crooss_2(bb(1))=1;
            if num_flag==3
                temp_crooss_1(aa(3))=1;
                temp_crooss_2(bb(3))=1;
            end
            MatingPool(pair(ii),:) = temp_crooss_1;
            MatingPool(pair(ii+1),:) = temp_crooss_2;
        elseif aa(1)==bb(2) && aa(2)~=bb(1)
            MatingPool(pair(ii),aa(1))=0;
            MatingPool(pair(ii),bb(1))=1;            
            temp_x = false(1,13);
            temp_x(randperm(13,num_flag))=1;
            while domain_limit(temp_x)==0
                temp_x = false(1,13);
                temp_x(randperm(13,num_flag))=1;
            end
            MatingPool(pair(ii+1),:)=temp_x;            
        else
            MatingPool(pair(ii),aa(2))=0;
            MatingPool(pair(ii),bb(2))=1;            
            temp_x = false(1,13);
            temp_x(randperm(13,num_flag))=1;
            while domain_limit(temp_x)==0
                temp_x = false(1,13);
                temp_x(randperm(13,num_flag))=1;
            end
            MatingPool(pair(ii+1),:)=temp_x;  
        end
        
        for j=ii:ii+1
            if domain_limit(MatingPool(pair(j),:))==0
                temp_x = false(1,13);
                temp_x(randperm(13,num_flag))=1;
                while domain_limit(temp_x)==0
                    temp_x = false(1,13);
                    temp_x(randperm(13,num_flag))=1;
                end
                MatingPool(pair(j),:) = temp_x;
            end
        end
    end
end


%变异
for i=1:num_p
    if rand()<ProM
        while domain_limit(MatingPool(i,:))==0

            cc = find(MatingPool(i,:)==1);
            mutation_point = randperm(13,1);
            while ~isempty(find(cc==mutation_point,1))
                mutation_point = randperm(13,1);
            end
            ee=cc(randperm(num_flag,1));
            MatingPool(i,ee)=0;
            MatingPool(i,mutation_point)=1;
        end

    end

end

Offspring =MatingPool;
end