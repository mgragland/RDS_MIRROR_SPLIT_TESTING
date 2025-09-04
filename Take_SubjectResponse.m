function   [Response, EyeData]=Take_SubjectResponse(design, practice_or_test)

if strcmp(design.Response_Buttons.Type, 'Keyboard')
    [Buttons, Time, EyeData]= checkanswer(design, practice_or_test);
    Response.Button_Characters = Buttons;
    Response.Time= Time; 
    EyeData=EyeData;
end
    
if strcmp(design.Response_Buttons.Type, 'ResponseBox')
   [Buttons, Time, EyeData]= checkanswer(design, practice_or_test);
    Response.Button_Characters= Buttons;
    Response.Time=Time;
    EyeData=EyeData;
end




