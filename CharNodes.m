classdef CharNodes
    % Klasi me ta xaraktiristika kathe komvou sto "dendro"
    properties
        % Ena ID gia na mporoume na kratame mia seira stis kataxoriseis
        % (den arkoun oi theseis tou pinaka afou sortaroume sunexos) kai
        % gia na kanoume matching patera-paidiou
        ID
        % Character: To sumvolo tou alfavitou sto opoio antistoixei o komvos
        character = '';
        % Occurence: to plithos emfaniseon tou stoixeiou stin pigi
        occurence
        % Code: i kodikopoiisi tou stoixeiou
        code = '';
        % is_left_child, is _right_child: sumvolizoun an o komvos einai
        % deksi i aristero paidi tou patera tou
        is_left_child %1
        is_right_child %0
        % parentNodeID: to ID tou komvou-patera
        parentNodeID
        % codelen: mikos kodikopoiisis tou stoixeiou, aparaitito gia
        % sorting.
        codelen
    end
end

