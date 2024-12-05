// drums.ck

// sound chain
SndBuf hihat => dac;

// me.dirUp 
"hihat_01.wav" => hihat.read;


// parameter setup
.03 => hihat.gain;

BPM tempo;

// loop 
while( true )  
{
    Math.random2f(.9,1.2) => hihat.rate;
    tempo.quarterNote/3 => now;
    0 => hihat.pos;
}
