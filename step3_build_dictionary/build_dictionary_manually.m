% Author: Yifan Li
% Date: 1/7/2014
% Brief: This script tries to manually build the dictionary.

clear;
clc;
close all;
%%reading chinese word wav files


[word_wav FS NBITS]=wavread('CN_data\zao_dic.wav');

subplot(2,1,1);
plot(word_wav);
subplot(2,1,2);
Y = fft(word_wav);
w = 2/length(word_wav) * (0:length(word_wav)-1);
plot(w,abs(Y));

%sound(word_wav,FS,NBITS);


load('Phonemes.mat');

% for i=1:40
%    figure('name',phonemes{i},'numbertitle','off');
%    if length(phonemes_pronunciation{i}) > 3
%         subplot(3,1,1);
%         plot(phonemes_pronunciation{i}{1});
%         subplot(3,1,2);
%         plot(phonemes_pronunciation{i}{2});
%         subplot(3,1,3);
%         plot(phonemes_pronunciation{i}{3});
%    end
% end

dong_pro = [100*phonemes_pronunciation{9}{7};100*phonemes_pronunciation{25}{1};10*phonemes_pronunciation{24}{3}];
% sound(dong_pro, FS, NBITS);
% 
% figure;
% subplot(2,1,1);
% plot(dong_pro);
% subplot(2,1,2);
% Y = fft(dong_pro);
% w = 2/length(dong_pro) * (0:length(dong_pro)-1);
% plot(w,abs(Y));
% 
bei_pro = [50*phonemes_pronunciation{7}{3};phonemes_pronunciation{6}{3}];
% sound(bei_pro,FS,NBITS);
% figure;
% subplot(2,1,1);
% plot(bei_pro);
% subplot(2,1,2);
% Y = fft(bei_pro);
% w = 2/length(bei_pro) * (0:length(bei_pro)-1);
% plot(w,abs(Y));
% 
cai_pro = [10*phonemes_pronunciation{8}{3};10*phonemes_pronunciation{1}{3}];
% sound(cai_pro,FS,NBITS);
% figure;
% subplot(2,1,1);
% plot(cai_pro);
% subplot(2,1,2);
% Y = fft(cai_pro);
% w = 2/length(cai_pro) * (0:length(cai_pro)-1);
% plot(w,abs(Y));

hao_pro = [10*phonemes_pronunciation{16}{2};10*phonemes_pronunciation{25}{2}];
% sound(hao_pro,FS,NBITS);

chi_pro = [10*phonemes_pronunciation{8}{3}; 10*phonemes_pronunciation{17}{7}];
% sound(chi_pro,FS,NBITS);
% figure;
% subplot(2,1,1);
% plot(chi_pro);
% subplot(2,1,2);
% Y = fft(chi_pro);
% w = 2/length(chi_pro) * (0:length(chi_pro)-1);
% plot(w,abs(Y));

zao_pro = [10*phonemes_pronunciation{39}{1};10*phonemes_pronunciation{1}{2};10*phonemes_pronunciation{25}{2}];
% sound(zao_pro,FS,NBITS);
% figure;
% subplot(2,1,1);
% plot(zao_pro);
% subplot(2,1,2);
% Y = fft(zao_pro);
% w = 2/length(zao_pro) * (0:length(zao_pro)-1);
% plot(w,abs(Y));

shang_pro = [100*phonemes_pronunciation{30}{1};10*phonemes_pronunciation{1}{2};50*phonemes_pronunciation{23}{7}];
% sound(shang_pro,FS,NBITS);
% figure;
% subplot(2,1,1);
% plot(shang_pro);
% subplot(2,1,2);
% Y = fft(shang_pro);
% w = 2/length(shang_pro) * (0:length(shang_pro)-1);
% plot(w,abs(Y));

ni_pro=[10*phonemes_pronunciation{23}{7};10*phonemes_pronunciation{18}{1}];
% sound(ni_pro,FS,NBITS);
% figure;
% subplot(2,1,1);
% plot(ni_pro);
% subplot(2,1,2);
% Y = fft(ni_pro);
% w = 2/length(ni_pro) * (0:length(ni_pro)-1);
% plot(w,abs(Y));

Z = [dong_pro;10*bei_pro;10*cai_pro;zeros(3000,1);hao_pro;chi_pro];
W = [ni_pro;hao_pro;zeros(3000,1);zao_pro;shang_pro;hao_pro];

sound(Z,FS,NBITS);
sound(W,FS,NBITS);
save('dictionary_man.mat','dong_pro','bei_pro','cai_pro','hao_pro','chi_pro','ni_pro','zao_pro','shang_pro');

wavwrite([Z;Z;Z],FS,'dongbei.wav');
wavwrite([W;W;W],FS,'zaoshang.wav');