clear;
prompt = "Tech Process(0.8/0.5/0.25/0.18)：";
node = input(prompt);
prompt = "L(um):";
L = input(prompt);
prompt = "W(um):";
W = input(prompt);
prompt = "Normalization(1/0):";
Normal = input(prompt);
%{
node = 0.8;
L = 0.8;
W = 8;
%}

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

if(Normal)
%iD to vid
figure(1);
tiledlayout('flow','TileSpacing','compact');
nexttile;
vid = linspace(-1.414 .* VDD, 1.414 .* VDD);
for VOV = [VDD-0.1 VDD-0.2 VDD-0.3]
  I = 0.5 .* uCox .* W ./ L .* VOV ^ 2;
  iD1 = (I .* 0.5 + I ./ VOV .* (vid.*(abs(vid) < 1.414.*VOV)+1.414.*abs(vid)./vid.*VOV.*(abs(vid) >= 1.414.*VOV)) .* 0.5 .* (1 - ((vid.*(abs(vid) < 1.414.*VOV)+1.414.*VOV.*(abs(vid) > 1.414.*VOV)) ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ 1000;
  iD2 = (I .* 0.5 - I ./ VOV .* (vid.*(abs(vid) < 1.414.*VOV)+1.414.*abs(vid)./vid.*VOV.*(abs(vid) >= 1.414.*VOV)).* 0.5 .* (1 - ((vid.*(abs(vid) < 1.414.*VOV)+1.414.*VOV.*(abs(vid) > 1.414.*VOV)) ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ 1000;
  plot(vid, iD1, 'DisplayName', ['iD1: VOV = ', num2str(VOV), 'V']); grid on, hold on
  plot(vid, iD2, 'DisplayName', ['iD2: VOV = ', num2str(VOV), 'V']); grid on, hold on
end
title('iD to vid');
xlabel('vid (V)');
ylabel('iD (mA)');

%iD/I to vid
nexttile;
vid = linspace(-1.414 .* VDD, 1.414 .* VDD);
for VOV = [VDD-0.1 VDD-0.2 VDD-0.3]
  I = 0.5 .* uCox .* W ./ L .* VOV ^ 2;
  iD1 = (I .* 0.5 + I ./ VOV .* (vid.*(abs(vid) < 1.414.*VOV)+1.414.*abs(vid)./vid.*VOV.*(abs(vid) >= 1.414.*VOV)) .* 0.5 .* (1 - ((vid.*(abs(vid) < 1.414.*VOV)+1.414.*VOV.*(abs(vid) > 1.414.*VOV)) ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ I;
  iD2 = (I .* 0.5 - I ./ VOV .* (vid.*(abs(vid) < 1.414.*VOV)+1.414.*abs(vid)./vid.*VOV.*(abs(vid) >= 1.414.*VOV)) .* 0.5 .* (1 - ((vid.*(abs(vid) < 1.414.*VOV)+1.414.*VOV.*(abs(vid) > 1.414.*VOV)) ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ I;
  plot(vid, iD1, 'DisplayName', ['iD1/I: VOV = ', num2str(VOV), 'V']); grid on, hold on
  plot(vid, iD2, 'DisplayName', ['iD2/I: VOV = ', num2str(VOV), 'V']); grid on, hold on
end
title('iD/I to vid');
xlabel('vid (V)');
ylabel('iD/I');

%iD/I to vid/VOV
nexttile;
vid = linspace(-1.414, 1.414);
for VOV = [VDD-0.1 VDD-0.2 VDD-0.3]
  I = 0.5 .* uCox .* W ./ L .* VOV ^ 2;
  iD1 = (I .* 0.5 + I ./ VOV .* vid .* VOV .* 0.5 .* (1 - (vid .* VOV ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ I;
  iD2 = (I .* 0.5 - I ./ VOV .* vid .* VOV .* 0.5 .* (1 - (vid .* VOV ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ I;
  plot(vid, iD1, 'DisplayName', ['iD1/I: VOV = ', num2str(VOV), 'V']); grid on, hold on
  plot(vid, iD2, 'DisplayName', ['iD2/I: VOV = ', num2str(VOV), 'V']); grid on, hold on
end
lgd = legend('FontSize', 14);
lgd.Layout.Tile = 4;
title('iD/I to vid/VOV');
xlabel('vid/VOV');
ylabel('iD/I');

sgtitle(['Diff Amp iD to vid (Process: ', num2str(node), 'um; W: ' , num2str(W), 'um; L: ', num2str(L), 'um)']);
else
figure(1);
vid = linspace(-1.414 .* VDD, 1.414 .* VDD);
for VOV = [VDD-0.1 VDD-0.2 VDD-0.3]
  I = 0.5 .* uCox .* W ./ L .* VOV ^ 2;
  iD1 = (I .* 0.5 + I ./ VOV .* vid .* 0.5 .* (1 - (vid ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ 1000;
  iD2 = (I .* 0.5 - I ./ VOV .* vid .* 0.5 .* (1 - (vid ./ 2 ./ VOV) .^ 2) .^ 0.5) ./ 1000;
  plot(vid, iD1, 'DisplayName', ['iD1: VOV = ', num2str(VOV), 'V']); grid on, hold on
  plot(vid, iD2, 'DisplayName', ['iD2: VOV = ', num2str(VOV), 'V']); grid on, hold on
end
legend('Location', 'bestoutside');
title('iD to vid');
xlabel('vid (V)');
ylabel('iD (mA)');
end