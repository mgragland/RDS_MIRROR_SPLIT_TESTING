function   Stringlist = String_to_Array(txt)

%--- take an input string txt, which may be '[1, 2]; [3, 4]', and give an output array with two rows of numbers.


Starting_Indices= find(txt=='{' | txt =='(' | txt=='[');
Ending_Indices= find(txt==']' | txt ==')' | txt =='}');

if length(Starting_Indices) ~= length(Ending_Indices)
	error(sprintf('%s is not in a valid input format for a string list  output', txt));
end

if min(abs(Ending_Indices-Starting_Indices))<0
	error(sprintf('%s is not in a valid input format for a string list  output', txt));
end

n_str = length(Starting_Indices);
for r = 1:n_str
	start_index = Starting_Indices(r)+1;
	end_index = Ending_Indices(r)-1;
	index_list = start_index:end_index;	
	Stringlist{r} =  txt(index_list);
end


