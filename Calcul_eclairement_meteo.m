function [Ees, Eed] = Calcul_eclairement_meteo(jour, mois, annee);

T = readtable("donnees_meteo.txt");