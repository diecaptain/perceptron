clear all;
close all;
opengl('save', 'software');
%% Single Perceptron Linear Threshold
% Constants
eeta = 0.001;
%% Data In
class0_x = [2,5,1,4,48,52,50,65,2,8,6,3,65,66,51,47];
class0_y = [52,49,53,55,61,77,42,85,7,8,1,-2,12,3,9,10];
class1_x = [25,22,19,17,51,49,56,45,24,28,21,23,-2,-4,3,5];
class1_y = [61,68,72,47,26,28,19,31,8,9,2,-4,26,20,21,28];
%% Data Range
t = [];
t = 0:1:15;
b = [];
b = 1:1:10000;
u = [];
u = 1:1:1000;
% Rmin = 1;
% Rmax = 22;
K = randi([1 32],1,10000);
%% Assumptions
W0 = 1;
W1 = 2.618;
W2 = -2.618;
%% Initial Run
for i = 1:length(t)
    Sint0(i) = W0+W1*class0_x(i)+W2*class0_y(i);
    if Sint0(i) > 0
        Yint0(i) = 1;
    else
        Yint0(i) = 0;
    end
    Sint1(i) = W0+W1*class1_x(i)+W2*class1_y(i);
    if Sint1(i) > 0
        Yint0(11+i) = 1;
    else
        Yint0(11+i) = 0;
    end
end
%% Training
for j = 2:length(b)
    if K(j) < 17
%         Stdash(j) = W0+W1*class0_x(K(j))+W2*class0_y(K(j));
%         if Stdash(j) > 0
%             Ydash(j) = 1;
%         else
%             Ydash(j) = 0;
%         end
        W0(j) = W0(j-1)+eeta*((0-Yint0(K(j))));
        W1(j) = W1(j-1)+eeta*((0-Yint0(K(j))*class0_x(K(j)))+(0-Yint0(K(j))*class0_y(K(j))));
        W2(j) = W2(j-1)+eeta*((0-Yint0(K(j))*class0_x(K(j)))+(0-Yint0(K(j))*class0_y(K(j))));
    else
        W0(j) = W0(j-1)+eeta*((1-Yint0(K(j)-16)));
        W1(j) = W1(j-1)+eeta*((1-Yint0(K(j)-16)*class1_x(K(j)-16))+(1-Yint0(K(j)-16)*class1_y(K(j)-16)));
        W2(j) = W2(j-1)+eeta*((1-Yint0(K(j)-16)*class1_x(K(j)-16))+(1-Yint0(K(j)-16)*class1_y(K(j)-16)));
    end
end
%% Evaluation
W0f = W0(j);
W1f = W1(j);
W2f = W2(j);
R_x = randi([-100 100],1,1000);
R_y = randi([-100 100],1,1000);
for e = 1:length(u)
    S(e) = W0f+(W1f*R_x(e))+(W2f*R_y(e));
    if S(e) > 0
        Y(e) = 1;
%         figure;
%         scatter(R_x(e),R_y(e),'filled','d'), hold on,
    else
        Y(e) = 0;
%         scatter(R_x(e),R_y(e))
    end
end
for l = 1:length(Y)
if Y(l) == 1
    figure;
    scatter(R_x(l),R_y(l),'filled','d'), hold on,
else
    scatter(R_x(l),R_y(l)), hold on,
end
end
    hold off;
    
% hold off;
%  figure
%            [ha,hl1,hl2] = scatteryy(F,G,F,H);
%            xlabel('F');
%            set(hl1,'color','b');
%            set(hl2,'color','r');
%            axes(ha(1));
%            ylabel('G');
%            axes(ha(2));
%            set(ha(2),'YColor','r');
%            ylabel('ln(G)','color','r');