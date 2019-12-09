function [r,code] = check_dict(current,next,dictionary)
n_dict = numel(dictionary); 
concat = [current ; next];  
r = 0;
code = -1;

for i=1:n_dict
    
    e = dictionary{i};
    
 
    if numel(concat) == numel(e)
        if concat == e
            code = i-1;
            r = 1;
            return;
        end
        
        
   
    elseif numel(current) == numel(e)
        if current == e
            code = i-1;
        end
    end
end

end
