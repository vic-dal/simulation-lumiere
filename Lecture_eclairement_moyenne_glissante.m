function [s,s2,Ees] = Lecture_eclairement_moyenne_glissante(fichier,debut,fin)
% affiche les éclairements a partir de la moyenne glissante sur une
% fenetre de n minutes
n = 5;
s=0;
s2=0;
for i=1:n

    tr = timerange(debut+minutes(i),debut+minutes(i+1));
    ligne = fichier(fichier.Time(tr),:);
    ligne_convertie = timetable2table(ligne);

    Eeg = ligne_convertie.Var10; % Eglobal
    Eed = ligne_convertie.Var11; % Ediffus
    Ees = ligne_convertie.Var19;
    if Eeg > 0
        s = s+Eeg;
    end
    if Eed > 0
        s2=s2+Eed;
    end
end
s=s/15;
s2=s2/15;
end