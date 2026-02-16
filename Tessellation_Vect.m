function [Tri, Som] = Tessellation_Vect(Triangles, Sommets, Aire)
% Version vectorisée de la tesselation

% Initialisations
Som = Sommets;                 % sommets accumulés
Tri = Triangles;               % file de triangles (on append à la fin)
readIdx = 1;                   % indice de lecture (parcours en FIFO)
writeIdx = size(Tri,1);        % dernier indice valide dans Tri

% Boucle : tant qu'il reste des triangles à traiter
while readIdx <= writeIdx
    % indices des 3 sommets du triangle courant
    t = Tri(readIdx, :);

    % calculer l'aire
    if Calcul_surface(Som(t(1),:), Som(t(2),:), Som(t(3),:)) > Aire
        % Tessellation du triangle readIdx
        [Tnew, Snew] = Tessellation_une_fois(readIdx, Tri, Som);

        % Ajouter nouveaux sommets et nouveaux triangles à la fin
        if ~isempty(Snew)
            Som = [Som; Snew];
        end
        if ~isempty(Tnew)
            Tri = [Tri; Tnew];
            writeIdx = writeIdx + size(Tnew,1);
        end

        % Marquer le triangle lu comme "supprimé" en mettant des zéros
        % (on ne supprime pas la ligne pour éviter de décaler la matrice)
        Tri(readIdx, :) = 0;
    end

    % avancer vers le triangle suivant
    readIdx = readIdx + 1;
end

% Nettoyage final : supprimer les lignes marquées (toutes les lignes nulles)
Tri(~any(Tri,2), :) = [];
end
