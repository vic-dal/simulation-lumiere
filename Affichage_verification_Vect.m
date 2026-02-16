function Affichage_verification_Vect(Sommets, Triangles, Source)
%  Version vectorisée de Affichage_verification

figure
cla
hold on

plot3(Sommets(:,1),Sommets(:,2),Sommets(:,3),'o')
patch('Faces',Triangles,'Vertices',Sommets,'FaceColor',[0.7 0.2 0.3])
plot3(Source(1),Source(2),Source(3),'or')

% Lecture des coordonnées des sommets pour tout les triangles(nb_triangles x 3 x 3)
A = Sommets(Triangles(:,1), :); % Nx3
B = Sommets(Triangles(:,2), :);
C = Sommets(Triangles(:,3), :);

% Centres de gravité : moyenne des 3 sommets (Nx3)
G = (A + B + C) / 3;

% Normales non normalisées : cross(B-A, C-A) (Nx3)
V1 = B - A;
V2 = C - A;
N = cross(V1, V2, 2); % produit vectoriel selon les lignes

% Normalisation (évite division par zéro)
normN = sqrt(sum(N.^2, 2));
zeroMask = normN == 0;
normN(zeroMask) = 1;       % pour éviter NaN
N = N ./ normN(:, ones(1,3));

% Optionnel : échelle des flèches (ajuster scale)
scale = 0.2 * mean(sqrt(sum((Sommets(max(Triangles(:)),:)-Sommets(min(Triangles(:)),:)).^2,2))); 
% si scale bizarre, remplacer par valeur fixe, p.ex. scale = 0.1;

% Tracer toutes les flèches en une seule fois
%quiver3(G(:,1), G(:,2), G(:,3), N(:,1), N(:,2), N(:,3), 'AutoScale','on', 'AutoScaleFactor', scale);

axis equal
hold off
end
