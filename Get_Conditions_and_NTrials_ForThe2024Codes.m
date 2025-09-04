
function  [Conditions, NTrialsEachCondition_Testing, NTrialsEachCondition_Practice] = Get_Conditions_and_NTrials_ForThe2024Codes(design)


%%--- first construct a Conditions vector, each element is a condition structure, like in my code for iScience 2024 paper
NConditions = design.N_RDS_coherence*design.N_frameDuration*design.N_RDS_locations;

NTrialsEachCondition_Testing = zeros(1, NConditions);
NTrialsEachCondition_Practice = zeros(1, NConditions);

count = 0;
for a = 1:design.N_RDS_coherence
for b = 1:design.N_frameDuration
for c = 1:design.N_RDS_locations

	condition  = Get_condition(a, b, c, design);

	count= count+1;
	Conditions(count) = condition;
	NTrialsEachCondition_Testing(count) = design.N_TestingTrials_Each_Coherence_FrameDuration_Location(a, b, c);	
	NTrialsEachCondition_Practice(count) = design.N_PracticeTrials_Each_Coherence_FrameDuration_Location(a, b, c);	
end
end
end
	
		
	
	
