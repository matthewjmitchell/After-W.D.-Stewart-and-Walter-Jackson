
//////////////////Routines to play an single sequence////////////////////////////////////////////

//------------------------------------------------------------------------------------
//Routine to play a sequence of segments, with the \whistle synth

(//Routine which calls ~wind2 function, plays segments in specified order
~whistleSequence = {
	arg
	sequence,//array of indices of segments to play, specifying order
	dict = 1,
	group = ~voiceGrp1,
	rate = 1,
	transpose_ratio = 4,
	freqRev=false,
	ampRev=false,
	amp = 1,
	pan = 0,
	bandwidth = 0.001;

	Routine({
		sequence.do({
			arg
			i;

			var
			phrase_dur = size(~dicts[dict][\freqs][i])*0.0125,

			//last silence is function that chooses silence dur from previous silences
			//.value is needed to call the function, has no effect on numbers
			pause_dur = ~dicts[dict][\silences][i].value*0.0125,
			delta = (phrase_dur + pause_dur) * 1/rate ;


			//("phrase num: " + i).postln;
			//("phrase dur: " + phrase_dur).postln;
			//("pause dur: " + pause_dur).postln;



			~whistleSegment.value(
				dict:dict,
				group:group,
				phrase:i,
				amp:amp,
				pan:pan,
				rate:rate,
				transpose_ratio:transpose_ratio,
				bandwidth:bandwidth,
				freqRev:freqRev,
				ampRev:ampRev,

			);


			delta.yield;
		});
	});
});
/*
(
~windSequence.value(
	sequence:[16,1],
	dict:0,
	group:~voiceGrp1,
	pan:-0.1,
	amp:0.3,
	rate:1,
	transpose_ratio:4,
	bandwidth:0.001,
	freqRev:true,
	ampRev:false,
).play);*/



//--------------------------------------------------------------------------------------------
//Routine to play a sequence of segments, with the \whistle synth

(//Routine which calls ~wind2 function, plays segments in specified order
~humSequence = {
	arg
	sequence,//array of indices of segments to play, specifying order
	dict = 1,
	group = ~voiceGrp1,
	rate = 1,
	transpose_ratio = 1,
	//freqRev=false,
	//ampRev=false,
	amp = 1,
	pan = 0;

	Routine({
		sequence.do({
			arg
			i;

			var
			phrase_dur = size(~dicts[dict][\freqs][i])*0.0125,

			//last silence is function that chooses silence dur from previous silences
			//.value is needed to call the function, has no effect on numbers
			pause_dur = ~dicts[dict][\silences][i].value*0.0125,
			delta = (phrase_dur + pause_dur) * 1/rate ;


			//("phrase num: " + i).postln;
			//("phrase dur: " + phrase_dur).postln;
			//("pause dur: " + pause_dur).postln;



			~humSegment.value(
				dict:dict,
				group:group,
				phrase:i,
				amp:amp,
				pan:pan,
				rate:rate,
				transpose_ratio:transpose_ratio,
				//freqRev:freqRev,
				//ampRev:ampRev,

			);


			delta.yield;
		});
	});
});


/*(
~voiceSequence.value(
	sequence:[16,1],
	dict:0,
	group:~voiceGrp1,
	pan:-0.1,
	amp:0.05,
	rate:1,
	transpose_ratio:1,
).play);*/

