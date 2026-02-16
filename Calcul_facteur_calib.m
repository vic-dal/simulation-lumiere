function [facteur_calibr] = Calcul_facteur_calib(Edirect,position_soleil)
    
    N = [0 0 1]; % triangle horizontal 
    dir = position_soleil; 
    ps = dot(dir,N); 
    facteur_calibr = Edirect/abs(ps);
end