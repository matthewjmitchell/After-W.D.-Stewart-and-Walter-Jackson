(//Synthdefs////////////////////////////////////////////////////////////////////////////////////////////////


(//the hum synth
SynthDef.new(\hum,{
	arg
	out = 0,
	amp = 1,
	pan = 0,
	cutOff = 5000,
	harmAmpJitterRate=1,
	harmAmpJitterExtent=0.8,

	//following Sundberg's assertion that amp drops off at a rate of 12db per octave
	//don't really need this many hamonics
	harmAmps = #[ 0.6118900838333, 0.15369983991561, 0.068500842778852, 0.038607654240922, 0.024746658104757, 0.017206633752317, 0.01265495082582, 0.0096978042840186, 0.0076686411258977, 0.0062160794718546, 0.0051406074818741, 0.00432211098544, 0.003684763208227, 0.0031787799270799, 0.0027703781788982, 0.0024359782996462, 0.00215871699397, 0.0019262755592259, 0.0017294854277487, 0.0015614085682537, 0.0014167165309543, 0.0012912622183436, 0.0011817789269471, 0.0010856651939805, 0.0010008285859402, 0.0009255706706071, 0.00085850121446921, 0.00079847341675871, 0.00074453448514753, 0.00069588753577246, 0.00065186194619811, 0.0006118900838333, 0.00057548888960191, 0.00054224519266224, 0.00051180391657467, 0.0004838585440568, 0.00045814335914851, 0.00043442709794556, 0.00041250772299297, 0.00039220809966392, 0.000373372400865, 0.00035586310313993, 0.00033955846554039, 0.00032435040457783, 0.00031014269569756, 0.00029684944516423, 0.00028439378686787, 0.00027270676699219, 0.00026172638621737, 0.00025139677452902, 0.00024166747805683, 0.00023249284089012, 0.00022383146768349, 0.00021564575520597, 0.00020790148290645, 0.00020056745414773, 0.00019361518106707, 0.0001870186071033, 0.00018075386213127, 0.00017479904589635 ];



	var
	//not sure why I'm needing to cut it so much(?), but otherwise it clips
	makeupGain=0.2,
	freq=110,
	numHarm=60,
	harms = Array.series(numHarm,1,1),//harmonics (as ratios to the fundamental)
	freqEnv, freqCtl,
	ampEnv, ampCtl,
	defaultCutoff, cutoffEnv, cutoffCtl,
	ampNoiseGenArray,
	sig,
	lowpassedSig;

	freqEnv = Env.new(Array.fill(2000,freq));
	freqCtl = \freqEnv.kr(freqEnv.asArray);

	ampEnv = Env.new(Array.fill(2000,1));
	ampCtl = \ampEnv.kr(ampEnv.asArray);

	//not using at the moment, can be driven by spectral stats such as centroid or rolloff
	defaultCutoff = 20000;
	cutoffEnv = Env.new(Array.fill(2000,defaultCutoff));
	cutoffCtl = \cutoffEnv.kr(cutoffEnv.asArray);

	//introduce some jitter to the amplitudes of the harmonics
	ampNoiseGenArray = Array.fill(numHarm,
		{ LFNoise2.kr(harmAmpJitterRate,1,0).linlin(-1, 1, 1-harmAmpJitterExtent, 1)}
	);

	harmAmps = harmAmps * ampNoiseGenArray;//randomize harmonics amps
	harmAmps = harmAmps/harmAmps.sum;//normalize harmonics amps
	//harmAmps.postln;

	//make the signal
	sig = DynKlang.ar(`[
		harms*EnvGen.kr(freqCtl),
		harmAmps * EnvGen.kr(ampCtl, doneAction:2),
		[0]
	]);

	// sig = sig.distort;

	//static lowpass filter
	lowpassedSig = LPF.ar(sig,cutOff);//roll off highs
	sig = lowpassedSig; //

	sig = sig*makeupGain;

	//lowpass filter to be controlled by env
	//sig = RLPF.ar(sig, EnvGen.kr(cutoffCtl),1);

	//sig = sig.distort.wrap2(1).fold2(1);

	Out.ar(out,Pan2.ar(sig*amp,pan));
}).add;
);






(//the whistle synth
SynthDef.new(\whistle,{
	arg
	out = ~bus[\reverb],
	amp = 1,
	pan = 0;


	var
	freq=110,
	bandwidth = 0.01,
	freqEnv, freqCtl,
	ampEnv, ampCtl,
	bwEnv, bwCtl,
	gain_adjust=10,
	sig;

	freqEnv = Env.new(Array.fill(2000,freq));
	freqCtl = \freqEnv.kr(freqEnv.asArray);

	ampEnv = Env.new(Array.fill(2000,1));
	ampCtl = \ampEnv.kr(ampEnv.asArray);

	bwEnv = Env.new(Array.fill(2000,0.01));
	bwCtl = \bwEnv.kr(bwEnv.asArray);

	//make the signal
	//experiment w/ WhiteNoise, BrownNoise, PinkNoise
	sig = PinkNoise.ar(
		mul: EnvGen.kr(ampCtl,doneAction:2)
	);

	sig = Resonz.ar(
		sig,
		freq: EnvGen.kr(
			envelope:freqCtl),
		bwr: EnvGen.kr(
			envelope:bwCtl); //* SinOsc.kr(freq:1).range(0.5,1.5);
		//^ add jitter here - this SinOsc thing works, use as a model, but use something not so periodic
	);


	Out.ar(out,Pan2.ar(sig*amp*gain_adjust,pan));
}).add;
);





//////////////////////////////////////////////////////////////////////////////////////////////////////
//REVERB
SynthDef(\reverb, {//from Fieldsteel
	arg in, predelay=0.1, revtime=1.8,
	lpf=4500, mix=0.15, amp=1, out=0;
	var dry, wet, temp, sig;
	dry = In.ar(in,2);
	temp = In.ar(in,2);
	wet = 0;
	temp = DelayN.ar(temp, 0,2, predelay);
	16.do{
		temp = AllpassN.ar(temp, 0.05, {Rand(0.001,0.05)}!2, revtime);
		temp = LPF.ar(temp, lpf);
		wet = wet + temp;
	};
	sig = XFade2.ar(dry, wet, mix*2-1, amp);
	Out.ar(out, sig);
}).add;



// (//Simple synth that accepts envelopes -
// //use as a template for developing synths that accept envelopes
// SynthDef.new(\env_synth_template,{
// 	arg
// 	out = 0,
// 	amp = 1,
// 	pan = 0;
//
// 	var
// 	freq=110,
// 	freqEnv, freqCtl,
// 	ampEnv, ampCtl,
// 	sig;
//
// 	freqEnv = Env.new(Array.fill(2000,freq));
// 	freqCtl = \freqEnv.kr(freqEnv.asArray);
//
// 	ampEnv = Env.new(Array.fill(2000,1));
// 	ampCtl = \ampEnv.kr(ampEnv.asArray);
//
// 	//make the signal
// 	sig = SinOsc.ar(
// 		freq: EnvGen.kr(freqCtl),
// 		mul: EnvGen.kr(ampCtl, doneAction:2)
// 	);
//
// 	Out.ar(out,Pan2.ar(sig*amp,pan));
// }).add;
// );

)