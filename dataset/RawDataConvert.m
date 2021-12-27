%% 1: Clear everything 
clc
close all
clear all

%% 2: Training file importing and formatting
mkdir('Training','dot')
mkdir('Testing','dot')

% Accelerometer
acc_raw = fileread('Training/RAW/AccelerometerData.txt');
acc_rep = strrep(acc_raw, ',', '.');
acc_FID = fopen('Training/dot/TrainingAccZAxis.txt', 'w');
fwrite(acc_FID, acc_rep, 'char');
fclose(acc_FID);

% Differences
diff_raw = fileread('Training/RAW/Differences.txt');
diff_rep = strrep(diff_raw, ',', '.');
diff_FID = fopen('Training/dot/TrainingDiffs.txt', 'w');
fwrite(diff_FID, diff_rep, 'char');
fclose(diff_FID);

% StepsOrNot
steps_raw = fileread('Training/RAW/StepsOrNot.txt');
steps_FID = fopen('Training/dot/TrainingStepsOrNot.txt', 'w');
fwrite(steps_FID, steps_raw, 'char');
fclose(steps_FID);

% Timestamp
time_raw = fileread('Training/RAW/Timestamp.txt');
time_rep = strrep(time_raw, ',', '.');
time_FID = fopen('Training/dot/TrainingTime.txt', 'w');
fwrite(time_FID, time_rep, 'char');
fclose(time_FID);

%% 3: Testing file importing and formatting

clc
close all
clear all

% Accelerometer
acc_raw = fileread('Testing/RAW/AccelerometerData.txt');
acc_rep = strrep(acc_raw, ',', '.');
acc_FID = fopen('Testing/dot/TestingAccZAxis.txt', 'w');
fwrite(acc_FID, acc_rep, 'char');
fclose(acc_FID);

% Differences
diff_raw = fileread('Testing/RAW/Differences.txt');
diff_rep = strrep(diff_raw, ',', '.');
diff_FID = fopen('Testing/dot/TestingDiffs.txt', 'w');
fwrite(diff_FID, diff_rep, 'char');
fclose(diff_FID);

% StepsOrNot
steps_raw = fileread('Testing/RAW/StepsOrNot.txt');
steps_FID = fopen('Testing/dot/TestingStepsOrNot.txt', 'w');
fwrite(steps_FID, steps_raw, 'char');
fclose(steps_FID);

% Timestamp
time_raw = fileread('Testing/RAW/Timestamp.txt');
time_rep = strrep(time_raw, ',', '.');
time_FID = fopen('Testing/dot/TestingTime.txt', 'w');
fwrite(time_FID, time_rep, 'char');
fclose(time_FID);

%% Training matrix importing 

aux_train_acc = readmatrix('Training/dot/TrainingAccZAxis.txt');
aux_train_stp = readmatrix('Training/dot/TrainingStepsOrNot.txt');
aux_train_tim = readmatrix('Training/dot/TrainingTime.txt');
aux_train_dif = readmatrix('Training/dot/TrainingDiffs.txt');

train_acc = aux_train_acc(2:end);
train_tim = aux_train_tim(2:end);
train_dif = aux_train_dif(2:end);

train_tim = train_tim - train_tim(1);

aux_train_stp(1) = 0;
train_stp = aux_train_stp(1:(end-1));

changetrainTo3Ones = 1;

if (changetrainTo3Ones == 1)
    k = 2;
    while (k <= length(train_stp))
        if(train_stp(k) == 1)
            train_stp(k-1) = 1;
            train_stp(k+1) = 1;
            k = k + 2;
        else
            k = k + 1;
        end    
    end
end
% 
writematrix(train_acc,'Training/TrainingAccZAxis.txt');
writematrix(train_stp,'Training/TrainingStepsOrNot.txt');
writematrix(train_tim,'Training/TrainingTime.txt');
writematrix(train_dif,'Training/TrainingDiffs.txt');


%% Testing matrix importing 

aux_test_acc = readmatrix('Testing/dot/TestingAccZAxis.txt');
aux_test_stp = readmatrix('Testing/dot/TestingStepsOrNot.txt');
aux_test_tim = readmatrix('Testing/dot/TestingTime.txt');
aux_test_dif = readmatrix('Testing/dot/TestingDiffs.txt');

test_acc = aux_test_acc(2:end);
test_tim = aux_test_tim(2:end);
test_dif = aux_test_dif(2:end);

test_tim = test_tim - test_tim(1);

aux_test_stp(1) = 0;
test_stp = aux_test_stp(1:(end-1));

changetestTo3Ones = 1;

