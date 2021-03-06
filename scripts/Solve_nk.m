function [n, k] = Solve_nk(f, mgnt, phase, thickness)
warning off;
c = 3 * 10 ^ 8;
n = zeros(1,length(f));
k = zeros(1,length(f));
tmpf = [0; 0; 0];       % frequency
tmpp = [0; 0; 0];       % phase
rho=@(x, n, f, L, c_, lnmt) -x * 2*pi*f * L / c_ + ...
	log((4 * sqrt(n ^ 2 + x ^ 2)) / ((n + 1) ^ 2 + x ^ 2)) - lnmt;
for i = 1:length(f)
	% use index k-1,k,k+1 to fit
	if i == 1
		j = 2;
	elseif i == length(f)
		j = length(f)-1;
	else
		j = i;
	end
	tmpf(1) = f(j - 1);
	tmpf(2) = f(j);
	tmpf(3) = f(j + 1);
	tmpp(1) = phase(j - 1);
	tmpp(2) = phase(j);
	tmpp(3) = phase(j + 1);
	% get fitting function factors (can be optimized)
	factor = polyfit(tmpf, tmpp, 2);
% 	var_x = [tmpf.^2 tmpf [1;1;1]]; % fitting variable-f matrix
% 	factor = var_x ^ -1 * tmpp;
	% 1st derivative of fitting function
	grad_fai = 2 * factor(1) * f(i) + factor(2);
	n(i) = 1 - grad_fai * c / (2 * pi * thickness);
	k(i) = fsolve(rho, 1, [], n(i), f(i), thickness, c, log(mgnt(i)));
end