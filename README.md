EDF"This for EEG signal conversion" My EDF source is "PhysioNet". 

First load your EDF file in the same path.

If Your Matlab dont have edf viewer downlaod it.

After downloading the edfread.zip from Matlab extract the .m files and the license text to the same folder (Current woking folder by "pwd")

In cmd window: [hdr, record] = edfread('E:\EEG\EEG_Digitized_Data\chb01_01.edf');

Now load EEG_recrd_1_cnversion.m  Note : I have taken only three channels so depending on you work choose it and extend the code.

Then for even spacing load EEG_recrd_1_Spacing.m

Thats it you are ready to go

If  there is any feedback or need any assist reach me out @-> haran0892@gmail.com
