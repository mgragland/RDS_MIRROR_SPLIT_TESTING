function Use_Default_Or_Review = Set_Use_Default_Or_Review_Exp_Parameters()

num_lines = 1;
%--- initialize
Exp_prompt = [];
Exp_default_answer = [];
entry_count = 0;

entry_count = entry_count +1;
txt.prompt= 'Enter value 1 or 2 for whether to use default or review/revise experiment design parameters such as stimulus sizes etc';
txt.default_answer= '1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
design1_index = entry_count;

entry_count = entry_count +1;
txt.prompt= 'Enter value 1 or 2 for whether to use default or review/revise experiment design parameters such as trial numbers, whether to give instructions, whether to use eye tracking etc';
txt.default_answer= '1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
design2_index = entry_count;

entry_count = entry_count +1;
txt.prompt= 'Enter value 1 or 2 for whether to use default or review/revise instructions';
txt.default_answer= '1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
instruction_index = entry_count;

entry_count = entry_count +1;
txt.prompt= 'Enter value 1 or 2 for whether to use default or review/revise setting for the display set up such as viewing distances, screen mode, anaglyph gains';
txt.default_answer= '1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
SetUp_index = entry_count;

entry_count = entry_count +1;
txt.prompt= 'Enter value 1 or 2 for whether to use default or review/revise buttons assignment for task responses';
txt.default_answer= '1';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
button_index = entry_count;


Exp_info=inputdlg(Exp_prompt,'Click OK to use the defaults unless you want to review or edit experimental settings', [1, 150],Exp_default_answer);

Use_Default_Or_Review.design1 = str2num(Exp_info{1});
Use_Default_Or_Review.design2 = str2num(Exp_info{2});
Use_Default_Or_Review.instructions = str2num(Exp_info{3});
Use_Default_Or_Review.setup = str2num(Exp_info{4});
Use_Default_Or_Review.button = str2num(Exp_info{5});
	
