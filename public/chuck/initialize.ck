//initialize.ck

SinOsc osc => dac; 
0.1 => osc.gain;
SndBuf hey => dac;

me.dir() + "voice/toni/have/3.wav" => hey.read;

1::second => now;

// conductor class
<<<"hello">>>;
Machine.add("BPM.ck");

// score
Machine.add("score.ck");