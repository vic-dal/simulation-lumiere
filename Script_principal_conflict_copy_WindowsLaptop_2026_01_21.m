%% Script principal

clear
close all
disp('...')

%% Definition de la scene

[Sommets,Triangles] = Definition_scene_partdieu;

% Concatenation de la nouvelle tour
[SommetsTour, TrianglesTour] = Definition_scene_tour();
[Sommets,Triangles] = Concatenation(Sommets, SommetsTour, Triangles, TrianglesTour);

% Tesselation des batiments
aireTessPartDieu = 250; 
[Triangles, Sommets] = Tessellation_Vect(Triangles, Sommets, aireTessPartDieu);

% Creation du sol
[SommetsSol, TrianglesSol] = (Creer_sol([-400, -300, 0], [400, 300, 0]));

% Tesselation du sol
aireTessSol = 100;
[TrianglesSol, SommetsSol] = Tessellation_Vect(TrianglesSol,SommetsSol,aireTessSol);

% Concatenation du sol et de la scène
[Sommets,Triangles] = Concatenation(Sommets, SommetsSol, Triangles, TrianglesSol);


%% Recuperation des donnees meteo
fichier_meteo = readtimetable('donnees_meteo_juillet.txt');

%% Definition de la source
jour = [08 07 2025];
heure = [13 36];
coordonnees = [45 46 42.319; 4 55 22.249];
[Source, hauteur, azimut] = Calcul_position_soleil(jour, heure, coordonnees);


%% Définition des paramètres du calcul de l'éclairement calibré

% Calcul E_ref
E_ref = Calcul_eclairement_triangle([0 0 0], [1 0 0], [0 1 0], Source);

% Lecture Ees et Eed
[Ees, Eed, Eeg] = Lecture_meteo(jour, heure);


%% Affichage objet tesselle sans normales pour verification

Affichage_verification_Vect(Sommets,Triangles,Source);
axis equal
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
view([-160  30])
zoom(0.007)
title("Test d'affichage")
drawnow

%% Boucle principale

nb_Triangles = size(Triangles,1);
Eclairement_direct_norm = zeros(nb_Triangles,1);
Eclairement_global = zeros(nb_Triangles,1);
Eclairement_calibre = zeros(nb_Triangles, 1);

% Pour chaque triangle de sommets A B C, de centre de gravite G
for i = 1:nb_Triangles

    % Affichage pourcentage de calcul
    disp([num2str(i/nb_Triangles*100) ' %']),
    
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
            Eclairement_calibre(i) = Calcul_E_calib(Eclairement_direct_norm(i), E_ref, Ees, Eed);
            Eclairement_global(i) = Calcul_E_global(Eclairement_direct_norm(i), E_ref, Eeg, Eed);
        
        else
            Eclairement_calibre(i) = Eed;
            Eclairement_global(i) = Eed;

        end
    end
end

% Normalisation des éclairements
disp(max(Eclairement_calibre))
disp(max(Eclairement_global))
%Eclairement_calibre = Eclairement_calibre / max(Eclairement_calibre);
%Eclairement_global = Eclairement_global / max(Eclairement_global);
Eclairement_calibre = Eclairement_calibre / 650;

%% Affichage final

% Export des valeurs d'éclairement dans un fichier
Nom_fichier = ['Donnees_eclairement_calibre_',int2str(jour(1)),'_',int2str(jour(2)),'_',int2str(jour(3)),'_',int2str(heure(1)),'h', int2str(heure(2)),'.csv'];
writematrix(Eclairement_calibre,Nom_fichier,'Delimiter','tab');

% Affichage de l'objet eclaire
figure
cla
hold on

%Affichage_objet_eclaire(Sommets,Triangles,Eclairement_direct_norm)
Affichage_objet_eclaire(Sommets,Triangles,Eclairement_calibre)
%Affichage_objet_eclaire(Sommets,Triangles,Eclairement_global)

s = ' ';
axis equal
view([-160  30])
titre = ['Scene tessellée avec éclairements et ombres à',s ,int2str(heure(1)), 'h', int2str(heure(2)),s ,'le' ,s , int2str(jour(1)),s , int2str(jour(2)),s , int2str(jour(3))];
title(titre)
drawnow