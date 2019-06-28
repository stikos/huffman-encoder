function [ final_dict ] = CustomDict( occurences, alphabet, sz_alpha )
% DICTIONARY
% To CharNodeTree einai ena vector pou periexei stoixeia tupou CharNodes
% kai prosomoionei to dendro poy tha xriazomastan gia tin ulopoiisi tou
% Huffman.
CharNodeTree  = CharNodes.empty;
for i = 1:length(alphabet)
    CharNodeTree(1,i).ID = i;
    CharNodeTree(1,i).character = alphabet(i);
    CharNodeTree(1,i).occurence = occurences(i);
end

final_dict = CharNodeTree;
entries = length(CharNodeTree);
j = 1;
% Sorting tou dendrou kata auksousa seira (mia fora ekso apo to loop kai
% sto telos kathe loop) gia na pairnoume panta ta stoixeia me tis ligoteres
% emfaniseis kai na kanoume ta aparaitita mergings.
[~,asd] = sort([CharNodeTree.occurence]);
CharNodeTree = CharNodeTree(asd);

for i = 1 : sz_alpha-1
    
    % An einai aristero paidi tou komvou-gonea, to is_left_child ginetai 1
    CharNodeTree(1,j).parentNodeID = (entries + 1);
    CharNodeTree(1,j).is_left_child = 1;
    % An einai deksi paidi tou komvou-gonea, to is_right_child ginetai 0
    CharNodeTree(1,j+1).parentNodeID = (entries + 1);
    CharNodeTree(1,j+1).is_right_child = 0;
    
    % Newnode einai o neos kathe fora komvos pou sximatizetai apo tin
    % sugxoneusi ton 2 proigoumenon me to mikrotero arithmo emfanisis stin
    % pigi.
    newnode = CharNodes;
    % Me xrisi tou deikti j kai prosauksisi tou kata 2 kathe fora,
    % petuxenoume sosta mergings kathos exoume auksousa katataksi ton
    % stoixeion poy ananeonetai kai kathe epanalipsi.
    newnode.occurence = CharNodeTree(1,j).occurence + CharNodeTree(1,j+1).occurence;
    newnode.character = strcat(CharNodeTree(1,j).character, CharNodeTree(1,j+1).character);
    newnode.ID = entries + 1;
    CharNodeTree = [CharNodeTree newnode];
    % Ksana sorting
    [~,asd] = sort([CharNodeTree.occurence]);
    CharNodeTree = CharNodeTree(asd);
    entries = length(CharNodeTree);
    j = j +2;
end
% Sort me to ID ton stoixeion tou dendrou gia na kratisoume mono ayta poy
% anikoun sto alfavito (final_dict).
[~,asd] = sort([CharNodeTree.ID]);
CharNodeTree = CharNodeTree(asd); 

% Kratame ton komvo-riza gia na oriothetisoume tin diadikasia tou encoding
root  = CharNodeTree(length(CharNodeTree)).ID;

for i = 1 : sz_alpha
    
    for j = 1 : entries
        if(alphabet(1,i) == CharNodeTree(1,j).character)
            final_dict(1,i).parentNodeID = CharNodeTree(1,j).parentNodeID;
            final_dict(1,i).is_left_child = CharNodeTree(1,j).is_left_child;
            final_dict(1,i).is_right_child = CharNodeTree(1,j).is_right_child;
            break;
        end
    end
    if( CharNodeTree(1,i).is_left_child == 1)
       CharNodeTree(1,i).code = strcat('1',CharNodeTree(1,i).code);
    else
        CharNodeTree(1,i).code = strcat('0',CharNodeTree(1,i).code);
    end 
    % Kinoumaste apo to katotero meros tou "dendrou" mexri tin riza kai
    % psaxnoume an eimaste aristera i deksia paidia tou komvou patera kai
    % poios einai o pateras tou patera mas. I diadikasia ekteleitai
    % anadromika mesa stin sunartisi FindParent().
    final_dict(1,i).code = strcat(FindParent(CharNodeTree(1,i).parentNodeID, CharNodeTree, root),CharNodeTree(1,i).code) ;
    final_dict(1,i).codelen = length(final_dict(1,i).code);
end


end

