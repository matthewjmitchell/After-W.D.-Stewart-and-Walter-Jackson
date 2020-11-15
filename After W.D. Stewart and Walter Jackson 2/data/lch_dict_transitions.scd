(
var
//relative values of probability categories:
low = 1,
med = 8,
high = 32;


//add openers and closers arrays to the dictionary
//
//openers is an list of indices of possible segments to start sequence with
//don't start w/ 5,6,7,8,9,13,16,17,19,20,23,24,25
~lch_dict.add(\openers->[0,1,2,3,11,15,21,22]);

//closers is an array of possible indices to end a sequence with
//done end w/ 4,5,6,7,8,12,13,16,18,22,
~lch_dict.add(\closers->[0,1,2,3,9,10,11,14,15,19,20,21,23]);


//probabilities of a transition from each segment to each segment
//designate each transition probabilitity as 0, low, med, or high, then normalize sum
//prob of a segment being immediately repeated is always zero
//prob of segment going to the one it actually goes to in real life is always high
//prob of segment going to a segment that's the same "motive class" as the one it actually goes to is med or high
//Remaining transitions are evaluated subjectively and assigned
// • A probability of 0 if judged to sound "wrong"
// • A probability of med or high if judged to sound especially convincing or compelling
// • Or otherwise, a probability of low if judged to sound acceptable

~lch_dict.add(\transitions->[
	[//from segment 0...
		//segments that are very similar to 1 - [0,1,2,15,21]
		//segments that are pretty similar to 1 - [3,11]
		//don't do - [7,9,13,17,25]
		0,//to 0
		high,//to 1
		high,//to 2
		med,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		med,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		high,//to 15
		low,//to 16
		0,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		high,//to 21
		low,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 1...
		//segments that are very similar to 2 - [0,2,]
		//segments that are pretty similar to 2 - [3,11,15,2]
		//don't do - [7,9,13,17,25]

		high,//to 0
		0,//to 1
		high,//to 2
		med,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		med,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		med,//to 15
		low,//to 16
		0,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		med,//to 21
		low,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 2...
		//segments that are very similar to 3 - [3,11,15,21]
		//segments that are pretty similar to 3 - [0,1]
		//don't do - [7,9,13,17,25]

		med,//to 0
		med,//to 1
		0,//to 2
		high,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		high,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		high,//to 15
		1,//to 16
		0,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		high,//to 21
		low,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 3...
		//segments that are very similar to 4 - [4,5,10,12,14,16]
		//segments that are pretty similar to 4 - [18,22]
		//don't do - [7,9,13,17,25]
		//also don't go to 11, because it's so similar it sounds almost like exact repetition
		//15 and 21 sound great though

		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		high,//to 4
		high,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		0,//to 11
		high,//to 12
		0,//to 13
		high,//to 14
		med,//to 15
		high,//to 16
		0,//to 17
		med,//to 18
		low,//to 19
		low,//to 20
		med,//to 21
		med,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 4...
		//segments that are very similar to 5 - [5,10,12,14,16]
		//segments that are pretty similar to 5 - [18,20,22]
		//don't do - [7,9,13,17,25]

		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		low,//to 4
		high,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		low,//to 11
		high,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		high,//to 16
		0,//to 17
		med,//to 18
		low,//to 19
		med,//to 20
		low,//to 21
		med,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 5...
		//segments that are very similar to 6,7 - [8,19,20]
		//segments that are pretty similar to 6,7 - [4,10,12,14,16,18,22]
		//don't do? - [7,9,13,17,25]

		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		med,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		med,//to 10
		low,//to 11
		med,//to 12
		0,//to 13
		med,//to 14
		low,//to 15
		med,//to 16
		0,//to 17
		med,//to 18
		high,//to 19
		high,//to 20
		low,//to 21
		med,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 6...
		//really just a pickup to 7
		//also throwing in 17


		0,//to 0
		0,//to 1
		0,//to 2
		0,//to 3
		0,//to 4
		low,//to 5
		0,//to 6
		high,//to 7
		0,//to 8
		med,//to 9
		0,//to 10
		0,//to 11
		0,//to 12
		0,//to 13
		0,//to 14
		0,//to 15
		0,//to 16
		low,//to 17
		0,//to 18
		0,//to 19
		0,//to 20
		0,//to 21
		0,//to 22
		0,//to 23
		0,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 7...
		//segments that are very similar to 8,9 - [6,8]
		//also sounds pretty good going to - [5,10,13,17,19,20]
		//don't do? - [0,1,2,3,25]

		0,//to 0
		0,//to 1
		0,//to 2
		low,//to 3
		low,//to 4
		med,//to 5
		med,//to 6
		0,//to 7
		high,//to 8
		0,//to 9
		med,//to 10
		1,//to 11
		0,//to 12
		med,//to 13
		low,//to 14
		low,//to 15
		low,//to 16
		med,//to 17
		low,//to 18
		med,//to 19
		med,//to 20
		low,//to 21
		low,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 8...
		//really just a pickup to 9
		//interchangeable with 6, so could go to 7,
		//also throwing in 17


		0,//to 0
		0,//to 1
		0,//to 2
		0,//to 3
		0,//to 4
		0,//to 5
		0,//to 6
		med,//to 7
		0,//to 8
		high,//to 9
		0,//to 10
		0,//to 11
		0,//to 12
		0,//to 13
		0,//to 14
		0,//to 15
		0,//to 16
		low,//to 17
		0,//to 18
		0,//to 19
		0,//to 20
		0,//to 21
		0,//to 22
		0,//to 23
		0,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 9...
		//segments that are very similar to 10 - [10,16]
		//segments that are pretty similar to 10 - [4,10,12,14,18,19,20,22  ]
		//don't do? - [7,9,13,17,25]

		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		med,//to 4
		low,//to 5
		0,//to 6
		0,//to 7
		0,//to 8
		0,//to 9
		high,//to 10
		low,//to 11
		med,//to 12
		0,//to 13
		med,//to 14
		low,//to 15
		high,//to 16
		0,//to 17
		med,//to 18
		med,//to 19
		med,//to 20
		low,//to 21
		med,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 10...
		//segments that are very similar to 11 - [3,11,15,21]
		//segments that are pretty similar to 11 - [0,1,2]
		//don't do - [7,9,13,17,25]

		med,//to 0
		med,//to 1
		med,//to 2
		high,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		0,//to 10
		high,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		high,//to 15
		low,//to 16
		0,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		high,//to 21
		low,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 11...
		//segments that are very similar to 12 - [12]
		//segments that are pretty similar to 12 - [4,10,16,18]
		//3 sounds too similar to 11, but 15 and 21 sound great
		//don't do? - [7,9,13,17,25]

		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		med,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		med,//to 10
		0,//to 11
		high,//to 12
		0,//to 13
		low,//to 14
		med,//to 15
		med,//to 16
		0,//to 17
		med,//to 18
		low,//to 19
		low,//to 20
		med,//to 21
		low,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 12...
		//segments that are very similar to 13 - [5,13,17,23]
		//also sounds good - [1,3,4,10,11,15,16,19]
		//don't do? - [0,2,9,13,17]

		0,//to 0
		med,//to 1
		0,//to 2
		med,//to 3
		med,//to 4
		high,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		med,//to 10
		med,//to 11
		0,//to 12
		high,//to 13
		low,//to 14
		med,//to 15
		med,//to 16
		high,//to 17
		low,//to 18
		med,//to 19
		low,//to 20
		low,//to 21
		low,//to 22
		high,//to 23
		0,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 13...
		//segments that are very similar to 14 - [14,17]
		//also sounds good - [5,10,18,19,20,21,22,23]

		0,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		low,//to 4
		high,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		low,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		high,//to 14
		low,//to 15
		low,//to 16
		high,//to 17
		med,//to 18
		med,//to 19
		med,//to 20
		med,//to 21
		med,//to 22
		med,//to 23
		0,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 14...
		//segments that are very similar to 15 - [3,11,15,21]
		//this one's pretty flexible.
		//don't do - [7,9,13,17,25]

		low,//to 0
		low,//to 1
		low,//to 2
		high,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		high,//to 11
		low,//to 12
		0,//to 13
		0,//to 14
		high,//to 15
		0,//to 16
		0,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		high,//to 21
		low,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 15...
		//segments that are very similar to 16 - [10,14,16,18]
		//segments that follow those similar to 15 - [4,12,22]
		//salso sounds good - [1,3,11,19,21]
		//don't do? - [7,9,13,17,25]

		low,//to 0
		med,//to 1
		low,//to 2
		med,//to 3
		high,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		high,//to 10
		med,//to 11
		high,//to 12
		0,//to 13
		high,//to 14
		0,//to 15
		high,//to 16
		0,//to 17
		low,//to 18
		med,//to 19
		low,//to 20
		med,//to 21
		high,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 16...
		//segments that are very similar to 17 - [4,12,13,17,23]
		//also sounds good - [3,11,14,15,,18,19,10,21,22]
		//don't do? - [9,13,17]

		0,//to 0
		low,//to 1
		low,//to 2
		high,//to 3
		high,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		high,//to 11
		high,//to 12
		high,//to 13
		med,//to 14
		high,//to 15
		0,//to 16
		high,//to 17
		med,//to 18
		med,//to 19
		med,//to 20
		high,//to 21
		med,//to 22
		high,//to 23
		0,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 17...
		//segments that are  similar to 18 - [5,18,,23]
		//also sounds good - [3,11,15,16,19,20,21,22]
		//don't do? - [9,13,17,25]

		low,//to 0
		low,//to 1
		low,//to 2
		med,//to 3
		low,//to 4
		med,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		med,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		med,//to 15
		med,//to 16
		0,//to 17
		high,//to 18
		med,//to 19
		med,//to 20
		med,//to 21
		med,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 18...
		//segments that are very similar to 19 - [5,9,13,17,19,20]
		//also sounds good - [1,11,15,21,22,23]
		//don't do? - [9,13,17]

		0,//to 0
		med,//to 1
		low,//to 2
		low,//to 3
		low,//to 4
		high,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		high,//to 9
		0,//to 10
		med,//to 11
		0,//to 12
		high,//to 13
		0,//to 14
		med,//to 15
		low,//to 16
		high,//to 17
		0,//to 18
		high,//to 19
		high,//to 20
		med,//to 21
		med,//to 22
		med,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 19...
		//segments that are similar to 20 - [20,22,23]
		//also sounds good - [1,3,9,11,15,21]
		//don't do? - [7,13,25]

		low,//to 0
		med,//to 1
		low,//to 2
		med,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		high,//to 9
		0,//to 10
		med,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		med,//to 15
		low,//to 16
		low,//to 17
		low,//to 18
		0,//to 19
		high,//to 20
		med,//to 21
		high,//to 22
		high,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 20...
		//segments that are very similar to 21 - [3,11,15,21]
		//segments that good - [0,1,2,19,22,23]
		//don't do? - [7,9,13,17,25]

		med,//to 0
		med,//to 1
		med,//to 2
		high,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		high,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		high,//to 15
		low,//to 16
		low,//to 17
		low,//to 18
		med,//to 19
		0,//to 20
		high,//to 21
		med,//to 22
		med,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 21...
		//segments that follow those similar to 21 - [4,12,16]
		//segments that are similar to 22 - [22]
		//also sounds good - [1,2,10,15]
		//don't do? - [7,9,13]

		low,//to 0
		med,//to 1
		med,//to 2
		low,//to 3
		high,//to 4
		0,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		med,//to 10
		low,//to 11
		high,//to 12
		0,//to 13
		low,//to 14
		med,//to 15
		high,//to 16
		low,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		0,//to 21
		high,//to 22
		low,//to 23
		low,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 22...
		//segments that are  similar to 23 - [5,13,17,19,20,23]
		//also sounds good - [1,3,11,14,16,18]
		//don't do? - []

		0,//to 0
		high,//to 1
		0,//to 2
		med,//to 3
		low,//to 4
		high,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		med,//to 11
		0,//to 12
		high,//to 13
		med,//to 14
		med,//to 15
		med,//to 16
		high,//to 17
		med,//to 18
		high,//to 19
		high,//to 20
		low,//to 21
		0,//to 22
		high,//to 23
		0,//to 24
		0,//to 25
	].normalizeSum,

		[//from segment 23...
		//sounds good - [1,3,11,15,18,21]
		//don't do? - [7,9,13,14,17,25]

		low,//to 0
		med,//to 1
		low,//to 2
		med,//to 3
		low,//to 4
		low,//to 5
		med,//to 6
		0,//to 7
		med,//to 8
		0,//to 9
		low,//to 10
		med,//to 11
		low,//to 12
		0,//to 13
		med,//to 14
		med,//to 15
		low,//to 16
		low,//to 17
		med,//to 18
		low,//to 19
		low,//to 20
		med,//to 21
		low,//to 22
		0,//to 23
		high,//to 24
		0,//to 25
	].normalizeSum,

	[//from segment 24...

		0,//to 0
		0,//to 1
		0,//to 2
		0,//to 3
		0,//to 4
		0,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		0,//to 10
		0,//to 11
		0,//to 12
		0,//to 13
		0,//to 14
		0,//to 15
		0,//to 16
		0,//to 17
		0,//to 18
		0,//to 19
		0,//to 20
		0,//to 21
		0,//to 22
		0,//to 23
		0,//to 24
		high,//to 25
	].normalizeSum,

		[//from segment 25...
		//don't do? - [7,9,13,17,24,25]

		low,//to 0
		low,//to 1
		low,//to 2
		low,//to 3
		low,//to 4
		low,//to 5
		low,//to 6
		0,//to 7
		low,//to 8
		0,//to 9
		low,//to 10
		low,//to 11
		low,//to 12
		0,//to 13
		low,//to 14
		low,//to 15
		low,//to 16
		0,//to 17
		low,//to 18
		low,//to 19
		low,//to 20
		low,//to 21
		low,//to 22
		low,//to 23
		0,//to 24
		0,//to 25
	].normalizeSum,


]
);


)



















