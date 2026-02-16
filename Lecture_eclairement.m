function [Eeg,Eed] = Lecture_eclairement(fichier,debut,fin)
% récupère les valeurs d'éclairement pour la période de temps sélectionnée

tr = timerange(debut,fin);
ligne = fichier(fichier.Time(tr),:);
ligne_convertie = timetable2table(ligne);

Eeg = ligne_convertie.Var10; % Eglobal
Eed = ligne_convertie.Var11; % Ediffus


end