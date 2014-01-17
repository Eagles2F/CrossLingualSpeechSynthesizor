% Author: Yifan Li
% Date: 1/5/2014
% Brief: concatenate the phonemes and pronounce the sentence.

clear;
clc;

load('dictionary.mat');
load('Phonemes.mat');

%"??????"
Sentence = {'ni','hao',',','zao','shang','hao'};
Sentence_pro=[];

for i=1:length(Sentence)
    for j = 1:length(Words)
        if Sentence{i} == ','
            Sentence_pro = [Sentence_pro; zeros(400,1)]; %silence for ','
        elseif strcmp(Sentence{i},Words{j})%for the word
            word_pro=[];
            for k = 1:length(Words_pronunciation{j})
               for m = 1:length(phonemes)
                    if strcmp(Words_pronunciation{j}{k},phonemes{m})
                        word_pro = [word_pro;phonemes_pronunciation{m}{1}];
                    end
               end
               
            end
            Sentence_pro = [Sentence_pro ; word_pro] ;
        end
    end
end

sound(Sentence_pro,8000);
%“??????”
Sentence = {'dong','bei','cai',',','hao','chi'};