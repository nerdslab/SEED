function Gout = knngraph(G,k)

G = abs(G-diag(diag(G)));
Gout = zeros(size(G));

for i=1:size(G,2)
    [~,id]=sort(G(i,:),'descend');
    Gout(i,id(1:k)) = G(i,id(1:k));
end

Gout = 0.5*(Gout + Gout');

end 