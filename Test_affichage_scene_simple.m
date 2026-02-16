%% Script affichage scène simple

clear
close all
disp('...')


%% Définition scène

[Sommets1, Triangles1] = Definition_scene_test;
[Sommets2, Triangles2] = Creer_sol([-10, -10, 0], [10, 10, 0]);
[Sommets, Triangles] = Concatenation(Sommets1, Sommets2, Triangles1, Triangles2);

Source = [9, 7, 8];

% Tessellation 
a = 0.1;
[Triangles, Sommets] = Tessellation_Vect(Triangles, Sommets, a);


%% Boucle principale

nb_Triangles = size(Triangles,1);
Eclairement_direct_norm = zeros(nb_Triangles,1);

% Pour chaque triangle de sommets A B C, de centre de gravite G
for i = 1:nb_Triangles

    % Affichage pourcentage de calcul
%    disp([num2str(i/nb_Triangles*100) ' %']),
    
    A = Sommets(Triangles(i,1),:);
    B = Sommets(Triangles(i,2),:);
    C = Sommets(Triangles(i,3),:);
    
    G = Calcul_centre_de_gravite(A,B,C);
    
    % Si le triangle est tourne vers la source, alors on verifie si le rayon
    % source-G est en intersection avec un autre triangle 

    if Test_triangle_tourne_vers_source(A,B,C,Source)
    
        [test,~] = Calcul_intersection_objet_Vect(Sommets,Triangles,Source,G);
        
        if ~test
            % S'il ne l'est pas, on calcule la couleur du triangle
            Eclairement_direct_norm(i) = Calcul_eclairement_triangle(A,B,C,Source);
        end
 
    end
end


%% Affichage final

figure
cla
hold on

Affichage_objet_eclaire(Sommets,Triangles,Eclairement_direct_norm)
scatter3(Source(1), Source(2), Source(3));

s = ' ';
axis equal
view([-10  10])
titre = ['Scene tessellée avec ombres'];
title(titre)
drawnow