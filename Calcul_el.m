function [E] = ()

%T = readtable("donnees_meteo.txt");

%T(1:5:end, 5)

donnees_meteo_juillet = load("donnees_meteo_juillet.mat");

Ligne = donnees_meteo_juillet(1:5:end, 5)