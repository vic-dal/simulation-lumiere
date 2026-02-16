function [test, I] = Calcul_intersection_objet_Vect(Sommets, Triangles, O, G)
% Version vectorisé de Calcul_intersetion_objet
% Returns test (1/0) and I the first intersection point (or []).

test = 0;
I = [];

% Direction and segment length
D = G(:)' - O(:)';         % 1x3
segLen = norm(D);
if segLen == 0
    return
end
D = D / segLen;            % Direction normalisée

% Lecture des sommets des triangles
A = Sommets(Triangles(:,1), :);
B = Sommets(Triangles(:,2), :);
C = Sommets(Triangles(:,3), :);

% Optionnel : exclure triangles dont le centre de gravite == G
% Calcul des centres de gravite (vectorisé)
GG = (A + B + C) / 3;
maskSkip = all(abs(GG - G(:)') < eps, 2); % true pour triangles à ignorer

% Möller–Trumbore vectorisé
epsMT = 1e-12;
E1 = B - A;               % N x 3
E2 = C - A;               % N x 3
P = cross(repmat(D, size(E2,1), 1), E2, 2); % N x 3
det = sum(E1 .* P, 2);    % N x 1

% Non-parallèles
nonParallel = abs(det) > epsMT;

% Calcul invDet où c'est utile
invDet = zeros(size(det));
invDet(nonParallel) = 1 ./ det(nonParallel);

Tvec = repmat(O(:)', size(A,1), 1) - A;  % N x 3
u = zeros(size(det));
u(nonParallel) = sum(Tvec(nonParallel,:) .* P(nonParallel,:), 2) .* invDet(nonParallel);

Q = cross(Tvec, E1, 2);
v = zeros(size(det));
v(nonParallel) = sum(repmat(D, size(Q,1), 1) .* Q(nonParallel,:), 2) .* invDet(nonParallel);

t = zeros(size(det));
t(nonParallel) = sum(E2(nonParallel,:) .* Q(nonParallel,:), 2) .* invDet(nonParallel);

valid = nonParallel & (u >= 0) & (v >= 0) & (u + v <= 1) & (t >= 0) & (t <= segLen);

valid(maskSkip) = false;

if ~any(valid)
    return
end

% Trouve l'intersection la plus proche (plus petit t)
[~, idxRel] = min(t(valid));
validIdx = find(valid);
triIdx = validIdx(idxRel);

I = O(:)' + (D * 1) * t(triIdx); % D est l'unite, t la distance
test = 1;
end
