clc;
clear all;
close all;

ag = input('Please enter the air gap: ');
p = input('Please enter the periodicity: ');
fract = p/ag;
rel_eps = input('Please enter the relative permittivity: ');
F_max = 50;

freqs = [];
B_ln = [];

le = -pi/p; re = +pi/p; mid = pi/(10*p);

for kz = le:mid:re
    for x_1 = 1:2*F_max
	    for y_1 = 1:2*F_max
	        x_2 = x_1-F_max;
	        y_2 = y_1-F_max;
	        kn = (1-1/rel_eps)*fract.*sinc((x_2-y_2).*fract) + ((x_2-y_2) ==0)*1/rel_eps;
	        B_ln(x_1,y_1) = (2*pi*(x_2)/p -kz).^2*kn;
	     end
     end

     norm_freq = eig(B_ln);
     norm_freq = sqrt(norm_freq);
     norm_freq = sort(norm_freq); 
     freqs = [freqs;norm_freq.'];
end 

hold on 

for x_axis = 1:length(le:mid:re)
    plot(le:mid:re,freqs(:,x_axis)),grid on;
end 

%hold off

xlabel('Normalized Propogation Constant');
ylabel('Normalized Frequency');
title('Dispersion Relation Of 1D Photonic Crystal ')
