function [G] = Calcul_centre_de_gravite(A, B, C)
% G = Calcul_centre_de_gravite(A, B, C)
%
% Entrées : 
% - A, B, C  vecteurs (1 x 3) 
%
% Sortie : 
% - G vecteur (1 x 3), centre de gravité
%
% Version : 1.0
% Auteur : Raphaël Labayrade
% Date : 01/10/2024

G = (A + B + C)/3;