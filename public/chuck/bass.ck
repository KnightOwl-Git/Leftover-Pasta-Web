// bass.ck
// sound chain (mandolin for bass)
Mandolin bass => NRev r => dac;


[[45,48,52, 55],[50,42, 45,60], [45,48,52, 55], [38,42, 45,60], [45,48,52, 55], [50,42, 45,60], [43,46,48, 50], [41,45,48,52],[40,44,47,50]] @=> int scale[][];


// parameter setup
0.1 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
0 => int walkPos;
.1 => bass.gain;
0 => int chordPos;
0 => int chordCounter;

BPM tempo;

// loop
while( true )  
{
    Math.random2(-1,1) +=> walkPos; 
    
    if (walkPos < 0) 0 => walkPos;
    if (walkPos > 3) 0 => walkPos;
    
    
    
       
    
    
    chordCounter++;
    
    
    <<<"chordCounter:", chordCounter, "chordPos:", chordPos, "walkPos:", walkPos>>>;
    Std.mtof(scale[chordPos][walkPos]-12) => bass.freq;
    
    Math.random2f(0.05,0.5) => bass.pluckPos;
    1 => bass.noteOn;
    0.9 :: tempo.quarterNote => now;
    1 => bass.noteOff;
    0.1 :: tempo.quarterNote => now;
    
    
    if (chordCounter == 4) 
    {
        chordPos++;
        0 => chordCounter;
        
    } 
    if (chordPos >= 8)
    {
        0 => chordPos;
    }
    walkPos++;
    
    
    
    
    
}


