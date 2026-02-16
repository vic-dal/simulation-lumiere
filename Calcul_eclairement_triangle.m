function [E] = Calcul_eclairement_triangle(A, B, C, Source)
% E = Calcul_eclairement_triangle(A, B, C, Source)
%
% Calcul un éclairement direct normalisé
%
% Entrées : 
% - A, B, C : les coordonnées des sommets du triangle [x, y, z] 
% - Source : les coordonnées de la Source [xs, ys, zs]
%
% Sortie : 
% - E entre 0 et 1, éclairement direct normalisé
%
% Version : 1.0
% Auteur : Fabien Chevillotte
% Date : 18/01/2024

%Calcul du centre de gravité G du triangle
G = Calcul_centre_de_gravite(A,B,C);

%Coordonnées et norme du vecteur source-G
vecteur_rayon = Source-G;
d = norm(vecteur_rayon);

%Calcul de la normale extérieure au triangle (supposée de norme 1)
normale = Calcul_normale_triangle(A,B,C);

%Cosinus de l'angle entre la normale et le rayon
costheta = dot(vecteur_rayon,normale)/d;

E = costheta;