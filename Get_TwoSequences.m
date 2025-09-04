function [TrialSequence, FrontOrBack_List] = Get_TwoSequences(NConditions, NTrialsEachCondition)

TrialSequence = [];
FrontOrBack_List = [];
for c = 1:NConditions
    Ntrials = NTrialsEachCondition(c);
    temlist = c*ones(1, Ntrials);
    TrialSequence = [TrialSequence, temlist];
    temlist2  = [ones(1, floor(Ntrials/2)), 2*ones(1,  floor(Ntrials/2))];  %--- make half of the trials one direction, 1, the other half other direction, 2.
    if  Ntrials > 2*floor(Ntrials/2)  %---
        temlist2 =[temlist2, 1+(rand>0.5)];  %-- give the last trial a random direction if Ntrials is odd
    end
    FrontOrBack_List = [FrontOrBack_List, temlist2];
end
seq = randperm(length(TrialSequence));
TrialSequence =TrialSequence(seq);
FrontOrBack_List =FrontOrBack_List(seq);