% selct numS signals according to prob. distribution given by vector x
% p_select = abs(x)./sum(abs(x));
% Example: id = randomsamp(numS,x)

function id = randomsamp(numS,x)

randnums = rand(numS,1);
vec = cumsum(abs(x)./sum(abs(x)));

id=zeros(numS,1);
for i=1:numS; 
    % find element in vec thats closest to randnums(i) 
    [~,id(i)] = min(abs(randnums(i)-vec));
end
    


end