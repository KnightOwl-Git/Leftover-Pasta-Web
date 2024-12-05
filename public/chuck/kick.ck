// kick.ck

// sound chain

SndBuf kick => dac;

0.2 => kick.gain;


"kick_04.wav" => kick.read;

// create BPM objcet
///
BPM tempo;
tempo.quarterNote => dur quarter;


while(true)
{
    
    // play a loop
    for( 0 => int beat; beat < 4; beat++)
    {
        0 => kick.pos;
        1::quarter => now;
        
    }
     
}
