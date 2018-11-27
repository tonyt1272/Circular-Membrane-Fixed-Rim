clear
clc
close all
close hidden

%function y = find_n_zeros(x)
    
mn=Bez_first_mnzeros(10,10); %Calls the function that supplies a table that 
                             %holds the J_m(j_mn) = 0.  You can make the 
                             %table as big as you need.

m=1;        %choose the mode to be plotted
n=2;

title_m=m;   %saving the m and values for the title       
title_n=n;

dr=.02;  %radial resolution
a=2;  %radius of the circle
r=0:dr:a;
% theta=0:dtheta:2*pi-dtheta;

dtheta=2*pi/80;  %angular resolution
theta=0:dtheta:2*pi;    

[R,Theta] = meshgrid(r,theta);



mode_mn=besselj(m,mn(m+1,n+1)*R/a).*cos(m*Theta);
%mode_02=besselj(1,R);
X = R.*cos(Theta); 
Y = R.*sin(Theta);
[m,n]=size(R);

surf(X,Y,mode_mn)
title(['Circular Membrane, Fixed Rim, Mode(',num2str(title_m),...
    ',',num2str(title_n),')'])

% R = 1;
% d_r=R/10;
% d_theta=2*pi/50;
% M = 100 ;
% N = 100 ;
% R1 = 0 ; % inner radius 
% R2 = 1 ;  % outer radius
% nR =0:d_r:10+d_r ;%linspace(R1,R2,M) ;
% nT =0:d_theta:2*pi+d_theta ;%linspace(0,2*pi,N) ;
% %nT = pi/180*(0:NT:theta) ;
% [R, Theta] = meshgrid(nR,nT) ;
% % Convert grid to cartesian coordintes
% X = R.*cos(Theta); 
% Y = R.*sin(Theta);
% [m,n]=size(X);
% % Plot grid
% figure
% set(gcf,'color','w') ;
% axis equal
% axis off
% box on
% hold on
% % Plot internal grid lines
% for i=1:m
%     plot(X(i,:),Y(i,:),'k','linewidth',.05); 
% end
% for j=1:n
%     plot(X(:,j),Y(:,j),'k','linewidth',.05); 
% end
% 
% mode_01=besselj(0,R);