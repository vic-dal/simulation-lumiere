function Affichage_objet_eclaire_rgb(Sommets, Triangles, Couleurs)
% Affichage_objet_eclaire(Sommets, Triangles, Couleurs)
%
% Affiche l'objet avec les couleurs spécifiées
%
% Entrées :
% - Sommets [nb_sommets x 3]
% - Triangles[nb_sommets x 3]
% - Couleurs [nb_triangles x 1] ou [nb_sommets x 1]

nb_tri=length(Triangles);
couleurbis=zeros(nb_tri,3);

for i =1:nb_tri
    cou=Couleurs(i);

    a=Couleurs(i)<0.33;
    b=Couleurs(i)>0.33 && Couleurs(i)<0.66;
    c=Couleurs(i)>0.66;

    % 2 options (mettre l'autre en commentaire) :
    %couleurbis(i,:)=[a*cou + b*0.33 + c*0.33, b*(cou-0.33) + c*0.33, c*(cou-0.66)].*3;  % v1 : affiche les couleurs en dégradant du jaune au rouge
    couleurbis(i,:)=[a*3*cou+b+c, c*3*(cou-0.66), a+b*3*(cou-0.33)];  % v2 (plus joli) : affiche les couleurs de manière continue entre bleu et jaune (noir = bleu, gris = magenta/rouge, blanc = jaune)

end

patch('Faces',Triangles,'Vertices',Sommets,'Facecolor','flat','FaceVertexCData',couleurbis,'LineStyle','none')

end