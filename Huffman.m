function  [fout] = Huffman( quest_num  )
% H synartisi Huffman ektelei tis 3 sunartiseis CustomDict, CustomEnco
% (CustomEncoEx stin periptosi epektasis pigis) kai CustomDeco
% (CustomDecoExstin periptosi epektasis pigis) kai ektyponei & epistrefei 
% tin arxiki morfi tis pigis, tin kodikopoiimeni kai tin apokodikopoiimeni
% kathos kai to meso mikos kodikopoiisis gia kathe ylopoiisi kai to mikos 
% tis ekastote kodikopoiisis.
% To orisma eisodou quest_num orizei to gia poio erotima tha ektelestei to 
% programma (2,3,4 kai 5).
% O kodikas einai se megalo vathmo epanalamvanomenos opote sxolia yparxoun
% (opou itan aparaitita) stin proti emfanisi kathe entolis/grammis.

if(quest_num == 2)
    fileID = fopen('letter frequency.txt','r');
    probabilities = fscanf(fileID,'%f',[1,26]);
    probabilities = probabilities./100;
    fclose(fileID); 
    % Antistoixisi ton grammaton tou alfavitou ston integer pou ta 
    % antiprosopeuei, kathos i randsrc den dexetai non numerical arguments
    int_letters = zeros(1,26);
    for i = 1:26
        int_letters(1,i) = 96 + i;
    end 

    %SOURCE A
    source = char(randsrc(1, 10000, [int_letters; probabilities]));
    fprintf('Source A: %s\n',source);
    alphabet = ['abcdefghijklmnopqrstuvwxyz'];
    sz_alpha = length(alphabet);
    % H metavliti occurences metra to plithos emfanisis kathe grammatos 
    % me xrisi ths sunarthshs countmember(A, B) poy apotelei kai to
    % monadiko kommati kodika poy xrisimopoiithike aytoysio apo to internet
    % (olos o upoloipos kodikas einai grammenos apo to mhden apo emena)
    occurences = countmember(alphabet, source);
    % To final_dict tha periexei mono ta grammata tou alfavitou kai ta
    % antistoixa attributes tous kai oxi ola ta sumplegmata xaraktiron pou
    % tha prokupsoun kata tin diarkeia tis Huffman kodikopoiisis
    final_dict = CustomDict( occurences, alphabet, sz_alpha );
    % To output periexei tin encoded pigi
    output = CustomEnco( source, sz_alpha, final_dict );
    fprintf('Encoded Source A: %s\n', output);
    fprintf('\n');
    fprintf('Length of encoded Source A: %d\n',length(output));
    fprintf('Decoded Source A: %s\n', CustomDeco( output, final_dict, sz_alpha ));
    
    % fout(1) = mikos kodikopoiisis pigis A
    fout(1) = length(output);
    
    %SOURCE B
    % To arxeio kwords_for_A_alphabet.txt einai tropopoiimeno to
    % kwords.txt, diladi xoris ta kefalaia grammata kai tous eidikous
    % xaraktires pou perieixe.
    fileID = fopen('kwords_for_A_alphabet.txt','r');
    source = fscanf(fileID,'%s');
    fclose(fileID);
    fprintf('Source B: %s\n',source);
    final_dict = CustomDict( occurences, alphabet, sz_alpha );
    output = CustomEnco( source, sz_alpha, final_dict );
    fprintf('Encoded Source B: %s\n', output);
    fprintf('\n');
    fprintf('Length of encoded Source B: %d\n',length(output));
    fprintf('Decoded Source B: %s\n', CustomDeco( output, final_dict, sz_alpha ));     
   
    % fout(2) = mikos kodikopoiisis pigis B
    fout(2) = length(output);
end

