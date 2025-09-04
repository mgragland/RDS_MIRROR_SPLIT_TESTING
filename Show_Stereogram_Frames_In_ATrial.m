function StimulusFrame_OnsetTimes= Show_Stereogram_Frames_In_ATrial(design, Window_ID, InterFrame_Interval, lastvbl, ...
    StereoInputFrames, nFramesEachTrial, Previous_FrameDuration_Desired)

advanceframe_ratio=0.5;
StimulusFrame_OnsetTimes = zeros(1, nFramesEachTrial);

for frame = 1:nFramesEachTrial
    if frame >1
        lastvbl = StimulusFrame_OnsetTimes(frame -1);
    end
    Ongoing_Frame_DisplayDuration_Desired = Previous_FrameDuration_Desired(frame);
    for LeftOrRight = 1:2
        Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
        This_MonocularFrame = StereoInputFrames{frame,LeftOrRight};
        TestStimulusFrame_pt{LeftOrRight} =Screen('MakeTexture', Window_ID, This_MonocularFrame);
        
        Screen('DrawTexture', Window_ID, TestStimulusFrame_pt{LeftOrRight});
        Screen('Close', TestStimulusFrame_pt{LeftOrRight});
    end
    Screen('DrawingFinished', Window_ID,2);
    StimulusFrame_OnsetTimes(frame)= Screen('Flip', Window_ID, ...
        lastvbl + Ongoing_Frame_DisplayDuration_Desired-advanceframe_ratio * InterFrame_Interval, 2); %--- 2 is to prevent clearing buffer
end
	

	
