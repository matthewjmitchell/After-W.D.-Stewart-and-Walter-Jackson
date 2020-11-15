//These functions play a single segment and are called by sequence functions, which play a sequence

(//Function to generate envs and instantiate \wind synth
~humSegment = {
	arg
	dict = 0, //0 = Stewart, 1 = Jackson
	group = ~voiceGrp1,
	phrase,
	amp=0.3,
	pan=0,
	freqRev=false,//reverse the frequency envelope?
	ampRev=false,//reverse the amplitude envelope?
	bandwidth=0.01,
	out= ~bus[\reverb],
	instrument=\hum,
	rate=1,
	transpose_ratio=1;
	//fadeinLen = 1,
	//fadeoutLen = 1;

	var
	freqEnv,
	ampEnv,
	env_len;

	//length of freq env in nodes, should also be length of amp env
	env_len = ~dicts[dict][\freqs][phrase].size;


	if(freqRev,
		{freqEnv = Env.new(
			(~dicts[dict][\freqs][phrase] * transpose_ratio).reverse,
			0.0125/rate,
			\sin)},
		{freqEnv = Env.new(
			~dicts[dict][\freqs][phrase] * transpose_ratio,
			0.0125/rate,
			\sin)}
	);
	// freqEnv.plot;


	if(ampRev,
		{ampEnv = Env.new(
			(~dicts[dict][\amps][phrase]).reverse,
			0.0125/rate,
			\sin)},
		{ampEnv = Env.new(
			~dicts[dict][\amps][phrase],
			0.0125/rate,
			\sin)}
	);
	//ampEnv.plot;



	Synth(instrument,[
		\amp,amp *1/pow(bandwidth,0.5),
		//apply makeup gain based on filter bandwidth
		\pan,pan,
		\out,out,
		\freqEnv,freqEnv,
		\ampEnv,ampEnv,
	],
	group);
}
);



/////////////////////////////////////////////////////////
(//Function to generate envs and instantiate \wind synth
~whistleSegment = {
	arg
	dict = 0, //0 = Stewart, 1 = Jackson
	group = ~voiceGrp1,
	phrase,
	amp=0.3,
	pan=0,
	freqRev=false,//reverse the frequency envelope?
	ampRev=false,//reverse the amplitude envelope?
	bandwidth=0.01,
	out= ~bus[\reverb],
	instrument=\whistle,
	rate=1,
	transpose_ratio=1,
	fadeinLen = 1,
	fadeoutLen = 1;

	var
	freqEnv,
	ampEnv,
	bwEnv,
	env_len;

	//length of freq env in nodes, should also be length of amp env
	env_len = ~dicts[dict][\freqs][phrase].size;


	if(freqRev,
		{freqEnv = Env.new(
			(~dicts[dict][\freqs][phrase] * transpose_ratio).reverse,
			0.0125/rate,
			\sin)},
		{freqEnv = Env.new(
			~dicts[dict][\freqs][phrase] * transpose_ratio,
			0.0125/rate,
			\sin)}
	);
	// freqEnv.plot;


	if(ampRev,
		{ampEnv = Env.new(
			(~dicts[dict][\amps][phrase]).reverse,
			0.0125/rate,
			\sin)},
		{ampEnv = Env.new(
			~dicts[dict][\amps][phrase],
			0.0125/rate,
			\sin)}
	);
	//ampEnv.plot;

	bwEnv = Env.new(
		bandwidth.dup(env_len-1)++[0],//replace last item with 0 to avoid after-ring
		0.0125/rate,
		\sin);
	//bwEnv.plot;

	Synth(instrument,[
		\amp,amp *1/pow(bandwidth,0.5),
		//apply makeup gain based on filter bandwidth
		\pan,pan,
		\out,out,
		\freqEnv,freqEnv,
		\ampEnv,ampEnv,
		\bwEnv,bwEnv
	],
	group);
}
);

/////////////////////////////////////////////////////////

