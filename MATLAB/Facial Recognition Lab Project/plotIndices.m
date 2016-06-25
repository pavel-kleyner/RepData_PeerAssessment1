function plotIndices(scrambledIndices,correctIndices)

figure();
x_values=1:length(correctIndices);
y_1=scrambledIndices;
y_2=correctIndices;

subplot(1,2,1);
plot(x_values,y_1,'o')
axis square
xlim([0,length(correctIndices)])
ylim([0,length(correctIndices)])
xlabel('Player ID')
ylabel('Database Column')
title('Scrambled Indices')

subplot(1,2,2);
plot(x_values,y_2,'o')
axis square
xlim([0,length(correctIndices)])
ylim([0,length(correctIndices)])
xlabel('Player ID')
ylabel('Database Column')
title('Correct Indices')

