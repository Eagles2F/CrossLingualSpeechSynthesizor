%   Author: Yifan Li
%   Date: 1/4/2014
%   Brief: Build the Chinese word to english pnn phoneme dictionary

clear;
clc;

file = 'C:\Users\Eagles2F\Documents\GitHub\CrossLingualSpeechSynthesizor\step3_build_dictionary\CN_data_rec.mlf';


%% load file
file_open = fopen(file,'r');

nline =0;
Phoneme(1).head=0;
Phoneme(1).tail=0;
Phoneme(1).phoneme='';
Phoneme(1).cn='';
pat = '/.{1,6}_dic\.rec';
CN = '';
PWnumber = 1;
while ~feof(file_open)  
    nline = nline + 1;
    tline = fgetl(file_open);
    if (nline > 1) && (~strcmp(tline,'.'))
        if ~isempty(regexp(tline,pat,'match'))
            CN = regexp(tline,pat,'match');
            CN = deblank(CN);
            CN = regexp(CN,'_','Split');
            CN = CN{1}(1);
            CN = CN{1}(2:end);
        else
            tline = deblank(tline);
            S = regexp(tline,' ','split');
            Phoneme(PWnumber).head = str2double(S(1));
            Phoneme(PWnumber).tail = str2double(S(2));
            Phoneme(PWnumber).phoneme = S(3);
            Phoneme(PWnumber).cn=CN;
            PWnumber = PWnumber + 1;
        end
    end
end

PWnumber = PWnumber - 1;

Words = {'bei','cai','chi','dong','hao','ni','shang','zao'};
Words_pronunciation = {};
for i=1:8
    count = 0;
    phoneme={};
    for j=1:PWnumber
        if strcmp(Phoneme(j).cn,Words{i})
            count = count+1;
            phoneme{count} = Phoneme(j).phoneme;
        end
    end
    Words_pronunciation{i}=phoneme;
end

save('dictionary.mat','Words','Words_pronunciation');
fclose(file_open);
