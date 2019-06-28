function [ output ] = CustomEncoEx( source, sz_alpha, final_dict )
% ENCODING
[len, ~] = size(source);
output = ''; 
for i = 1 : len
    for j = 1 : length(final_dict)
        % Monadiki diafora me prin einai o tropos pou prospelaunoume to
        % source afou tora einai tis morfis cell kai oxi vector i array.
        if (source(i,1:2)==final_dict(1,j).character)
            output = strcat(output, final_dict(1,j).code);
            
            break
        end
    end
end

end

