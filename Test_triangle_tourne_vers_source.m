function [test] = Test_triangle_tourne_vers_source(A, B, C, Source)
% test = Test_triangle_tourne_vers_source(A, B, C, Source)
%
% Entrées
% - A, B, C sont les coordonées des sommets du triangle et Source les


% Centre de gravité du triangle

G = Calcul_centre_de_gravite(A,B,C);

% Vecteur G-Source
vecteur_rayon = Source-G;

normale = Calcul_normale_triangle(A,B,C);

test = false;
if dot(vecteur_rayon,normale) > 0
    test = true;
end
end