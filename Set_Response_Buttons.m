
function Response_Buttons = Set_Response_Buttons(use_default_or_review)


Response_button_prompt ={'Response button for near depth (no space)', 'Response button for far depth (no space)', 'label for near depth', 'label for far depth'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Warning, do not change this order, always put front and back as the first and second choice (rather than the second and first choice), to match
%%%%%%%%%%%%%%%%%%%%%%%%---- this order in other parts of the code!
dialog_title='Set_response_buttons';
num_lines=1;
Response_button_default_answer={'space', 'b', 'front', 'back'};

if use_default_or_review~=1
	Response_button_info = inputdlg(Response_button_prompt,dialog_title,num_lines,Response_button_default_answer);
else
	Response_button_info = Response_button_default_answer;
end
Response_keyNames{1} = Response_button_info{1}; 
Response_keyNames{2} = Response_button_info{2}; 

Response_key_by_Label{1} = Response_button_info{3};
Response_key_by_Label{2} = Response_button_info{4};

if strcmp(Response_keyNames{1}, 'space')
    KeyCode_response_button{1} = KbName(Response_keyNames{1});
    KeyCode_response_button{2} = KbName(Response_keyNames{2});
    Response_mode='Keyboard';
end

if strcmp(Response_keyNames{1}, 'blue')
    KeyCode_response_button{1} = hex2dec('0000FFF7');
    KeyCode_response_button{2} = hex2dec('0000FFFD');
     Response_mode='ResponseBox';
end

Response_Buttons.keyName = Response_keyNames;
Response_Buttons.KeyCode = KeyCode_response_button;
Response_Buttons.Label = Response_key_by_Label;
Response_Buttons.Type=Response_mode; 

