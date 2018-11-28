clear
clc
close all
close hidden

%function y = find_n_zeros(x)
n_modes=10;    
mn=Bez_first_mnzeros(n_modes,n_modes); %Calls the function that supplies a table that 
                             %holds the J_m(j_mn) = 0.  You can make the 
                             %table as big as you need.

m=0;        %choose the mode to be plotted
n=1;

title_m=m;   %saving the m and values for the title       
title_n=n;
rho=3;
J=10;
c=sqrt(J/rho);
dr=.02;  %radial resolution
a=1.0;  %radius of the circle
r=0:dr:a;


dtheta=2*pi/80;  %angular resolution
theta=0:dtheta:2*pi;    

[R,Theta] = meshgrid(r,theta);

sigma=.125;
h=.25;
Initial = h*exp(-((R).^2/(2*pi*sigma^2)));
Initial_1d = h*exp(-((r).^2/(2*pi*sigma^2)));
Shape0=zeros(size(Initial));

mode_n=[];

m=0;
t=0;
wait_shape=waitbar(0,'Generating Shape');
for n=1:n_modes
    k_mn=mn(m+1,n+1);
    w_mn(n)=k_mn*c;
    mode_n=besselj(m,k_mn*R/a).*cos(m*Theta);
    Amn=2/(a^2*besselj(1,mn(1,1+n))^2)*sum(Initial_1d.*r.*besselj(0,mn(1,1+n)*r/a))*dr;
    mode_part(:,:,n)=Amn*mode_n;
    Shape0=Shape0+mode_part(:,:,n);
   waitbar(n/n_modes,wait_shape,'Generating Shape');
end
close(wait_shape)
X = R.*cos(Theta); 
Y = R.*sin(Theta);

figure(1)
surf(X,Y,Initial)
zlim([0,.25])
title('Initial Gaussian Displacement')

figure(2)
surf(X,Y,Shape0)
zlim([0,.25])
title('Mode Construction of Initial Displacement')

t_duration=10;
dt=.005;
Shape=zeros(size(Initial));
for t=0:dt:t_duration
for n=1:n_modes
            %Applying amplitudes to modes and time progression
        
        Shape(:,:)=Shape(:,:)+mode_part(:,:,n)*cos(w_mn(n)*t);

   
end
    
    surf(X,Y,Shape)
    zlim([-h,h])
    pause(.001)
    if t==0
        title(['Thin Membrane,Fixed Edge,Damped, modes=',num2str(n_modes),])
        xlabel('X')
        ylabel('Z')
        %str = input(prompt,'s');
    end
    Shape=zeros(size(Initial));
end
figure(1)
surf(X,Y,Initial)
zlim([0,.25])
title('Initial Gaussian Displacement')

figure(2)
surf(X,Y,Shape0)
zlim([0,.25])
title('Mode Construction of Initial Displacement')
