function [Tri, Som] = Tessellation_une_fois(n, Triangles, Sommets)
% [Tri, Som] = Tessellation_une_fois(n, Triangles, Sommets)
%
% Fonction qui "tesselle une fois" un triangle donné, c'est-à-dire qui 
% renvoie quatre triangles obtenus en coupant le triangle donné par les
% milieux de ses côtés.
%
% Entrées :
% - Sommets : matrice à trois colonnes [nb_Sommets x 3], 
% dans laquelle se trouvent des coordonnées de sommets.
% - Triangles : matrice à trois colonnes [nb_Triangles x 3], où chaque ligne
% contient trois entiers strictements positifs étant les trois numéros de 
% ligne de la matrice Sommets contenant les coordonnées des sommets du
% triangle en question.
% - n : entier, numéro de ligne de la matrice Triangles, c'est la référence
% du triangle qu'on va tesseller une fois.
%
% Sorties :
% - Som : matrice 6 lignes, 3 colonnes, contenant les coordonnées des six 
% sommets des nouveaux triangles (trois sommets de l'ancien, trois
% milieux).
% - Tri : matrice 4 lignes, 3 colonnes, contenant les triplets de numéros de
% sommets de la matrice Som définisssant les quatre nouveaux triangles.
% On part du principe que les triangles sont repérés dans le sens horaire.
% 
% Version 1.2
% Auteurs : Stanislas Antczak, Lucile Fraisse, Alice Gaboriau

% Définition des points A B C sommets du grand triangle
mon_triangle = Triangles(n,:);
A = Sommets(mon_triangle(1),:);
B = Sommets(mon_triangle(2),:);
C = Sommets(mon_triangle(3),:);

% Calcul des points milieux des côtés du grand triangle
D = (B+C)/2;  % D milieu de [BC]
E = (A+C)/2;  % E milieu de [AC]
F = (A+B)/2;  % F milieu de [AB]

% Définition de la matrice additionnelle de sommets
Som = [D;E;F];

% Nombre de sommets avant ajout
nb_Sommets = size(Sommets,1);

% D arrivera en position nb_Sommets+1 après avoir ajouté les nouveaux sommets
% E arrivera en position nb_Sommets+2 après avoir ajouté les nouveaux sommets
% F arrivera en position nb_Sommets+3 après avoir ajouté les nouveaux sommets

% Définition de la matrice additionnelle de triangles
Tri = [mon_triangle(1),nb_Sommets+3,nb_Sommets+2;     % triangle AFE
       mon_triangle(2),nb_Sommets+1,nb_Sommets+3;     % triangle BDF
       mon_triangle(3),nb_Sommets+2,nb_Sommets+1;     % triangle CED
       nb_Sommets+1,nb_Sommets+2,nb_Sommets+3];       % triangle DEF
end

