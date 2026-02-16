clear all
close all

%% Coordonnées sphériques du soleil dans le ciel à 12:00 , pour tous les jours de l'année
Hs = [];
As = [];

Nbre_jours_des_mois = [31 28 31 30 31 30 31 31 30 31 30 31];

% Calcul
for i = 1:12
    
    for j = 1:Nbre_jours_des_mois(i)        
        
        [Coord_cart_xyz,Hauteur,Azimut]=Calcul_position_soleil([j i 2019],[12 00],[45 46 42.319; 4 55 22.249]);
        
        Hs = [Hs Hauteur];
        As = [As Azimut];
        
    end
    
end

Hs = [Hs Hauteur]*180/pi;
As = [As Azimut]*180/pi;


% Dessin
figure
plot(Hs,As,'x')
xlabel('Hauteur en °');
ylabel('Azimut en °');
title('Coordonnées sphériques du soleil dans le ciel à 12:00, sur l''année');

%% Coordonnées sphériques du soleil dans le ciel le 21 juin 
Hs = [];
As = [];

% Calcul
for i = 0:23
    
    for j = 0:59
        
        [Coord_cart_xyz,Hauteur,Azimut]=Calcul_position_soleil([21 06 2019],[i j],[45 46 42.319; 4 55 22.249]);
        
        Hs = [Hs Hauteur];
        As = [As Azimut];
        
    end
    
end

Hs = [Hs Hauteur]*180/pi;
As = [As Azimut]*180/pi;


% Dessin
figure
plot(Hs,As,'x')
xlabel('Hauteur en °');
ylabel('Azimut en °');
title('Coordonnées sphériques du soleil dans le ciel le 21 juin, à chaque minute');

