function id = leveragesamp(Y,M,Ns)

%rand('twister',5489)
slev = leveragescores(Y,M);
id = randomsamp(Ns,slev); 

end


