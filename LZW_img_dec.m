function [dec_img,dictionary] = LZW_img_dec(enc_img)

dictionary{1} = 0;        
dictionary{2} = 1;        
dictionary = dictionary';

n_enc_img = numel(enc_img); 
enc_bits = 2;               

n = 2;        
dec_img = []; 



current_code = bi2de(enc_img(1));
next_code = bi2de(enc_img(2:3)','left-msb');

while( n+enc_bits-1 <= n_enc_img )
    
    current_element = dictionary{current_code+1};
    
    if next_code+1 <= numel(dictionary)
        next_element = dictionary{next_code+1};
        
        new_element = [ current_element ; next_element(1) ];
        [dictionary,new_code] = update_dict(new_element,dictionary);
    else
        next_element = [ current_element ; current_element(1)];
        
        [dictionary,new_code] = update_dict(next_element,dictionary);
    end
    
    dec_img = [ dec_img ; current_element ];
    
    if n+enc_bits-1 < n_enc_img
        n = n + enc_bits;
    else
        dec_img = [ dec_img ; next_element ];
        return;
    end
    
    enc_bits = numel(de2bi(new_code+1));       
    
    current_code = next_code;
    next_code = bi2de(enc_img(n:n+enc_bits-1)','left-msb');
end

end
