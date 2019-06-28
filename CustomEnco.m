function [ output ] = CustomEnco( source, sz_alpha, final_dict )
% ENCODING
len = length(source);
output = ''; 
for i = 1 : len
    for j = 1 : sz_alpha
        % An exeis matching to stoixeiou pou thes na kodikopoiisis kai tou
        % stoixeiou pou exeis sto leksiko (final_dict.character) tote
        % kodikopoiise (final_dict.code).
        if (source(1,i)==final_dict(1,j).character)
            output = strcat(output, final_dict(1,j).code);
            break
        end
    end
end

end