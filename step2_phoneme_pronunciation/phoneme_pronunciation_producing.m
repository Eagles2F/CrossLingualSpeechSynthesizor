%   Author: Yifan Li
%   Date:   12/30/2013
%   Brief: This script is using to produce the wav file for each phoneme
%   from the alignment of english data.

clear;
clc;

alignment_file = 'C:\Users\Eagles2F\Documents\GitHub\CrossLingualSpeechSynthesizor\step2_phoneme_pronunciation\EN_data_align.mlf';

%% load alignment result
alignment_result = fopen(alignment_file,'r');

nline = 0;
wavID = 1; %f1.wav~f20.wav ?? 1~20, m1.wav~m20.wav?? 21~40
PhonemeWav(1).fileID=0;
PhonemeWav(1).head=0;
PhonemeWav(1).tail=0;
PhonemeWav(1).phoneme='';
PWnumber=1;
pat = 'EN_Data/[mf].+\.rec';
while ~feof(alignment_result) % ?????????
   nline=nline+1;
   tline = fgetl(alignment_result);  %??????
   if nline > 1 %?????
        if tline == '.'  %  ???????????wavID??1
            wavID = wavID + 1;
        elseif isempty(regexp(tline,pat,'match'))  %????????????,???????
            tline = deblank(tline);%?????????
            S = regexp(tline,' ','split');%?tline???????
            PhonemeWav(PWnumber).fileID=wavID;
            PhonemeWav(PWnumber).head=str2double(S(1));
            PhonemeWav(PWnumber).tail=str2double(S(2));
            PhonemeWav(PWnumber).phoneme=S(3);
            PWnumber = PWnumber + 1; %??????????1
        end
   end
end

PWnumber = PWnumber - 1;

fclose(alignment_result);


%% cut the wavfile to get the pronunciation of the phonemes
wavfile_array = cell(1,40);
for i=1:20 %????wav??
    FILE = ['C:\Users\Eagles2F\Documents\GitHub\CrossLingualSpeechSynthesizor\step2_phoneme_pronunciation\EN_Data\f',int2str(i),'.wav'];
    wavfile_array{i} = wavread(FILE);
end
for i=1:20 %????wav??
    FILE = ['C:\Users\Eagles2F\Documents\GitHub\CrossLingualSpeechSynthesizor\step2_phoneme_pronunciation\EN_Data\m',int2str(i),'.wav'];
    wavfile_array{i+20} = wavread(FILE);
end

for i = 1: PWnumber
    temp_wav = wavfile_array{PhonemeWav(i).fileID};
    head = round(PhonemeWav(i).head/1250)+1;  %1250????????
    tail = round(PhonemeWav(i).tail/1250);
    PhonemeWav(i).wavfile = temp_wav(head:tail);
end


%% Get the average pronunciation of 40 phonemes
%cluster the wav file
phonemes = {'aa','ae','ah','ao','aw','ay','b','ch','d','dh','eh','er','ey','f','g','hh','ih','iy','jh','k','l','m','n','ng','ow','oy','p','r','s','sh','sil','t','th','uh','uw','v','w','y','z','zh'};
phonemes_pronunciation = {}; % ??????????data???"ao"?"zh"
phonemes_pro_std = {}; %??????????0~1??
for i=1:40
    count = 0;
    wavfiles={};
    len_wav=[];
    for j = 1:PWnumber %?????phoneme??????wav??
     if strcmp(PhonemeWav(j).phoneme{1},phonemes{i})
         count = count+1;
         wavfiles{count} = PhonemeWav(j).wavfile;
         len_wav = [len_wav,length(wavfiles{count})];
     end
    end
   phonemes_pronunciation{i} = wavfiles;
%find out the standard sound of each phoneme
   max_len=max(len_wav);
   xi = 1:1:max_len;
   y_all=zeros(1,max_len);
   for j = 1:count %?????wavfile
       x=(1:1:len_wav(j))./max_len;
       yi = interp1(x,wavfiles{j},xi,'cubic');
       yi=yi/max(yi);    
       y_all = y_all+yi;
   end
   phonemes_pro_std{i} = y_all/count;
   WAVEFILE = [phonemes{i},'.wav'];
   if length(phonemes_pronunciation{i}) > 1
    wavwrite(phonemes_pronunciation{i}{2},8000,16,WAVEFILE);
   end
end
save('Phonemes.mat','phonemes','phonemes_pronunciation');

