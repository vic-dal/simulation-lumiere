function [Sommets, Triangles] = Definition_scene_partdieu()
% [Sommets, Triangles] = Definition_scene_pyramides
%
% Exemple de scene 3D .
%
% Sorties: 
% - Sommets [nb_sommets x 3]
% - Triangles [nb_triangles x 3]



%% Définition de la scène
SommetsPartDieu = 'Sommets_Part_Dieu_2020.mat';
TrianglesPartDieu = 'Triangles_Part_Dieu_2020.mat';

load(SommetsPartDieu, 'Sommets');
load(TrianglesPartDieu, 'Triangles');

%% Ajout d'un batiment supplementaire
