(//Run this code block to set up the composition,
//then evaluate code in "Main Loop.scd" initiate the composition

//Contents:
////1. SERVER CONFIG
////2. GLOBAL VARIABLES
////3. LOAD DATA, FUNCTIONS
////4. HOUSEKEEPING FUNCTIONS
////5. REGISTER FUNCTIONS WITH SERVERBOOT/QUIT/TREE
////6. BOOT SERVER, EVALUATE SYNTHDEFS


///////////////////////////////////////////////////////////////////////////////
//1. SERVER CONFIG//

//a formality
s = Server.local;

//set output device
s.options.outDevice_("Built-in Output");
////see device options by evaluating
//ServerOptions.devices

//set number of output channels
s.options.numOutputBusChannels_(2);

//set sample rate
s.options.sampleRate_(44100);

//set memory allocation
s.options.memSize_(2.pow(20));

//set number of samples per control period (default 64)
s.options.blockSize_(64);

//reset server's bus index counter
s.newBusAllocators;

//remove any functions previously registered with the server
ServerBoot.removeAll;
ServerTree.removeAll;
ServerQuit.removeAll;


///////////////////////////////////////////////////////////////////////////////
//2. GLOBAL VARIABLES//

//first output channel
~out = 0;

//filepath to parent folder
~folder_path = PathName(thisProcess.nowExecutingPath).parentPath;

//filepath to audio files
~audio_path = PathName(thisProcess.nowExecutingPath).parentPath++"buffers/";


///////////////////////////////////////////////////////////////////////////////
//3. LOAD DATA, FUNCTIONS

//Load Data
thisProcess.interpreter.executeFile(~folder_path++"data/lch_dict.scd");
thisProcess.interpreter.executeFile(~folder_path++"data/lch_dict_transitions.scd");
thisProcess.interpreter.executeFile(~folder_path++"data/teb_dict.scd");
thisProcess.interpreter.executeFile(~folder_path++"data/teb_dict_transitions.scd");

~dicts = [~lch_dict, ~teb_dict];


//Define Functions for Piece (
//(as opposed to housekeeping functions defined in section 4)
thisProcess.interpreter.executeFile(~folder_path++"Functions/Permute.scd");
thisProcess.interpreter.executeFile(~folder_path++"Functions/Segment Playback.scd");
thisProcess.interpreter.executeFile(~folder_path++"Functions/Sequence Playback.scd");




///////////////////////////////////////////////////////////////////////////////
//4. HOUSEKEEPING FUNCTIONS

//function to manage audio busses
~makeBusses = {
	~bus = Dictionary.new;

	//reverb bus for all voices
	~bus.add(\reverb -> Bus.audio(s,2));

	~bus.add(\filter1 -> Bus.audio(s,2));
	~bus.add(\filter2 -> Bus.audio(s,2));
	~bus.add(\filter3 -> Bus.audio(s,2));
	~bus.add(\filter4 -> Bus.audio(s,2));
};

//function to clean up busses, etc, upon quiting the server
~cleanup = {
	s.newBusAllocators;//reset server's bus index counter
	ServerBoot.removeAll;
	ServerTree.removeAll;
	ServerQuit.removeAll;
};



//set up audio groups
//not really using the voice groups,
//but might be useful for further development,
~makeNodes = {
	s.bind({
		//groups

		~voiceGrp1 = Group.new(addAction:\addToTail);
		~voiceGrp2 = Group.new(addAction:\addToTail);
		~voiceGrp3 = Group.new(addAction:\addToTail);
		~voiceGrp4 = Group.new(addAction:\addToTail);

		//Group for the reverb, all paths lead here
		~reverbGrp = Group.new(addAction:\addToTail);

		//reberb synth, sole member of the reverb group
		~reverbSynth = Synth.new(
			\reverb,
			[
				\amp, 1,
				\predelay, 0.1,
				\revtime, 3,
				\lpf, 4500,
				\mix, 0.7,
				\in, ~bus[\reverb],
				\out, ~out,
			],
			~reverbGrp
		);
	});
};


///////////////////////////////////////////////////////////////////////////////
//5. REGISTER FUNCTIONS WITH SERVERBOOT/QUIT/TREE

//funtions to evaluate when the server boots:
ServerBoot.add(~makeBusses);

//functions to evaluate when the server quits
ServerQuit.add(~cleanup);//not using this one, was breaking buffer dictionary but now seems ok(?)




///////////////////////////////////////////////////////////////////////////////
//6. BOOT SERVER, EVALUATE SYNTHDEFS
s.waitForBoot({


	//evaluate synthdefs
	s.sync;
	thisProcess.interpreter.executeFile(~folder_path++"Synthdefs/Synthdefs.scd");

	//putting this here because it seems to cause problems if I put earlier w/ the other functions
	thisProcess.interpreter.executeFile(~folder_path++"Functions/Voice Routines.scd");


	//Register remaining functions
	s.sync;
	ServerTree.add(~makeNodes);
	//ServerTree.add(~makeEvents);
	s.freeAll;

	s.sync;
	"done".postln;

});


);




