clear all;
home;
%cd 'C:\Users\...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CPT transducer cycle time
%Fs = 24000; 
%Fs = 5000; 
Fs = 20000; 
Ts = 1 / Fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Circuit common data ++
Vline = 1; %Vrms
Fline = 50; %Hz
SampPerPeriod = Fs / Fline;
Vamp = Vline * 2^0.5;
SamplesPerPeriod = round(Fs/Fline);
MaxSampPerPeriod = 1.2*round(Fs/Fline);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scenario = 1000;% no scenario, no simulation
scenario = 1;% 1 for 'RL'
%scenario = 2;% 2 for 'DB';

transient = 1000;%no transient, no simulation!
%transient = 11;% 11 positive step at 0.100
transient = 12;% 12 positive step at step at 0.1025
%transient = 13;% 13 positive step at step at 0.105
%transient = 21;% 21 negative step at 0.100
%transient = 22;% 22 negative step at step at 0.1025
%transient = 23;% 23 negative step at step at 0.105

%transient = 111;% 111 for sinusoidal starting at 0.100
%transient = 112;% 112 for sinusoidal starting at 0.1025
%transient = 113;% 113 for sinusoidal starting at 0.105

sinefrequency = 2/3; %for the 0.666 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializing variables 
iniciar = 1;
if iniciar == 1
    SineDistActive = 0;
    SineDistFreq = 0;
    SineDistAmp = 0;
    SineDistPhase = 0;
    SineDistActTime = 0;
    StepActive = 0;
    StepAmp = 0; 
    FStepTime = 0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load Scenario
if scenario == 1
    Pload = 0.5;
    Rload = Vline^2 / Pload; 
    Qload = 0.5;
    Xload = Vline^2 / Qload; 
    Lload = Xload / 2 / pi / Fline; 
    Pdiodebridge = 0.00000001;
    %Pdiodebridge = 0.5;
    Rdiodebridge = 0.5 * Vline^2 / Pdiodebridge; 
elseif scenario == 2
    Pload = 0.00000001;
    Rload = Vline^2 / Pload; 
    Qload = 0.00000001;
    Xload = Vline^2 / Qload; 
    Lload = Xload / 2 / pi / Fline;
    Pdiodebridge = 0.5;
    Rdiodebridge = 0.5 * Vline^2 / Pdiodebridge; 
else
    disp('Quitting script, no load scenario was chosen');
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transient type
if transient < 100 
    StepActive = 1; 
    if transient < 20
        StepAmp = SampPerPeriod/(SampPerPeriod-4)*Fline-Fline;
    else
        StepAmp = -(SampPerPeriod+4)/SampPerPeriod*Fline+Fline; %Hz
    end
    
    if transient == 11 || transient == 21
        FStepTime = 0.100;
    elseif transient == 12 || transient == 22
        FStepTime = 0.1025;
    elseif transient == 13 || transient == 23
        FStepTime = 0.105;
    else
        disp('Quitting script, no valid step time chosen');
        return
    end
    Tfinal = 0.2; %for sine responses
    sim('RL_DB_Scenarios',Tfinal);
    
elseif transient < 200
    SineDistActive = 1; 
    SineDistAmp = 0.5; %Hz
    SineDistFreq = sinefrequency; %Hz
    
    if transient == 111 || transient == 121
        SineDistActTime = 0.100;
    elseif transient == 112 || transient == 122
        SineDistActTime = 0.1025;
    elseif transient == 113 || transient == 123
        SineDistActTime = 0.105;
    else
        disp('Quitting script, no valid sine dist. time chosen');
        return
    end 
    SineDistPhase = -SineDistActTime * 2 * pi * SineDistFreq;
    Tfinal = 3; %for sine responses
    sim('RL_DB_Scenarios',Tfinal);
else
    disp('Quitting script, no valid disturbance time chosen');   
    return
end
disp('Simulation finished');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving variables to file
% I was not able to open the files in python later
% So I went for the old CSV file
%save('CKT.mat',CKT);
%save('CPT_LVTD.mat','CPT_LVTD');
%save('CPT_CVTD.mat','CPT_CVTD');
%save('CPT_WAMA.mat','CPT_WAMA');
%save('CPT_HAMA.mat','CPT_HAMA');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving CSV files
% This is hardcoded with the Simulink File
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TotalSamplesSim = round(Tfinal / Ts + 1);
disp('Start saving text files');
% CKT file
% f N Nr V I Ir Il Id
fCVT = fopen('CKT.txt','w');
% CPT_Files
% P Ia Q W Ir Iv Vint Vintbias Vinthat VI VinthatI
fCPT_LVTD = fopen('CPT_LVTD.txt','w');
fCPT_CVTD = fopen('CPT_CVTD.txt','w');
fCPT_WAMA = fopen('CPT_WAMA.txt','w');
fCPT_HAMA = fopen('CPT_HAMA.txt','w');
for c = 1:TotalSamplesSim
    fprintf(fCVT,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\n',CKT(c,:));
    fprintf(fCPT_LVTD,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\n',CPT_LVTD(c,:));
    fprintf(fCPT_CVTD,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\n',CPT_CVTD(c,:));
    fprintf(fCPT_WAMA,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\n',CPT_WAMA(c,:));
    fprintf(fCPT_HAMA,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\n',CPT_HAMA(c,:));
end
fclose(fCVT);
fclose(fCPT_LVTD);
fclose(fCPT_CVTD);
fclose(fCPT_WAMA);
fclose(fCPT_HAMA);
disp('End of Script');



