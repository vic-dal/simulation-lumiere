function [test, I] = Calcul_intersection_triangle_segment(A, B, C, P1, P2)
% Calcul de l'intersection entre un triangle (A,B,C) et un segment (P1,P2)
% test vaut true si l'intersection existe, auquel cas I est le point
% d'intersection
test = false;
I = [];

N = Calcul_normale_triangle(A,B,C);
dir = P2-P1;
den = dot(N,dir);

if( abs(den)>eps ) % sinon c'est que le segment est // au plan du triangle

	t = dot(N,(A-P1)) / den;
	if( t>=0 && t<=1) % sinon c'est que l'intersection est avant P1 ou après P2
		I = P1 + t*dir;
		if( dot(N,cross(B-A, I-A))>=0 && dot(N,cross(C-B, I-B))>=0 && dot(N,cross(A-C, I-C))>=0 )
			test = true; % on vérifie que I est bien 'à gauche' de chaque arrête = à l'intérieur du triangle
		end
	end

end