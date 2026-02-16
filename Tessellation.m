function [Tri, Som] = Tessellation(Triangles, Sommets, Aire)
% [Tri, Som] = Tessellation(Triangles, Sommets, Aire)
%
% Fonction de tessellation d'un ensemble de triangles jusqu'à une aire
% donnée.
%
% Entrées :
% - Sommets : matrice à trois colonnes [nb_Sommets x 3]
% dans laquelle se trouvent des coordonnées de sommets.
% - Triangles : matrice à trois colonnes [nb_Triangles x 3], où chaque ligne
% contient trois entiers strictements positifs étant les trois numéros de 
% ligne de la matrice Sommets contenant les coordonnées des sommets du
% triangle en question.
% - Aire : aire maximale tolérée des triangles après tessellation
%
% Sorties :
% - Som : matrice à 3 colonnes [nb_Som x 3], contenant les coordonnées des  
% sommets des nouveaux triangles.
% - Tri : matrice à 3 colonnes [nb_Tri x 3], contenant les triplets de numéros de
% sommets de la matrice Som définisssant les nouveaux triangles.
% On part du principe que les triangles sont repérés dans le sens horaire
%
% Version 1.2
% Auteurs : Stanislas Antczak, Lucile Fraisse, Alice Gaboriau

% Initialisations
Som = Sommets;                % Matrice de travail de sommets
Tri = Triangles;              % Matrice de travail de triangles
i = 1;                        % Indice qui parcourt les lignes de la matrice Triangles

% Boucle parcourant la matrice Tri, qui grossit au fur et à mesure de la
% tessellation.
while i <= size(Tri,1)
    
    %Calcule l'aire du triangle en question
    if Calcul_surface(Som(Tri(i,1),:),Som(Tri(i,2),:),Som(Tri(i,3),:)) > Aire
        
        % Pour chaque triangle, si son aire est supérieure à la limite,
        % alors on lui applique la tessellation.
        [T,S] = Tessellation_une_fois(i,Tri,Som);
        
        % La ligne du triangle découpé est remplacée par une ligne vide.
        % L'occurrence suivante de la boucle sera faite sur le triangle
        % suivant.
        Tri(i,:) = [];
        
        % Les coordonnées (S) et les triangles (T) produits par la
        % fonction tesselleunefois sont ajoutées à la fin de Som et Tri
        Som = [Som;S];
        Tri = [Tri;T];
        
    else
        % Si le triangle est déjà assez petit, on avance d'une ligne
        i = i+1;
        
    end
end