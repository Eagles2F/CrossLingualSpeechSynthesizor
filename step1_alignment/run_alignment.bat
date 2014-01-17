..\bin\gawk.exe "{print $1 "," $1}" EN_data.list | ..\bin\sed.exe "s/wav$/mfc/" > fea.scp
..\bin\gawk.exe "{print $1}" EN_data.list | ..\bin\sed.exe "s/wav/mfc/" > fea.list
..\bin\HCopy.exe -C .\hcopy_mfcc_oursetting.cfg -S fea.scp
..\bin\HVite.exe -a -H ..\model\hmmdef -C .\HVite_mono.cfg -t 250 -S fea.list -I EN_data.mlf -i EN_data_align.mlf dict phn.list

pause
