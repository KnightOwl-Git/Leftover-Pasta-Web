//initialize.ck
//NOT USING THIS ANYMORE

SinOsc osc => dac; 
0.2 => osc.gain;
SndBuf hey => dac;

1::second => now;

// conductor class
<<<"hello">>>;
Machine.add("BPM.ck");

// score
Machine.add("score.ck");