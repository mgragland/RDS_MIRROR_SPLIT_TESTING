
function [Use_Default_Or_Review, Subject_Info, design, Instruction_Pages_Info, SetUp_Info] = Initialization()

Use_Default_Or_Review = Set_Use_Default_Or_Review_Exp_Parameters();
%%%%%%%%%%%%%%%%%%%%%% Get the subject information
Subject_Info = Get_Subject_Info();
%%%%%%%%%%%%%%%%%% set up the response keys for the keyboard, perhaps change this if you have a different response hardware
Response_Buttons = Set_Response_Buttons(Use_Default_Or_Review.button);
%%%%%%%%%%%%%%%%% set experimental design parameters
design   =  Set_Experimental_design(Use_Default_Or_Review);
design.Response_Buttons = Response_Buttons;
design.DepthOrder = size(Response_Buttons.Label);
design.DepthOrder_by_Label = Response_Buttons.Label;
%
%%%%%%%%%%%%%%% Prepare for instrutions if instruction is called for
if design.Give_Instructions_Or_Not==1 %--- set, review/edit instructions
    Instruction_Pages_Info = Set_InstructionContent(design);
    if Use_Default_Or_Review.instructions ~=1
        Edit_Instruction_Or_Not = questdlg('Do you like to view or edit the instructions first?', 'Option to revise the default instructions',  'no ', 'yes', 'no');
        if strcmp(Edit_Instruction_Or_Not, 'yes') ==1
            Instruction_Pages_Info = Edit_InstructionContent(Instruction_Pages_Info, design);
        end
    end
else
    Instruction_Pages_Info =[];
end
%%%%%%%%%%%%%%%%%%%%%% Set up the  display
SetUp_Info = SetUp_Display(Use_Default_Or_Review.setup);
%---------------
design = Update_design_by_SetUp_Info(SetUp_Info, design);



