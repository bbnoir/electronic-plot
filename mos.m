clear;
prompt = "Process Technology[0.8/0.5/0.25/0.18](um):";
node = input(prompt);
prompt = "L(um):";
L = input(prompt);
%L = 0.18; %um
prompt = "W(um):";
W = input(prompt);
%W = 18; %um
if node == 0.8
  Nvalue = [15 2.3 550 127 0.7 5 25 0.2];
  Pvalue = [15 2.3 250 58 -0.7 5 20 0.2];
elseif node == 0.5
  Nvalue = [9 3.8 500 190 0.7 3.3 20 0.4];
  Pvalue = [9 3.8 180 68 -0.8 3.3 10 0.4];
elseif node == 0.25
  Nvalue = [6 5.8 460 267 0.43 2.5 5 0.3];
  Pvalue = [6 5.8 160 93 -0.62 2.5 6 0.3];
elseif node == 0.18
  Nvalue = [4 8.6 450 387 0.48 1.8 5 0.37];
  Pvalue = [4 8.6 100 86 -0.45 1.8 6 0.33];
end

tox = Nvalue(1);
Cox = Nvalue(2);%fF/um^2
u = Nvalue(3); %cm^2/Vs
uCox = Nvalue(4);
Vt = Nvalue(5); %V
VDD = Nvalue(6);
VA = Nvalue(7);
Cov = Nvalue(8);

%show NMOS ID_VG

IDtoVG = zeros(1,VDD*1000+1,2);
VG = 0:0.001:VDD; %V
VD = [VDD/100 VDD]; %V

figure;
for i = 1:2
    for j = 1:VDD*1000+1
        if VG(j) > Vt
            if VD(i) < VG(j) - Vt
                IDtoVG(1,j,i) = uCox * W / L * ((VG(j) - Vt) * VD(i) - VD(i)*VD(i) /2)* (1 + VD(i)/VA/L);
            else
                IDtoVG(1,j,i) = uCox * W / L * (VG(j) - Vt)^2 * (1 + VD(i)/VA/L) /2;
            end
        else
            IDtoVG(1,j,i) = 0;
        end
    end
    plot(VG,IDtoVG(:,:,i));
    hold on;
end
title('NMOS ID-VGS');
xlabel('VGS (V)');
ylabel('ID (uA)');
grid on;
legend(['VDS = ', num2str(VDD/100), 'V'], ['VDS = ', num2str(VDD), 'V']);


%show NMOS ID_VD

IDtoVD = zeros(1,VDD*1000+1,7);
VG = 0:VDD/5:VDD;
VD = 0:0.001:VDD;

figure;
for i = 1:6
    for j = 1:VDD*1000+1
        if VG(i) > Vt
            if VD(j) < VG(i) - Vt
                IDtoVD(1,j,i) = uCox * W / L * ((VG(i) - Vt) * VD(j) - VD(j)*VD(j) /2) * (1 + VD(j)/VA/L);
            else
                IDtoVD(1,j,i) = uCox * W / L * (VG(i) - Vt)^2 * (1 + VD(j)/VA/L) /2;
            end
        else
            IDtoVD(1,j,i) = 0;
        end
    end
    plot(VD,IDtoVD(:,:,i));
    hold on;
end
title('NMOS ID-VDS');
xlabel('VDS (V)');
ylabel('ID (uA)');
grid on;
legend('VGS=0V',['VGS=', num2str(VDD/5), 'V'],['VGS=', num2str(2*VDD/5) ],['VGS=', num2str(3*VDD/5), 'V'],['VGS=', num2str(4*VDD/5), 'V'], ['VGS=', num2str(VDD), 'V']);


tox = Pvalue(1);
Cox = Pvalue(2);%fF/um^2
u = Pvalue(3); %cm^2/Vs
uCox = Pvalue(4);
Vt = -Pvalue(5); %V
VDD = Pvalue(6);
VA = Pvalue(7);
Cov = Pvalue(8);


%show PMOS ID_VG

IDtoVG = zeros(1,VDD*1000+1,2);
VG = 0:0.001:VDD; %V
VD = [VDD/100 VDD]; %V

figure;
for i = 1:2
    for j = 1:VDD*1000+1
        if VG(j) > Vt
            if VD(i) < VG(j) - Vt
                IDtoVG(1,j,i) = uCox * W / L * ((VG(j) - Vt) * VD(i) - VD(i)*VD(i) /2)* (1 + VD(i)/VA/L);
            else
                IDtoVG(1,j,i) = uCox * W / L * (VG(j) - Vt)^2 * (1 + VD(i)/VA/L) /2;
            end
        else
            IDtoVG(1,j,i) = 0;
        end
    end
    plot(VG,IDtoVG(:,:,i));
    hold on;
end
title('PMOS ID-VSG');
xlabel('VSG (V)');
ylabel('ID (uA)');
grid on;
legend(['VSD = ', num2str(VDD/100), 'V'], ['VSD = ', num2str(VDD), 'V']);


%show PMOS ID_VD

IDtoVD = zeros(1,VDD*1000+1,7);
VG = 0:VDD/5:VDD;
VD = 0:0.001:VDD;

figure;
for i = 1:6
    for j = 1:VDD*1000+1
        if VG(i) > Vt
            if VD(j) < VG(i) - Vt
                IDtoVD(1,j,i) = uCox * W / L * ((VG(i) - Vt) * VD(j) - VD(j)*VD(j) /2) * (1 + VD(j)/VA/L);
            else
                IDtoVD(1,j,i) = uCox * W / L * (VG(i) - Vt)^2 * (1 + VD(j)/VA/L) /2;
            end
        else
            IDtoVD(1,j,i) = 0;
        end
    end
    plot(VD,IDtoVD(:,:,i));
    hold on;
end
title('PMOS ID-VSD');
xlabel('VSD (V)');
ylabel('ID (uA)');
grid on;
legend('VSG=0V',['VSG=', num2str(VDD/5), 'V'],['VSG=', num2str(2*VDD/5) ],['VSG=', num2str(3*VDD/5), 'V'],['VSG=', num2str(4*VDD/5), 'V'], ['VSG=', num2str(VDD), 'V']);
