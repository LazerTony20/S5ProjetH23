close all
clear all
clc


bancEssaiConstantes

simout = sim('Full_model','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));
