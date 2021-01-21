# AdaptiveMovingAverages
Adaptive Moving Averages for the Application of the CPT in Systems with Variable Frequency

This repository contains the MATLAB model (Simulink + Library + Parameters) and the simulation results as CSV files used in the article "On Adaptive Moving Average Algorithms for the Application of the Conservative Power Theory in Systems with Variable Frequency" submitted to the Journal Energies (https://www.mdpi.com/journal/energies) on January 2021.

## Files:

### RL_DB_Scenarios.slx
MATLAB Simulink model - R2018a

### CPTLibrary.slx
Library with the blocks used by RL_DB_Scenarios.slx. Should stay in the same folder as RL_DB_Scenarios.slx.
    
### Param.m
Matlab script with the parameters and hardcoded choices for the different simulation scenarios.
    
## Simulation results
    Sine0666_DB: sinusoidal disturbance, DB scenario
    Sine0666_RL: sinusoidal disturbance, RL scenario
    StepNeg1000_RL: negative step disturbance, applied at t=0.1s, RL scenario
    StepNeg1025_RL: negative step disturbance, applied at t=0.1025s, RL scenario
    StepPos1000_DB: positive step disturbance, applied at t=0.1s, DB scenario
    StepPos1025_DB: positive step disturbance, applied at t=0.1025s, DB scenario
    
### Simulation result CSV structure
  There are not titles, data is organized in columns, separated by commas.
  
#### CKT.txt
    time [s], frequency [Hz], n, nceiling, nr, nfloor, vsource [V], isource [A], iresistor[A], iinductor[A], idiode[A]
    
#### CPT_LVTD.txt, CPT_CVTD.txt, CPT_WAMA, CPT_HAMA
    active power [W], active current [A], reactive powe [Var], reactive energy [?], reactive current [A], void current [A], integral of Vsource, bias of the integral of vsource, unbiased integral of vsource, source voltage times source current, unbiased integral of the source voltage times source current
      
