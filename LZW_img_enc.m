function [enc_img,dictionary] = LZW_img_enc(img)
dictionary{1} = 0;        
dictionary{2} = 1;        
dictionary = dictionary'; 

n_img = numel(img);       
enc_bits = numel(de2bi(numel(dictionary) - 1));

n = 1;        
enc_img = []; 


while ( n+1 <= n_img )
        
    
    current_element = img(n);
    next_element = img(n+1);
    
    
    
    [r,code] = check_dict(current_element,next_element,dictionary);
    
    
    if r
        
        temp_current_element = current_element;
        temp_next_element = next_element;
        
        while r
            
            current_element = temp_current_element; 
            next_element = temp_next_element;
            
            temp_current_element = [temp_current_element ; temp_next_element];
            
           
            if n+1 < n_img
                n = n + 1;
            else
                [r,code] = check_dict(temp_current_element,[],dictionary); 
                
                enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; 
                return;
            end
            
            temp_next_element = img(n+1); 
            
            [r,code] = check_dict(temp_current_element,temp_next_element,dictionary);
            
        end
 
        
        
        
        enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; 
        
        
        new_element = [ temp_current_element ; temp_next_element ];
        dictionary = update_dict(new_element,dictionary);
        enc_bits = numel(de2bi(numel(dictionary) - 1));       
        
        
        if n+1 < n_img
            n = n + 1;
        else
            [r,code] = check_dict(temp_next_element,[],dictionary); 
            
            enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; 
            return;
        end
        
    else
        
        
        
        enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; 
        
        
        new_element = [ current_element ; next_element ];
        dictionary = update_dict(new_element,dictionary);
        enc_bits = numel(de2bi(numel(dictionary) - 1));       
        
        
        if n+1 < n_img
            n = n + 1;
        else
            [r,code] = check_dict(next_element,[],dictionary); 
            enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; 
            return;
        end
       
    end
    
end

end
