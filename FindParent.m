function returned_code = FindParent(PID,  CharNodeTree, root)

    % Kinoumaste apo to katotero meros tou "dendrou" mexri tin riza kai
    % psaxnoume an eimaste aristera i deksia paidia tou komvou patera kai
    % poios einai o pateras tou patera mas.
    if( CharNodeTree(1,PID).is_left_child == 1)
        CharNodeTree(1,PID).code = strcat('1',CharNodeTree(1,PID).code);
    else
        CharNodeTree(1,PID).code = strcat('0',CharNodeTree(1,PID).code);
    end
    
    if(CharNodeTree(1,PID).parentNodeID ~= root)
        % Anadromi
        returned_code = strcat(FindParent(CharNodeTree(1,PID).parentNodeID, CharNodeTree, root),  CharNodeTree(1,PID).code);   
    else
        % An ftaseis sto root, krata to code kai stamata tin anadromi.
        returned_code =  CharNodeTree(1,PID).code;
    end
end