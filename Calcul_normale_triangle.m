function [Normale] = Calcul_normale_triangle(A, B, C)
% Normale = calcul_normale(A, B, C)
%
% Calcule les coordonnées de la normale au triangle ABC
%
% Entrées :
% - A, B etC sont des vecteurs (1 x 3)
%
% Sortie :
% - Normale est un vecteur (1 x 3) correspondant à la normale de norme 1 au
% triangle ABC
% 
% Version : 1.0
% Auteur : Raphaël Labayrade
% Date : 01/10/2024

AC = C-A;
AB = B-A;

Normale = cross(AB,AC);

Normale = Normale/norm(Normale);

end