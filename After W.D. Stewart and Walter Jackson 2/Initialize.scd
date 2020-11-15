//1. Evaluate code block at line 7 to define main loop function (but evaluate Setup document first)
//2. Evaluate line 4 to call main loop function and initiate composition

~initialize.value;//initiate composition


(//evaluate this block to define the main loop function
~initialize = {

	var
	minWait = 0,
	maxWait = 60.0;

	Routine({

	//distant left whistler
	~whistleRoutine.value(group:~voiceGrp1,pan:-1, meanLen:12, density:1, ampMul:0.1, reverseProb:0.5);

	rrand(minWait,maxWait).wait;

	//distant right whistler
	~whistleRoutine.value(group:~voiceGrp2,pan:1, meanLen:12, density:1, ampMul:0.1, reverseProb:0.5);

	rrand(minWait,maxWait).wait;

	//left humming voice
	~humRoutine.value(group:~voiceGrp1,pan:-1, meanLen:12, density:1, ampMul:1.3);

	rrand(minWait,maxWait).wait;

	//right humming voice
	~humRoutine.value(group:~voiceGrp2,pan:1, meanLen:12, density:1, ampMul:1.3);

	rrand(minWait,maxWait).wait;

	//left whistler
	~whistleRoutine.value(group:~voiceGrp1,pan:-1, meanLen:12, density:1, ampMul:1, bwMin:0.0004, bwMax:0.004);

	rrand(minWait,maxWait).wait;

	//right whistler
	~whistleRoutine.value(group:~voiceGrp2,pan:1, meanLen:12, density:1, ampMul:1, bwMin:0.004, bwMax:0.004);


}).play};
)







