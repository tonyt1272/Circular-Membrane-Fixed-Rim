function table = bez_first_mnzeros(m,num_zeros)
%This functions creates a matrix that holds up to the nth zero of a bessel 
%function of the first kind up to the m'th order.
bzero=[];
table=[];
%m=5;
num_zeros=num_zeros+1;       %number of zeros I want
x=0:.0001:5*num_zeros;       %vector for the Bessel function operate on
wait_mode=waitbar(0,'Generating Modes');
for j=1:m       %looping from 1 to m.  Special case at m=0 handled later
    n=1;     %initializing counter for each zero, looking for n of them
    i=0;     %initializing the index counter for tracing where in x
    z = besselj(j,x);
while (n-1) < num_zeros  %loop while the number of zeros found is less than
                         %the num_zeros
    i=i+1;          %advance index counter for x
    if z(i)*z(i+1)<=0 %the zero check
        value=(x(i)+x(i+1))/2; %taking the middle value for zero location
        
        if abs(value)<10^-4
            value=0;    %set values near zero to zero
        end
        bzero=[bzero value]; %collect zero locations into row vector
        n=n+1;  %advance counter for number of zeros found
    end
end
table=[table ;bzero];  %create table for zeros at m,n 
bzero=[];
waitbar(j/m,wait_mode,'Generating Modes');
end
n=1;
i=0;
z = besselj(0,x);     %Do the process one more time at m=0, the special
                      %case.
while (n-1) < num_zeros
    i=i+1;
    if z(i)*z(i+1)<=0
        value=(x(i)+x(i+1))/2;
        if value<10^-2
            value=0;
        end
        bzero=[bzero value];
        n=n+1;
    end
end
close(wait_mode)
bzero=bzero(1:end-1); %Drop the last value because we will add the NaN
                      %to the front                      
bzero=[NaN bzero];
table =[bzero;table]; %Add the m=0 row to the top of the table
