function [S] = Calcul_surface(A, B, C)
% S = Calcul_surface(A, B, C)
%
% Entrées - 
% - A, B, C sont des vecteurs (1 x 3)
%
% Sortie :
% - S est un scalaire qui correspond à la surface du triangle ABC
%
% Version : 1.0
% Auteur : Raphaël Labayrade
% Date : 01/10/2024

% Définition des vecteurs du triangle
V1 = C-A;
V2 = B-A;

% Calcul de la surface en utilisant le produit vectoriel (formule de Shoelace)
S = norm(cross(V1,V2))/2;

%Autre possibilité base*hauteur/2
scal=dot(V1,V2);
theta=acos(scal/(norm(V1)*norm(V2)));
Hauteur=norm(V1)*sin(theta);
Base=norm(V2);
S=Base*Hauteur/2;

end

