%% general visual parameters for fixation 
%fixwindow_values=[3 2 1 0.5];  % size of fixation window in degrees (for the beginning of trial, in the IsFixating scripts)
fixwindow_values=[5 2.5 1 ];  % size of fixation window in degrees (for the beginning of trial, in the IsFixating scripts)
fixwindow=2; % size of fixation window in degrees 
fixwindowPix=fixwindow *SetUp_Info.Pixels_Degree;
%% general temporal parameters (trial events)
precircletime=0.55;
ITI = 0.5; % time between beginning of trial and first event in the trial (fixations, cues or targets)
prefixationsquare=0.5; % time interval between trial start and forced fixation period
cueonset=0.2; % time between end of the forced fixation period and the cue (value works for Acuity and
%crowding, for attention the value is jittered to increase time uncertainty
Jitter=[0.5:0.5:2]; %jitter array for trial start in seconds
fixTime_values=[5 10]; % consecutive time required for fixation in seconds
eyetime2=0; % trial-based timer, will later be populated with eyetracker data
closescript=0; % to allow ESC use 

% eye_used
VelocityThreshs = [20*SetUp_Info.Pixels_Degree 60* SetUp_Info.Pixels_Degree];     % px/sec 	% px/sec
ViewpointRefresh = 1;               % dummy variable
driftoffsetx=0;                     % initial x offset for all eyetracker values
driftoffsety=0;                     % initial y offset for all eyetracker values
driftcorr=0.1;                      % how much to adjust drift correction each trial.

% Parameters to identify fixations
FixationDecisionThreshold = 0.3;    % sec; how long they have to fixate on a location for it to "count"
FixationTimeThreshold = 0.033;      % sec; how long the eye has to be stationary before we begin to call it a fixation
% note, the eye velocity is already low enough to be considered a "fixation"
FixationLocThreshold = 1;           % degrees;  how far the eye can drift from a fixation location before we "call it" a new fixation

%% Initialize Specific Variables 
fixating=0; 
framecounter=0; 