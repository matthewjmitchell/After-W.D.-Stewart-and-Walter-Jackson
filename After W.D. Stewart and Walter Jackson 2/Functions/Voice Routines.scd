(//a routine which plays an infinite series of sequences using the wind synth
//parameters such as rate, transposition, bandwidth are chosen for each sequence, and
//remain for the duration of that sequence, then new values chosen for the next sequence
~whistleRoutine = ({
	arg
	group = ~voiceGrp1,
	pan=0,
	density = 1, //used to determine rest time between sequences. Multiply sequenceDur by reciprocal of density to find silenceDur
	ampMul = 1, //amp is chosen randomly, but can be scaled with ampMul argument
	meanLen = 12,
	reverseProb =0.2,
	bwMin = 0.0001,
	pauseVariability = 0.2,
	bwMax = 0.1;

	Routine({
		loop({

			var
			dict, minLen, sequence,
			rate, transpose_ratio, freqRev,
			rateWeights, transposeWeights,
			amp, bandwidth,
			sequenceDur, silenceDur, delta;

			freqRev = reverseProb.coin;

			dict = [0,1].choose;
			minLen = meanLen + 2.rand2;

			rateWeights = [4,4.5,5,5.5,6,6.5,7,8,9,8,7].normalizeSum;
			transposeWeights = [5,6,7,8,7,6,5,4,3,2,1].normalizeSum;
			rate=[8/16,9/16,10/16,11/16,12/16,13/16,14/16,15/16,16/16,17/16,18/16].wchoose(rateWeights);
			transpose_ratio = [6/2,7/2,8/2,9/2,10/2,11/2,12/2,13/2,14/2,16/2].wchoose(transposeWeights);

			amp = [0.1,0.2,0.25,0.3].choose * ampMul;
			bandwidth = exprand(bwMin,bwMax);

			sequence = ~permute.value(dict:dict,minLen:minLen);
			sequenceDur = ~sequenceDur.value(dict:dict,sequence:sequence,rate:rate);
			silenceDur = sequenceDur/density * rrand(1 - pauseVariability,1 + pauseVariability);
			delta = sequenceDur + silenceDur;



			//("dict " + dict).postln; //0 = Levee Camp Holler, 1 = Tangle Eye Blues
			//("rate " + rate).postln;
			//("transpose_ratio " + transpose_ratio).postln;
			("sequenceDur " + sequenceDur).postln;
			("silenceDur " + silenceDur).postln;
			//("bandwidth " + bandwidth).postln;




			~whistleSequence.value(
				sequence:sequence;,
				dict:dict,
				group:group,
				amp:amp,
				pan:pan,
				rate:rate,
				transpose_ratio:transpose_ratio,
				bandwidth:bandwidth,
				freqRev:freqRev,
			).play;
			delta.yield;
		});
	}).play;

});
);



(//a routine which plays an infinite series of sequences using the voice synth
//parameters such as rate, transposition, bandwidth are chosen for each sequence, and
//remain for the duration of that sequence, then new values chosen for the next sequence
~humRoutine = ({
	arg
	group = ~voiceGrp1,
	pan=0,
	density = 1, //used to determine time between sequences. Multiply sequenceDur by reciprocal of density to find silenceDur
	ampMul = 1, //amp is chosen randomly, but can be scaled with ampMul argument
	pauseVariability = 0.2,
	meanLen = 12;


	Routine({
		loop({

			var
			dict, minLen, sequence,
			rate, transpose_ratio, freqRev,
			rateWeights, //transposeWeights,
			amp, bandwidth,
			sequenceDur, silenceDur, delta;

			//freqRev = 0.2.coin;

			dict = [0,1].choose;
			minLen = meanLen + 2.rand2;

			rateWeights = [4,4.5,5,5.5,6,6.5,7,8,9,8,7].normalizeSum;
			//transposeWeights = [5,6,7,8,7,6,5,4,3,2,1].normalizeSum;
			rate=[8/16,9/16,10/16,11/16,12/16,13/16,14/16,15/16,16/16,17/16,18/16].wchoose(rateWeights);
			transpose_ratio = [1,1/2].choose;

			amp = [0.01,0.015,0.02,0.025,0.03].choose * ampMul;

			sequence = ~permute.value(dict:dict,minLen:minLen);
			sequenceDur = ~sequenceDur.value(dict:dict,sequence:sequence,rate:rate);
			silenceDur = sequenceDur/density * rrand(1 - pauseVariability,1 + pauseVariability);
			delta = sequenceDur + silenceDur;


			//("dict " + dict).postln;
			//("rate " + rate).postln;
			//("transpose_ratio " + transpose_ratio).postln;
			("sequenceDur " + sequenceDur).postln;
			("silenceDur " + silenceDur).postln;
			//("bandwidth " + bandwidth).postln;


			~humSequence.value(
				sequence:sequence;,
				dict:dict,
				group:group,
				amp:amp,
				pan:pan,
				rate:rate,
				transpose_ratio:transpose_ratio,
			).play;
			delta.yield;
		});
	}).play;

});
);
// ~voiceRoutine_1.value(group:~voiceGrp2,pan:1, meanLen:3, density:10)




//helper function for the above
(//returns the dur of the specified sequence, including pauses
~sequenceDur = {
	arg dict, sequence, rate=1;

	//sum the durations of all the segments and divide by rate
	sequence.collect({
		arg i;
		((size(~dicts[dict][\freqs][i])*0.0125) + (~dicts[dict][\silences][i]*0.0125))/rate;
	}).sum;

});
//~sequenceDur.value(dict:0,sequence:[0,1,2,3],rate:1)









