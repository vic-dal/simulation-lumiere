function [Sommets, Triangles] = Definition_scene_tour()
% [Sommets, Triangles] = Definition_scene
%
% Exemple de scene 3D
%
% Sorties: 
% - Sommets [nb_sommets x 3]
% - Triangles [nb_triangles x 3]


%% TOUR
x = 30;
y = 30;
z = 140;
x0 = 80;
y0 = -170;

Sommets = [x0,y0,0;
           x0 + x,y0,0;
           x0 + x,y0 + y,0;
           x0 + x/2,y0,z;
           x0,y0 + y,0;
           x0 + x/2,y0 + y,z;
           x0,y0 + y/2,z;
           x0 + x,y0 + y/2,z];

Triangles = [1, 3, 2;
             1, 5, 3;
             1, 2, 4;
             1, 4, 7;
             1, 7, 5;
             5, 7, 6;
             5, 6, 3;
             3, 6, 8;
             3, 8, 2;
             2, 8, 4;
             7, 4, 8;
             7, 8, 6];


end