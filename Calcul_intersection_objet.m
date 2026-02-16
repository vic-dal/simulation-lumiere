function [test, I] = Calcul_intersection_objet(Sommets, Triangles, O, G)
% [test, I] = Calcul_intersection_objet(Sommets, Triangles, O, G)
%
% Cette fonction vérifie si le rayon OG coupe l'objet constitués de
% triangles (dans le vecteur Triangle)
%
% Entrées :
% - Matrices Sommets [nb_sommets x 3] et Triangles [nb_triangles s x 3], point O et G 
%
% Sorties : 
% - test : booleen (1 si intersection, 0 sinon) 
% - I : point d'intersection éventuel ([] si pas d'intersection)
%
% Version : 1.0
% Auteur : Raphaël Labayrade
% Date : 01/10/2024

test = 0;
I = [];

for k = 1:size(Triangles,1) % pour toutes les faces (triangles) de l'objet
    
    A = Sommets(Triangles(k,1),:);
    B = Sommets(Triangles(k,2),:);
    C = Sommets(Triangles(k,3),:);
    
    GG = Calcul_centre_de_gravite(A,B,C);
    
    if norm(GG-G) > eps % cas où le centre de grav correspond à celui de la face en question
        
        [result, Ip] = Calcul_intersection_triangle_segment(A,B,C,O,G); %pour chaque triangle, on vérifie si il y a intersection avec le triangle, si il y a un triangle qui le coupe, alors on arrete la boucle
         
        if result == 1 % s'il y a intersection on renvoie le booléen test = 1 et un point d'intersection entre le segment et l'objet qui correspond au point d'intersection entre une de ses faces et le segment
          
            test = 1;
            I = Ip;
            break
       
        end
    end
    
end
