function FixationCrossMatrix = GetFixationMatrix(FixationCross_Size, RedColor, Background_Color)
%--- make an aliased matrix of fixation cross.


FixationCrossMatrix = Background_Color *(ones(FixationCross_Size));
Fixation_BarWidth = 0.2*FixationCross_Size;
if mod(FixationCross_Size, 2) ==0    % --- FixatinCross_Size is an even number
    Integer_BarWidth = floor(Fixation_BarWidth/2)*2;
    i1  = (FixationCross_Size/2+1)-Integer_BarWidth/2;
    i2 =  FixationCross_Size/2  + Integer_BarWidth/2;
else
    Integer_BarWidth = floor((Fixation_BarWidth-1)/2)*2 +1;
    i1 = floor(FixationCross_Size/2)-(Integer_BarWidth-1)/2+1;
    i2 = floor(FixationCross_Size/2)+1+ (Integer_BarWidth-1)/2;
end  

%--- paint partially red bars for anti-aliasing 
Fraction_BarWidth_Weight = (Fixation_BarWidth -Integer_BarWidth)/2;
Partial_Red_Index = round(Fraction_BarWidth_Weight*RedColor + (1-Fraction_BarWidth_Weight)*Background_Color);
FixationCrossMatrix(i1-1, :) = Partial_Red_Index*ones(1, FixationCross_Size); 
FixationCrossMatrix(i2+1, :) = Partial_Red_Index*ones(1, FixationCross_Size); 
FixationCrossMatrix(:, i1-1) = Partial_Red_Index*ones(FixationCross_Size, 1);
FixationCrossMatrix(:, i2+1) = Partial_Red_Index*ones(FixationCross_Size, 1);
%
FixationCrossMatrix(i1:i2, :) = RedColor*ones(Integer_BarWidth, FixationCross_Size);  %--- full red horizontar bars
FixationCrossMatrix(:, i1:i2) = RedColor*ones(FixationCross_Size, Integer_BarWidth);  %--- full red vertical bars