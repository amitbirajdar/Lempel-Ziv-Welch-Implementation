function [d_new,n] = update_dict(element,dictionary)

n = numel(dictionary);          
d_new = [dictionary ; element]; 

end