if (changetestTo3Ones == 1)
    k = 2;
    while (k <= length(test_stp))
        if(test_stp(k) == 1)
            test_stp(k-1) = 1;
            test_stp(k+1) = 1;
            k = k + 2;
        else
            k = k + 1;
        end    
    end
end   
   

writematrix(test_acc,'Testing/TestingAccZAxis.txt');
writematrix(test_stp,'Testing/TestingStepsOrNot.txt');
writematrix(test_tim,'Testing/TestingTime.txt');
writematrix(test_dif,'Testing/TestingDiffs.txt');

%% ImagensReport
% figure(1)
% subplot(2,1,1)
% plot(train_tim,train_acc,'LineWidth',1.5)
% hold on
% stem(train_tim(train_stp>0),train_acc(train_stp>0),'LineWidth',1,'Color','r')
% title("Accelerometer Z axis")
% legend("Accelerometer","Ground truth")
% xlabel("Time (samples)")
% ylabel("Amplitude (g)")
% xlim([340,345])
% subplot(2,1,2)
% stem(train_tim,train_stp,'LineWidth',1,'Color','r')
% title("Ground truth")
% xlabel("Time (samples)")
% ylabel("Step occurrence")
% xlim([340,345])
% exportgraphics(gcf, 'Figure1.pdf');
% 
% figure(2)
% subplot(2,1,1)
% plot(train_tim,train_dif,'LineWidth',1.5)
% hold on
% stem(train_tim(train_stp>0),train_dif(train_stp>0),'LineWidth',1,'Color','r')
% title("Accelerometer differences")
% legend("Differences","Ground truth")
% xlabel("Time (samples)")
% ylabel("Amplitude (g)")
% xlim([340,345])
% subplot(2,1,2)
% stem(train_tim,train_stp,'LineWidth',1,'Color','r')
% title("Ground truth")
% xlabel("Time (samples)")
% ylabel("Step occurrence")
% xlim([340,345])
% exportgraphics(gcf, 'Figure2.pdf');
% %%
% janela_acc1 = train_acc(341:343);
% janela_acc2 = train_acc(342:344);
% janela_acc3 = train_acc(343:345);
% janela_dif1 = train_dif(341:343);
% janela_dif2 = train_dif(342:344);
% janela_dif3 = train_dif(343:345);
% 
% 
% figure(3)
% 
% subplot(3,2,1)
% plot(341:1:343,janela_acc1,'LineWidth',1.5)
% hold on
% plot(341:1:343,janela_dif1,'LineWidth',1.5)
% legend("Accelerometer","Differences")
% title("Feature window at instant k-p")
% xlabel("Time (s)")
% ylabel("Acceleration (g)")
% 
% subplot(3,2,2)
% stem(341,0,'LineWidth',1,'Color', [60 60 60]/255)
% hold on
% stem(342,1,'LineWidth',1,'Color', 'r')
% stem(343,1,'LineWidth',1,'Color', [60 60 60]/255)
% title("Ground truth at instant k-p")
% xlabel("Time (s)")
% ylabel("Step occurrence")
% 
% subplot(3,2,3)
% plot(342:1:344,janela_acc2,'LineWidth',1.5)
% hold on
% plot(342:1:344,janela_dif2,'LineWidth',1.5)
% legend("Accelerometer","Differences")
% title("Feature window at instant k")
% xlabel("Time (s)")
% ylabel("Acceleration (g)")
% 
% subplot(3,2,4)
% stem(342,1,'LineWidth',1,'Color', [60 60 60]/255)
% hold on
% stem(343,1,'LineWidth',1,'Color', 'r')
% stem(344,1,'LineWidth',1,'Color', [60 60 60]/255)
% title("Ground truth at instant k")
% xlabel("Time (s)")
% ylabel("Step occurrence")
% 
% subplot(3,2,5)
% plot(343:1:345,janela_acc3,'LineWidth',1.5)
% hold on
% plot(343:1:345,janela_dif3,'LineWidth',1.5)
% legend("Accelerometer","Differences")
% title("Feature window at instant k+p")
% xlabel("Time (s)")
% ylabel("Acceleration (g)")
% 
% subplot(3,2,6)
% stem(343,1,'LineWidth',1,'Color', [60 60 60]/255)
% hold on
% stem(344,1,'LineWidth',1,'Color', 'r')
% stem(345,0,'LineWidth',1,'Color', [60 60 60]/255)
% title("Ground truth at instant k+p")
% xlabel("Time (s)")
% ylabel("Step occurrence")
% 
% exportgraphics(gcf, 'Figure3.pdf');



