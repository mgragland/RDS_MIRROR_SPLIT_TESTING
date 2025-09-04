
function  Trial_Data = Do_TrialSequence(TrialSequence, design, SetUp_Info,  practice_or_test)

N_allTrials = length(TrialSequence);

Trial_Data = [];
if N_allTrials > 0
   for trial =1:N_allTrials
	trial;
    design.trialnumber=trial;
	condition_index = TrialSequence(trial).condition_index;
	FrontOrBack = TrialSequence(trial).FrontOrBack;
	condition = design.Conditions(condition_index);
	[FixationFrame_OnsetTimes,  StimulusFrame_OnsetTimes,  All_Responses, StimulusInfo, Mask_OnsetTime] =DoATrial(design, SetUp_Info, condition, FrontOrBack,  practice_or_test);
    Trial_Data(trial).FixationFrame_OnsetTimes = FixationFrame_OnsetTimes;
    Trial_Data(trial).StimulusFrame_OnsetTimes =StimulusFrame_OnsetTimes;
    Trial_Data(trial).MaskFrame_OnsetTimes = Mask_OnsetTime;
    Trial_Data(trial).StimulusInfo = StimulusInfo;
    Trial_Data(trial).TrialResponses = All_Responses;
    Trial_Data(trial).condition = condition;
    Trial_Data(trial).FrontOrBack = FrontOrBack;
    TrialPrintOut.SubjectResponse= All_Responses.Task_Button_Response.Button_Characters;
    TrialPrintOut.ActualDepth=FrontOrBack;
    TrialPrintOut
    end
   end
end
