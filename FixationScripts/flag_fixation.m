function [fixating]=flag_fixation(SetUp_Info,xeye,yeye,fixating,framecount,design, eyedist)
fixwindowPix_radius=design.Fixation_window_radius_in_Pixel;
total_fixation_time=design.FixationPeriod_in_Second; 
IFI=SetUp_Info.FrameInterval_in_Second; 
xfix=design.Fixation_center_xy_in_Pixel(1);
yfix=design.Fixation_center_xy_in_Pixel(2);
% fixating: variable resets every time eyes are outside fixation window
%counter: variable keeps the score. When eyes move out of the fixation
%window it doesn't reset
%framecounter: variable counts the overall number of frames in which the
%function is used
% if EyetrackerType == 1
%     error=Eyelink('CheckRecording');
%     evt=error;
%     if(error~=0)
%         error
%         return;
%     end
% end
r_eyeloc= sqrt( (xeye(end)-xfix)^2 + (yeye(end)-yfix)^2 );
eyedist=[eyedist r_eyeloc];

if   framecount>1 && abs(r_eyeloc)<fixwindowPix_radius
    % if eyes are within fixation window; we count the frame
    fixating=fixating+1;
else
    % if eyes are outside fixation window; reset fixating
    fixating=0;
end