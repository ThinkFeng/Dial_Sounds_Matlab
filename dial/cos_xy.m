function c = cos_xy(x,y)
c = abs(sum(x.*y))/(sqrt(sum(x.*x))*sqrt(sum(y.*y)));