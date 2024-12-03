// kick.ck

// sound chain

SndBuf kick => dac;
SinOsc sin => dac;
0 => sin.gain;


me.dir(-1) + "audio/kick_04.wav" => kick.read;

// create BPM objcet

BPM tempo;

while(true)
{
    tempo.quarterNote => dur quarter;
    
    // play a loop
    for( 0 => int beat; beat < 4; beat++)
    {
        0 => kick.pos;
        1::quarter => now;
        
    }
     
}
