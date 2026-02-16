function [sommets, triangles] = Creer_sol(p1, p2)
% [sommets, triangles] = Creer_sol(p1, p2)
%
% Crée un sol rectangulaire (plan horizontal) défini par deux points opposés.
%
% Entrées :
% - p1, p2 : vecteurs (1 x 3) représentant deux coins opposés du rectangle
%            La coordonnée z est conservée pour définir l'altitude du sol.
%
% Sorties :
% - sommets : matrice (4 x 3) contenant les 4 coins du rectangle
% - triangles : matrice (2 x 3) définissant les 2 triangles formant le sol

sommets = [ p1 ; 
    [p2(1), p1(2), p1(3)];
     p2;
     [p1(1), p2(2), p1(3)]];

triangles = [1 2 3; 1 3 4];

end

