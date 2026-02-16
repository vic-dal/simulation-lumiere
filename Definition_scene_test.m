function [Sommets, Triangles] = Definition_scene_test()
% [Sommets, Triangles] = Definition_scene
%
% Exemple de scene 3D
%
% Sorties: 
% - Sommets [nb_sommets x 3]
% - Triangles [nb_triangles x 3]
%
% Version : 
% Auteur : 
% Date : 

%% TETRAEDRE
% a = 5;
% b = 4;
% 
% Sommets1 = [-a,-a,a;
%             -a-b,-a,a;
%             -a,-a+b,a;
%             -a,-a,a+b];
% 
% Triangles1 = [1,3,4;
%               1,2,3;
%               1,4,2;
%               3,2,4];

%% CUBE 1
x1 = 2;
y1 = 5;
z1 = 3;
x01 = 0;
y01 = 0;

Sommets1 = [x01,y01,0;
           x01 + x1,y01,0;
           x01 + x1,y01 + y1,0;
           x01 + x1,y01,z1;
           x01,y01 + y1,0;
           x01,y01 + y1,z1;
           x01,y01,z1;
           x01 + x1,y01 + y1,z1];

Triangles1 = [1,3,2;
              1,5,3;
              1,2,4;
              1,4,7;
              1,6,5;
              1,7,6;
              2,3,8;
              2,8,4;
              5,8,3;
              5,6,8;
              7,4,8;
              7,8,6];

%% CUBE 2
x2 = 3;
y2 = 3;
z2 = 6;
x02 = -4;
y02 = -6;

Sommets2 = [x02,y02,0;
           x02 + x2,y02,0;
           x02 + x2,y02 + y2,0;
           x02 + x2,y02,z2;
           x02,y02 + y2,0;
           x02,y02 + y2,z2;
           x02,y02,z2;
           x02 + x2,y02 + y2,z2];

Triangles2 = [1,3,2;
              1,5,3;
              1,2,4;
              1,4,7;
              1,6,5;
              1,7,6;
              2,3,8;
              2,8,4;
              5,8,3;
              5,6,8;
              7,4,8;
              7,8,6];



%% CONCATENATION
Sommets = [Sommets1; Sommets2];
% Les indices des triangles du deuxième objet ne doivent pas commencer à 1 dans la matrice triangle générale
Triangles = [Triangles1; Triangles2 + size(Sommets1,1)];
end
