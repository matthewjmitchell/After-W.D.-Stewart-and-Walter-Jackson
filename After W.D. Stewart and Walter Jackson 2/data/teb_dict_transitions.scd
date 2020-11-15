(
//total of 33 segments (0-32)

//opening motive -
//[0,1,3,20,26] and related [30,31] - "mmm hmm"

//also similar
//[4,6,9] also end of [1], and to a lesser extent end of [0,20,26]- "o-o-oh lord"
//[2,5,10,11,15,21,24,27]... and related [18,24,30]... and somewhat related [12]
//[7,13,16,19,22,25,28,32] - "lord what's done happen to me"
//[14,17] and somewhat similar [8] (long mellismatic hum, but different from opening motive)
//[18,23]

//syllabic(ish)
//[2,5,7,10,11,13,15,16,18,19,21,22,23,24,25,27,28,30,32]

//kind of unique
//[8,12,29,30]



var
low = 1,
med = 8,
high = 32;


//add openers array to the dictionary
//a list of indices of possible segments to start sequence
//don't start w/
~teb_dict.add(\openers->[0,2,5,10,14,15,20,26,27]);

//list of possible indices to end a sequence with
//done end w/
~teb_dict.add(\closers->[0,1,2,4,6,7,9,12,13,16,18,19,22,25,28,29,32]);


//probabilities of a transition from each segment to each segment
//score probabilities from 0-3 then normalize sum
//prob of a segment being immediately repeated is always zero
//prob of segment going to the one it actually goes to in real life is always high
//prob of segment going to a segment that's the same motiv as the one it actually goes to is also high
//prob of segment going to a segment that follows a segment that's the same motiv as this one, also high or med

~teb_dict.add(\transitions->[
	[//from segment 0...
		//segments that are similar to 1 - [1,3,20,26]  - high
		//also kind of similar - [30] - med
		//segments that follow a segment similar to 0 - [2,4,21,27] med, low for 4
		//also sounds good - [10]
		//don't do - []
		0,//to 0
		high,//to 1
		med,//to 2
		high,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		low,//to 7
		low,//to 8
		low,//to 9
		med,//to 10
		med,//to 11
		low,//to 12
		low,//to 13
		med,//to 14
		med,//to 15
		low,//to 16
		med,//to 17
		med,//to 18
		low,//to 19
		high,//to 20
		med,//to 21
		low,//to 22
		med,//to 23
		med,//to 24
		med,//to 25
		high,//to 26
		med,//to 27
		low,//to 28
		low,//to 29
		med,//to 30
		low,//to 31
		0,//to 32

	].normalizeSum,

	[//from segment 1...
		//first part of this segment is opening motive,
		//second part is "o-o-h lord" motive shared w/ [4,6,9]
		//segments that follow [4,6,9] - [5,7,10] - high
		//segments that are similar to 2 - [2,5,10,11,15,21,24,27] - high
		//also sounds good - []
		//don't do - []
		low,//to 0
		0,//to 1
		high,//to 2
		0,//to 3
		0,//to 4
		high,//to 5
		low,//to 6
		high,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		high,//to 11
		low,//to 12
		low,//to 13
		low,//to 14
		high,//to 15
		low,//to 16
		med,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		high,//to 21
		low,//to 22
		low,//to 23
		high,//to 24
		low,//to 25
		low,//to 26
		high,//to 27
		low,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		low,//to 32

	].normalizeSum,

	[//from segment 2...
		//segments that follow those similar to 2 - [3,6,11,12,16,22,25,28] - high
		//in the same motiv class as several of the above [7,13,19,32] - med
		//segments that are similar to 3 - [0,1,3,20,26] - high
		//also sounds good - []
		//don't do - []
		high,//to 0
		high,//to 1
		0,//to 2
		high,//to 3
		0,//to 4
		0,//to 5
		high,//to 6
		med,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		high,//to 11
		high,//to 12
		med,//to 13
		low,//to 14
		0,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		med,//to 19
		high,//to 20
		0,//to 21
		high,//to 22
		low,//to 23
		low,//to 24
		high,//to 25
		high,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 3...
		//segments that follow those similar to 3 - [1,2,4,21,27]
		//- no, don't like these, timing is off
		//segments that are similar to 4 - [4,6,9]
		//(6 sounds a little funny though, timing's not right)
		//also sounds good - [12]
		//don't do - [2,5,6,8,10,11,14,15,17,21,22,24,27,29,32]
		low,//to 0
		low,//to 1
		0,//to 2
		0,//to 3
		high,//to 4
		0,//to 5
		0,//to 6
		low,//to 7
		0,//to 8
		high,//to 9
		0,//to 10
		0,//to 11
		med,//to 12
		low,//to 13
		0,//to 14
		0,//to 15
		low,//to 16
		0,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		0,//to 21
		0,//to 22
		low,//to 23
		0,//to 24
		low,//to 25
		low,//to 26
		0,//to 27
		low,//to 28
		0,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 4...
		//segments that follow those similar to 4 - [2,5,7,10] - high
		//segments that are similar to 5 - [2,5,10,11,15,21,24,27] - high
		//similar to 7 ("what's done happen" motive) - [13,16,19,22,25,28,32] - med
		//also sounds good - []
		//don't do - [3,6,8,9]
		low,//to 0
		low,//to 1
		high,//to 2
		0,//to 3
		0,//to 4
		high,//to 5
		0,//to 6
		high,//to 7
		0,//to 8
		0,//to 9
		high,//to 10
		high,//to 11
		low,//to 12
		med,//to 13
		low,//to 14
		high,//to 15
		med,//to 16
		low,//to 17
		low,//to 18
		med,//to 19
		low,//to 20
		high,//to 21
		med,//to 22
		low,//to 23
		high,//to 24
		med,//to 25
		low,//to 26
		high,//to 27
		med,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 5...
		//segments that follow those similar to 5 - [3,6,11,12,16,22,25,28] - high
		//similar to some of above ("lord what's done..." motive)- [7,13,19,32] - high
		//segments that are similar to 6 ("o-o-oh lord")- [4,9] - high
		//also sounds good - [17,18,23]
		//don't do - []
		low,//to 0
		low,//to 1
		low,//to 2
		high,//to 3
		high,//to 4
		0,//to 5
		high,//to 6
		high,//to 7
		low,//to 8
		high,//to 9
		low,//to 10
		high,//to 11
		high,//to 12
		high,//to 13
		low,//to 14
		low,//to 15
		high,//to 16
		med,//to 17
		med,//to 18
		high,//to 19
		low,//to 20
		low,//to 21
		high,//to 22
		med,//to 23
		med,//to 24
		high,//to 25
		low,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 6...
		//segments that follow those similar to 6 - [5,7,10] - high
		//segments that are similar to 7 ("lord what's done...")- [13,16,19,22,25,28,32] - high
		//also sounds good - [17,18,24]
		//don't do - [4,9]
		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		0,//to 4
		high,//to 5
		0,//to 6
		high,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		low,//to 11
		low,//to 12
		high,//to 13
		low,//to 14
		low,//to 15
		high,//to 16
		med,//to 17
		med,//to 18
		high,//to 19
		low,//to 20
		low,//to 21
		high,//to 22
		low,//to 23
		med,//to 24
		high,//to 25
		low,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 7...
		//segments that follow those similar to 7 - [8,14,17,20,23,26,29] - high
		//similar to some of the above (opening motive) - [0,1,3] - med
		//also similar to one of the above (namely 23) - [18] - med
		//segments that are similar to 8 - [14,17] - high
		//also sounds good - [24]
		//don't do other instances of "lord what's done happen..." motive - [13,16,19,22,25,28,32]
		//also don't do - [4,6,9]
		med,//to 0
		med,//to 1
		low,//to 2
		med,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		med,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		med,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 8...
		//segments that follow those similar to 8 - [9,15,18]
		//segments that are similar to 9 - [4,6]
		//also sounds good - [7,12,13,19,23,24]
		//don't do - [0,1,3,14,20,26,]
		0,//to 0
		0,//to 1
		low,//to 2
		0,//to 3
		high,//to 4
		low,//to 5
		high,//to 6
		med,//to 7
		0,//to 8
		high,//to 9
		low,//to 10
		low,//to 11
		med,//to 12
		med,//to 13
		0,//to 14
		low,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		med,//to 19
		0,//to 20
		low,//to 21
		low,//to 22
		med,//to 23
		med,//to 24
		low,//to 25
		0,//to 26
		low,//to 27
		low,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		low,//to 32
	].normalizeSum,

	[//from segment 9...
		//9 is virtually identical to segment 4, so just copying those probabilities
		low,//to 0
		low,//to 1
		high,//to 2
		0,//to 3
		0,//to 4
		high,//to 5
		0,//to 6
		high,//to 7
		0,//to 8
		0,//to 9
		high,//to 10
		high,//to 11
		low,//to 12
		med,//to 13
		low,//to 14
		high,//to 15
		med,//to 16
		low,//to 17
		low,//to 18
		med,//to 19
		low,//to 20
		high,//to 21
		med,//to 22
		low,//to 23
		high,//to 24
		med,//to 25
		low,//to 26
		high,//to 27
		med,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 10...
		//segments that follow those similar to 10 - [3,6,11,12,16,22,25,28] - high
		//similar to above, other instances of "lord what's done..." motive - [7,13,19,32] - high
		//also sounds good - [17,18,23,24]
		//don't do - [5,15,21]
		low,//to 0
		low,//to 1
		low,//to 2
		high,//to 3
		low,//to 4
		0,//to 5
		high,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		0,//to 10
		high,//to 11
		high,//to 12
		high,//to 13
		low,//to 14
		0,//to 15
		high,//to 16
		med,//to 17
		med,//to 18
		high,//to 19
		low,//to 20
		0,//to 21
		high,//to 22
		med,//to 23
		med,//to 24
		high,//to 25
		low,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32

	].normalizeSum,

	[//from segment 11...
		//segments that follow those similar to 11 - [3,6,12,16,22,25,28] - high
		//similar to above, other instances of "lord what's done..." motive - [7,13,19,32] - high
		//also sounds good - [17,18,23,24,31] - med
		//don't do - [5,10]
		low,//to 0
		low,//to 1
		low,//to 2
		high,//to 3
		low,//to 4
		0,//to 5
		high,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		0,//to 10
		0,//to 11
		high,//to 12
		high,//to 13
		low,//to 14
		low,//to 15
		high,//to 16
		med,//to 17
		med,//to 18
		high,//to 19
		low,//to 20
		low,//to 21
		high,//to 22
		med,//to 23
		med,//to 24
		high,//to 25
		low,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		med,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 12...
		//segments that are similar to 13 - [7,13,16,19,22,25,28,32] - high
		//also sounds good - [18,23,24] - med
		//don't do - []
		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		low,//to 10
		low,//to 11
		0,//to 12
		high,//to 13
		low,//to 14
		low,//to 15
		high,//to 16
		low,//to 17
		med,//to 18
		high,//to 19
		low,//to 20
		low,//to 21
		high,//to 22
		med,//to 23
		med,//to 24
		high,//to 25
		low,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 13...
		//segments that follow those similar to 13 - [8,14,17,20,23,26,29] - high
		//similar to 20,26 above, opening motive - [0,1,3] - high
		//similar to 23 above - [18] - high
		//also sounds good - []
		//don't do other instances of "lord what's done happen..." motive - [7,13,16,19,22,25,28,32]
		//also don't do - [4,6,9]
		high,//to 0
		high,//to 1
		low,//to 2
		high,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		high,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 14...
		//segments that follow those similar to 14 - [15,18] - high
		//segments that are similar to 15 - [2,5,10,11,15,21,24,27] - high
		//also sounds good - [13,16,17,19,22,23,25]
		//don't do - [4,9,29,32]
		low,//to 0
		low,//to 1
		high,//to 2
		low,//to 3
		0,//to 4
		high,//to 5
		low,//to 6
		low,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		high,//to 11
		low,//to 12
		med,//to 13
		0,//to 14
		high,//to 15
		med,//to 16
		med,//to 17
		high,//to 18
		med,//to 19
		low,//to 20
		high,//to 21
		med,//to 22
		med,//to 23
		high,//to 24
		med,//to 25
		low,//to 26
		high,//to 27
		low,//to 28
		0,//to 29
		low,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 15...
		//basically the same as 2. Copying those probabilities
		high,//to 0
		high,//to 1
		0,//to 2
		high,//to 3
		0,//to 4
		0,//to 5
		high,//to 6
		med,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		high,//to 11
		high,//to 12
		med,//to 13
		low,//to 14
		0,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		med,//to 19
		high,//to 20
		0,//to 21
		high,//to 22
		low,//to 23
		low,//to 24
		high,//to 25
		high,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 16...
		//same as 7
		high,//to 0
		high,//to 1
		low,//to 2
		high,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		high,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 17...
		//similar to 14, copying those probs and modifying slightly
		//so 14 can go to 17 and vice versa, but neither can be repeated
		low,//to 0
		low,//to 1
		high,//to 2
		low,//to 3
		0,//to 4
		high,//to 5
		low,//to 6
		low,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		high,//to 11
		low,//to 12
		med,//to 13
		med,//to 14
		high,//to 15
		med,//to 16
		0,//to 17
		high,//to 18
		med,//to 19
		low,//to 20
		high,//to 21
		med,//to 22
		med,//to 23
		high,//to 24
		med,//to 25
		low,//to 26
		high,//to 27
		low,//to 28
		0,//to 29
		low,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 18...
		//segments that follow those similar to 18 - [24] - high
		//similar to 24 - [2,5,10,11,15,21,27] - med
		//segments that are similar to 19 - [7,13,16,19,22,25,28,32] - high
		//also sounds good - []
		//don't do - []
		low,//to 0
		low,//to 1
		med,//to 2
		low,//to 3
		low,//to 4
		med,//to 5
		low,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		low,//to 10
		med,//to 11
		low,//to 12
		high,//to 13
		low,//to 14
		med,//to 15
		high,//to 16
		low,//to 17
		0,//to 18
		high,//to 19
		low,//to 20
		low,//to 21
		high,//to 22
		low,//to 23
		high,//to 24
		high,//to 25
		low,//to 26
		med,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 19...
		//same as 7
		high,//to 0
		high,//to 1
		low,//to 2
		high,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		high,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,


	[//from segment 20...
		//copied from 0, modified to reduce chance of motivic repetition
		//repetition likely from 0, but less so from 3,20,26
		low,//to 0
		high,//to 1
		med,//to 2
		0,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		low,//to 7
		low,//to 8
		low,//to 9
		med,//to 10
		med,//to 11
		low,//to 12
		low,//to 13
		med,//to 14
		med,//to 15
		low,//to 16
		med,//to 17
		med,//to 18
		low,//to 19
		0,//to 20
		med,//to 21
		low,//to 22
		med,//to 23
		med,//to 24
		med,//to 25
		0,//to 26
		med,//to 27
		low,//to 28
		low,//to 29
		med,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,


	[//from segment 21...
		//segments that follow those similar to 21 - [3,6,11,12,16,22,25,28] - high
		//(except low on 3)
		//segments that are similar to 22 - [7,13,16,19,22,25,28,32] - high
		//also sounds good - [17,18,23,24]
		//don't do - [4,9]
		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		0,//to 4
		low,//to 5
		high,//to 6
		high,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		high,//to 11
		high,//to 12
		high,//to 13
		low,//to 14
		low,//to 15
		high,//to 16
		med,//to 17
		med,//to 18
		high,//to 19
		low,//to 20
		0,//to 21
		high,//to 22
		med,//to 23
		high,//to 24
		high,//to 25
		low,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 22...
		//same as 7
		high,//to 0
		high,//to 1
		low,//to 2
		high,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		high,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 23...
		//segments that follow those similar to 23 - [19] - high
		//segments that are similar to 24 - [2,5,10,11,15,21,24,27]
		//also sounds good - [7,13,16,17,18,19,22,25,28,30,32]
		//don't do - [4,9]
		low,//to 0
		low,//to 1
		high,//to 2
		low,//to 3
		0,//to 4
		high,//to 5
		low,//to 6
		med,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		high,//to 11
		low,//to 12
		med,//to 13
		low,//to 14
		high,//to 15
		med,//to 16
		med,//to 17
		med,//to 18
		high,//to 19
		low,//to 20
		high,//to 21
		med,//to 22
		0,//to 23
		high,//to 24
		med,//to 25
		low,//to 26
		high,//to 27
		med,//to 28
		low,//to 29
		med,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 24...
		//segments that follow those similar to 24 - [3,6,11,12,16,22,25,28] - med, or high
		//similar to 25 - "lord what's done happen" - [7,13,16,19,22,25,28,32] - high
		//also sounds good - [23]
		//don't do - []
		low,//to 0
		low,//to 1
		low,//to 2
		med,//to 3
		low,//to 4
		low,//to 5
		med,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		low,//to 10
		med,//to 11
		med,//to 12
		high,//to 13
		low,//to 14
		low,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		high,//to 19
		low,//to 20
		low,//to 21
		high,//to 22
		med,//to 23
		0,//to 24
		high,//to 25
		low,//to 26
		low,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 25...
		//same as 7
		high,//to 0
		high,//to 1
		low,//to 2
		high,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		high,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 26...
				//copied from 0, modified to reduce chance of motivic repetition
		//repetition likely from 0, but less so from 3,20,26
		low,//to 0
		high,//to 1
		med,//to 2
		0,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		low,//to 7
		low,//to 8
		low,//to 9
		med,//to 10
		med,//to 11
		low,//to 12
		low,//to 13
		med,//to 14
		med,//to 15
		low,//to 16
		med,//to 17
		med,//to 18
		low,//to 19
		0,//to 20
		med,//to 21
		low,//to 22
		med,//to 23
		med,//to 24
		med,//to 25
		0,//to 26
		med,//to 27
		low,//to 28
		low,//to 29
		med,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 27...
		//basically the same as 24, copying probs with minor changes
		low,//to 0
		low,//to 1
		low,//to 2
		med,//to 3
		low,//to 4
		low,//to 5
		med,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		low,//to 10
		med,//to 11
		med,//to 12
		high,//to 13
		low,//to 14
		low,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		high,//to 19
		low,//to 20
		low,//to 21
		high,//to 22
		med,//to 23
		low,//to 24
		high,//to 25
		low,//to 26
		0,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		low,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 28...
		//same as 7
		high,//to 0
		high,//to 1
		low,//to 2
		high,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		high,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,

	[//from segment 29...
		//segments that follow those similar to 29 - none
		//segments that are similar to 30 - none
		//also sounds good - [7,13,16,19,22,25,28,32] - med
		//don't do - []
		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		med,//to 7
		low,//to 8
		low,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		med,//to 13
		low,//to 14
		low,//to 15
		med,//to 16
		low,//to 17
		low,//to 18
		med,//to 19
		low,//to 20
		low,//to 21
		med,//to 22
		low,//to 23
		low,//to 24
		med,//to 25
		low,//to 26
		low,//to 27
		med,//to 28
		0,//to 29
		high,//to 30
		low,//to 31
		med,//to 32
	].normalizeSum,

	[//from segment 30...
		//very similar to 31... copying those probs with minor changes
		low,//to 0
		med,//to 1
		med,//to 2
		low,//to 3
		low,//to 4
		med,//to 5
		med,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		med,//to 10
		med,//to 11
		low,//to 12
		high,//to 13
		low,//to 14
		med,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		high,//to 19
		low,//to 20
		med,//to 21
		high,//to 22
		low,//to 23
		med,//to 24
		high,//to 25
		low,//to 26
		med,//to 27
		high,//to 28
		low,//to 29
		0,//to 30
		high,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 31...
		//segments that follow those similar to 31 - [1,2,21,27] - med
		//similar to 2,21,27 above  - [5,10,11,15,24] - med
		//segments that are similar to 32 - [7,13,16,19,22,25,28,32] - high
		//also sounds good - [6]
		//don't do - []
		low,//to 0
		med,//to 1
		med,//to 2
		low,//to 3
		low,//to 4
		med,//to 5
		med,//to 6
		high,//to 7
		low,//to 8
		low,//to 9
		med,//to 10
		med,//to 11
		low,//to 12
		high,//to 13
		low,//to 14
		med,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		high,//to 19
		low,//to 20
		med,//to 21
		high,//to 22
		low,//to 23
		med,//to 24
		high,//to 25
		low,//to 26
		med,//to 27
		high,//to 28
		low,//to 29
		low,//to 30
		0,//to 31
		high,//to 32
	].normalizeSum,

	[//from segment 32...
		//same as 7
		high,//to 0
		high,//to 1
		low,//to 2
		high,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		0,//to 16
		high,//to 17
		high,//to 18
		0,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
		high,//to 26
		low,//to 27
		0,//to 28
		high,//to 29
		low,//to 30
		low,//to 31
		0,//to 32
	].normalizeSum,
]
);


)












