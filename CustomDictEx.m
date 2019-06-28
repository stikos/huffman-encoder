function [ final_dict ] = CustomDictEx( occurences, alphabet, sz_alpha )
% DICTIONARY
CharNodeTree  = CharNodes.empty;
for i = 1:length(alphabet)
    CharNodeTree(1,i).ID = i;
    CharNodeTree(1,i).character = alphabet(i,:);
    CharNodeTree(1,i).occurence = occurences(i);
end

final_dict = CharNodeTree;
entries = length(CharNodeTree);
j = 1;
[~,asd] = sort([CharNodeTree.occurence]);
CharNodeTree = CharNodeTree(asd);

for i = 1 : sz_alpha-1
    
    CharNodeTree(1,j).parentNodeID = (entries + 1);
    CharNodeTree(1,j).is_left_child = 1;
    
    CharNodeTree(1,j+1).parentNodeID = (entries + 1);
    CharNodeTree(1,j+1).is_right_child = 0;
    
    newnode = CharNodes;
    newnode.occurence = CharNodeTree(1,j).occurence + CharNodeTree(1,j+1).occurence;
    newnode.character = strcat(CharNodeTree(1,j).character, CharNodeTree(1,j+1).character);
    newnode.ID = entries + 1;
    CharNodeTree = [CharNodeTree newnode];
    [~,asd] = sort([CharNodeTree.occurence]);
    CharNodeTree = CharNodeTree(asd);
    entries = length(CharNodeTree);
    j = j +2;
end
[~,asd] = sort([CharNodeTree.ID]);
CharNodeTree = CharNodeTree(asd); 
root  = CharNodeTree(length(CharNodeTree)).ID;

for i = 1 : sz_alpha
    
    for j = 1 : entries
        % Monadiki diafora me prin o tropos prospelasis tou alphabet, afou
        % tora einai tis morfis cell kai oxi vector i array.
        if(alphabet(i,:) == CharNodeTree(1,j).character)
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
    
    final_dict(1,i).code = strcat(FindParent(CharNodeTree(1,i).parentNodeID, CharNodeTree, root),CharNodeTree(1,i).code) ;
    final_dict(1,i).codelen = length(final_dict(1,i).code);
end
% for i = 1 : length(final_dict)
%     disp(final_dict(i));
% end

end