if(quest_num == 3)
    fileID = fopen('kwords.txt','r');
    source = fscanf(fileID,'%c');
    fclose(fileID);
    alphabet = '';
    % Emfoleumena for loops gia elegxo kai sximatismou tou alfavitou
    for i = 1 : length(source)
        no_insert_flag = 0;
        for j = 1 : length(alphabet)
            if(source(i) == alphabet(j))
                no_insert_flag = 1;
            end
        end
        if(no_insert_flag == 0)
            alphabet = strcat(alphabet, source(i));
        end

    end
    sz_alpha = length(alphabet);
    
    fprintf('Source: %s\n',source);
    occurences = countmember(alphabet, source);
    final_dict = CustomDict( occurences, alphabet, sz_alpha );
    
    output = CustomEnco( source, sz_alpha, final_dict );
    fprintf('Encoded Source: %s\n', output);
    fprintf('\n');
    fprintf('Length of encoded Source: %d\n',length(output));
    fprintf('Decoded Source: %s\n', CustomDeco( output, final_dict, sz_alpha ));
    
    fout(1) = length(output);
    
end

if(quest_num == 4)
    fileID = fopen('letter frequency.txt','r');
    probabilities = fscanf(fileID,'%f',[1,26]);
    probabilities = probabilities./100;
    fclose(fileID); 
    int_letters = zeros(1,26^2);
    % Xrisi tis domis cell tis MATLAB gia na dimiourgisoyme ta character
    % arrays pou xriazomaste gia na sximatistoun ta aparaitita zeugi
    % xaraktiron gia tin epektasi pigis 2is taksis.
    alphabet = cell(1);
    starting_alphabet = ['abcdefghijklmnopqrstuvwxyz'];
    for i = 1 : 26
        for  j = 1 : 26
            first = starting_alphabet(i);
            second = starting_alphabet(j);
            alphabet = [alphabet [first second]];
            final_probabilities((i-1)*26 + j) = probabilities(i) * probabilities(j);
            int_letters(1,(i-1)*26 + j) = (i-1)*26 + j;
        end
    end 
    starting_source = randsrc(1, 5000, [int_letters; final_probabilities]);
    alphabet = alphabet(2:end);
   
    % Ksana xrisi tis domis cell gia ta zeugi xaraktiron
    source = cell(1); 
    for i = 1 : length(starting_source)
        source(i) = alphabet(starting_source(i));
    end
    alphabet = char(alphabet);
    prt_source = '';
    source = char(source);
    for i = 1 : length(source)
        prt_source = [prt_source source(i, 1:2)];
    end
    fprintf('Source A: %s\n', prt_source);
    
    sz_alpha = length(alphabet);
    occurences = countmember(alphabet, source);
    final_dict = CustomDictEx( occurences, alphabet, sz_alpha );
    output = CustomEncoEx( source, sz_alpha, final_dict );
    fprintf('Encoded Source A: %s\n', output);
    fprintf('\n');
    fprintf('Length of encoded Source A: %d\n',length(output));
    decoded = (CustomDeco( output, final_dict, sz_alpha ));
    fprintf('Decoded Source A: %s\n', decoded);
    
    fout(1) = length(output);
    
    
    
end

if(quest_num == 5)
    fileID = fopen('kwords.txt','r');
    starting_source = fscanf(fileID,'%s');
    fclose(fileID);
    starting_alphabet = ['kAa-bmstplecirgoyuhjzndfwvxC/''VG.HqJMOW'];
    
    alphabet = cell(1);
    for i = 1 : length(starting_alphabet)
        for  j = 1 : length(starting_alphabet)
            first = starting_alphabet(i);
            second = starting_alphabet(j);
            alphabet = [alphabet [first second]];
        end
    end 
    alphabet = alphabet(2:end);
   
    source = cell(1); 
    for i = 1 : 2 : length(starting_source)
        first = starting_source(i);
        second = starting_source(i+1);
        source = [source [first second]];
    end
    source = source(2:end);
    alphabet = char(alphabet);
    source = char(source);
    prt_source = '';
    for i = 1 : length(source)
        prt_source = [prt_source source(i,1:2)];
    end
    fprintf('Source B: %s\n', prt_source);
    
    sz_alpha = length(alphabet);
    occurences = countmember(alphabet, source);
    final_dict = CustomDictEx( occurences, alphabet, sz_alpha );
    output = CustomEncoEx( source, sz_alpha, final_dict );
    fprintf('Encoded Source B: %s\n', output);
    fprintf('\n');
    fprintf('Length of encoded Source B: %d\n',length(output));
    decoded = (CustomDeco( output, final_dict, sz_alpha ));
    fprintf('Decoded Source B: %s\n', decoded);
    
    fout(1) = length(output);
end
    

end


