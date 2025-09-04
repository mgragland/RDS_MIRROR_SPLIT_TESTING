function   NumericalArray = String_to_Array(txt)

%--- take an input string txt, which may be '[1, 2]; [3, 4]', and give an output array with two rows of numbers.

Stringlist = String_to_Stringlist(txt);
n_rows = length(Stringlist);
for r = 1:n_rows
	temlist = str2num(Stringlist{r});
	if r ==1
		n_columns = length(temlist);
		NumericalArray = zeros(n_rows, 	n_columns);
	else
		if n_columns ~= length(temlist);
			error(sprintf('%s is not in a valid input format for a numerical array output', txt));
		end
	end
	NumericalArray(r, :) = temlist;
end


