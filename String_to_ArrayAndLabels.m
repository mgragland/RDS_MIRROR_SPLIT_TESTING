
function  [This_Array, Label_list] = String_to_ArrayAndLabels(txt)


temlist = String_to_Stringlist(txt);
N1 = length(temlist)/2;
This_Array = [];
for i = 1:N1
        temlist2 = str2num(temlist{(i-1)*2+1});
	This_Array = [This_Array; temlist2];
        Label_list{i} = temlist{(i-1)*2+2};
end

if size(This_Array, 2) ==1
	This_Array = This_Array';
end


