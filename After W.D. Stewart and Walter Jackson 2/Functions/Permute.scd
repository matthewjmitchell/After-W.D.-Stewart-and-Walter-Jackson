(//
//Generates a permutation of segments for LCH or TEB according to the \transitions key in their dictionaries.
//Permutations start and end on appropriate segments as defined in the \openers and \closers keys of dictionaries.
//Repetition is discouraged, but not impossible -
//It's fairly unlikely in sequences that are less than length of example sequences (26 for LCH, 33 for TEB)


~permute = {
	arg dict, minLen;

	var

	permutation,
	//the permutation to be returned

	value,
	//value is used in the loop, to hold most recent segement in sequence

	weights,
	//copied from transitions table, but modified in the loop to discourage repetition,
	//and to encourage choosing a closer when it's time to conclude the sequence

	openers = ~dicts[dict][\openers].deepCopy,
	//possible starting segments

	closers = ~dicts[dict][\closers].deepCopy,
	//possible ending segments

	transitions = ~dicts[dict][\transitions].deepCopy,
	//weighted probabilities of transitions between segments


	repeat_probability = 0.001,
	//multiply the weights of already chosen segments by this value, to make them less likely
	//a more sophisticated solution would weight this by how far back in the sequence the segment is (a la "statistical feedback" as described by Charles Ames)
	//but this works for now

	closer_probability = 10,
	//when ready to end sequence, multipy weights by this value for
	//segments that are candidates to end the sequence.
	//a segment is a candidate if it is a member of closers, and does not already appear in sequence
	//(it is still possible to end on a segment that has already appeared, but not encouraged)

	continue = true;
	//exit condition of the while loop

	value = openers.choose;
	//choose the first segment

	permutation = [value];
	//and put it in the sequence

	//now choose subsequent segments until minLen is reached *and* a closer is chosen
	while({continue},{
		var closerCandidates = ~diffArrays.value(closers,permutation);
		//closer candidates are elements of closers that don't already appear in sequence

		weights = transitions[value].deepCopy;

		//modify weights to discourage repetition
		permutation.do({
			arg val;
			weights[val] = weights[val] * repeat_probability;
		});

		//re-normalize to sum to 1
		weights = weights.normalizeSum;

		//sequence.postln;
		//weights.postln;
		//transitions[value].postln;

		//if we're at the specified length, encourage choosing a closer, but not one that's already been chosen
		if(permutation.size >= minLen,{
			closerCandidates.do({
				arg val;
				weights[val] = weights[val] * closer_probability;
			});
		});

		//choose the next value based on transition table for this value
		value = weights.windex;

		//append new value to the array
		permutation = permutation ++ value;

		//exit condition, and encourage choice of closer if we're at the end
		if(permutation.size >= (minLen) && closers.find([value]).notNil,
			{continue = false},
		);
	});
	permutation;
}
);

//~permute.value(1,32).size
//~countRepeats.value(~permute.value(0,26))
//
//// average number of repeats
//100.collect({~countRepeats.value(~permute.value(1,32))}).sum/100


//helper function for ~permute
(//remove items in array2 from array1
~diffArrays = {
	arg array1, array2;
	var output;


	array1.do({
		arg val,i;
		//val.postln
		if(array2.find([val]).isNil,
			{output = output ++ [val]}
		);
	});
	output;
});

