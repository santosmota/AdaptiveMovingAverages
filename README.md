# AdaptiveMovingAverages
Adaptive Moving Averages for the Application of the CPT in Systems with Variable Frequency

This repository contains the MATLAB model (Simulink + Library + Parameters) and the simulation results as CSV files used in the article "On Adaptive Moving Average Algorithms for the Application of the Conservative Power Theory in Systems with Variable Frequency"

Files:
  RL_DB_Scenarios.slx
    MATLAB Simuling model - R2018a

  CPTLibrary.slx
    Library with the blocks used by RL_DB_Scenarios.slx
    Should stay in the same folder as RL_DB_Scenarios.slx
    
  Param.m
    Matlab script with the parameters and hardcoded choices for the different simulation scenarios.
    
Simulation results (folders)
  SimulationResults
    Sine0666_DB: sinusoidal disturbance, DB scenario
    Sine0666_RL: sinusoidal disturbance, RL scenario
    StepNeg1000_RL: negative step disturbance, applied at t=0.1s, RL scenario
    StepNeg1025_RL: negative step disturbance, applied at t=0.1025s, RL scenario
    StepPos1000_DB: positive step disturbance, applied at t=0.1s, DB scenario
    StepPos1025_DB: positive step disturbance, applied at t=0.1025s, DB scenario
    
Simulation result CSV structure
  There are not titles, data is organized in columns, separated by commas
  CKT.txt
    time, frequency [Hz], n, nceiling, nr, nfloor, vsource, isource,  
      
