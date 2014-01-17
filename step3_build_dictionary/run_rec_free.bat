..\bin\gawk.exe "{print $1 "," $1}" CN_data.list | ..\bin\sed.exe "s/wav$/mfc/" > fea.scp
..\bin\gawk.exe "{print $1}" CN_data.list | ..\bin\sed.exe "s/wav/mfc/" > fea.list
..\bin\HCopy.exe -C .\hcopy_mfcc_oursetting.cfg -S fea.scp
..\bin\HVite.exe -H ..\model\hmmdef -t 250 -S fea.list -i CN_data_rec.mlf -w wdnet -p -10 dict phn.list


pause
