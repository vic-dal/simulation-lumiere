%% Script générant une vidéo

clear all;
close all;
disp('...')


%% Definition de la scene

[Sommets,Triangles] = Definition_scene_partdieu;

% Concatenation de la nouvelle tour
[SommetsTour, TrianglesTour] = Definition_scene_tour();
[Sommets,Triangles] = Concatenation(Sommets, SommetsTour, Triangles, TrianglesTour);

% Tesselation des batiments
aireTessPartDieu = 250; 
%[Triangles, Sommets] = Tessellation_Vect(Triangles, Sommets, aireTessPartDieu);

% Creation du sol
[SommetsSol, TrianglesSol] = (Creer_sol([-400, -300, 0], [400, 300, 0]));

% Tesselation du sol
aireTessSol = 100;
%[TrianglesSol, SommetsSol] = Tessellation_Vect(TrianglesSol,SommetsSol,aireTessSol);

% Concatenation du sol et de la scène
[Sommets,Triangles] = Concatenation(Sommets, SommetsSol, Triangles, TrianglesSol);

disp("Tessellation terminée");

%% Recuperation des donnees meteo

fichier_meteo = readtimetable('donnees_meteo_juillet.txt');

%% Choix de la date et de l heure

debut = datetime('25/07/2025 07:00', 'InputFormat', 'dd/MM/yyyy HH:mm');
fin = debut + minutes(1); 

%% Definition de la source 

jour = [day(debut) month(debut) year(debut)];
heure = [hour(debut) minute(debut)];
coordonnees = [45 46 42.319; 4 55 22.249];
[Source, hauteur, azimut] = Calcul_position_soleil(jour, heure, coordonnees); 

%% Generation video

n=2; % nombre d'images a generer

pas = 30; % ecart entre chaque image

vidObj = VideoWriter('video_eclairement.avi');
vidObj.FrameRate = 1;
open(vidObj)

nb_Triangles = size(Triangles,1);

%% Eclairements

Edirect_norm = zeros(nb_Triangles,1);
Eglobal = zeros(nb_Triangles,1);
Ecalibre = zeros(nb_Triangles, 1);
Emax=1;

%% Boucle

% pour optimiser le parfor
t1 = Triangles(:,1);
t2 = Triangles(:,2);
t3 = Triangles(:,3);
s1 = Sommets(t1(:),:);
s2 = Sommets(t2(:),:);
s3 = Sommets(t3(:),:);

for j=1:n

    % on recupere les eclairements de la station meteo
    [Eeg, Ediffus] = Lecture_eclairement(fichier_meteo, debut, fin);
    Edirect = Eeg - Ediffus;

    if Eeg >= 0 % si c'est une scene de nuit ou donnee incorrecte (-99), pas besoin de calculer.
   
        E_ref = Calcul_eclairement_triangle([0 0 0], [1 0 0], [0 1 0], Source);
    
        % Emax = Eeg;
    
        fc = Calcul_facteur_calib(Edirect,Source);
        
        parfor i = 1:nb_Triangles % Pour chaque triangle de sommets A B C de centre de gravite G
            
            Eglobal(i) = Eeg;
    
            % Affichage pourcentage de calcul
            disp([int2str(j) '/' int2str(n) ' - ' num2str(i/nb_Triangles*100) ' %']),
            
            A = s1(i,:);
            B = s2(i,:);
            C = s3(i,:);
            
            G = Calcul_centre_de_gravite(A,B,C);
            
            % Si le triangle est tourne vers la source, alors on verifie si le rayon
            % source-G est en intersection avec un autre triangle 
        
            if Test_triangle_tourne_vers_source(A, B, C, Source)
                [test,~] = Calcul_intersection_objet_Vect(Sommets,Triangles,Source,G);
                
                if ~test % s'il n'y a pas intersection
    
                    [N] = Calcul_normale_triangle(A,B,C);
                    ps = abs(dot(N,G-Source));
    
                    Eglobal(i) = fc * ps + Ediffus;
                    
                    % if Eglobal(i)> Emax % calcul imbriqué du Emax pour minimiser le temps de calcul
                    %     Emax = Eglobal(i);
                    % end
                else 
                    % s'il y a intersection
                    Eglobal(i) = Ediffus;
                end
            else
                Eglobal(i) = Ediffus;
            end
        end
    end

    h=figure;
    h.Visible = 'off'; %permet de récupérer les images pour la vidéo sans les afficher

    Ecalibre = Eglobal / 650;

    Affichage_objet_eclaire(Sommets,Triangles,Ecalibre)
    campos([-500 -500 300])
    title(string(debut))
    currFrame = getframe(h); %on stocke le plot qui fera partie de la vidéo 
    writeVideo(vidObj,currFrame);
    
    %on passe à l'heure suivante en incrémentant d'1h le datetime
    debut = debut + minutes(pas);
    fin = debut + minutes(1); 

    PositionSoleil=Calcul_position_soleil(jour, [hour(debut) minute(debut)], coordonnees); 
    Source=PositionSoleil;
end

close(vidObj);
disp('video generee');