function [ decoded ] = CustomDeco( output, final_dict, sz_alpha )
% DECODING
% Sorting tou dictionary me kata aukson mikos kodikopoiisis. Tha xreiastei
% parakato, afou gia na eimaste sigouroi oti den tha fugoume out of bounds
% tou string pou apokodikopoioume (sunexos to trimmaroume), kanoume matching prota me ta mikrotera
% dunata miki kodikopoiiseon.
[~,asd] = sort([final_dict.codelen]);
final_dict = final_dict(asd); 

len = length(output); 
decoded = '';
% len = mikos tou encoded string. Oso den einai 0 (epeidi trimmaretai
% sunexos), sunexise tin diadikasia apokodikopoiisis.
while(len ~= 0)
    for j = 1 : sz_alpha
        % I metavliti sz_fragment elegxei toso mikos kodikopoiimenou string
        % oso kai to mikos tou kodikopoiimenou sumvolou pou elegxoume. Den
        % uparxei periptosi astoxias afou douleuoume me Huffman
        % kodikopoiisi pou einai prefix-free.
        sz_fragment = length(final_dict(1,j).code);
        if(final_dict(1,j).code == output(1,1:sz_fragment))
            decoded = strcat(decoded, final_dict(1,j).character);
            % Trimming tou encoded string
            output = output(1,(sz_fragment+1):end);
            len = length(output);
            break             
        end
    end    
end    


end

