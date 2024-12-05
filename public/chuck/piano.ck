// piano.ck
// sound chain
Gain pGain => dac;
Rhodey piano[4];
piano[0] => pGain;
piano[1] => pGain;
piano[2] => pGain;
piano[3] => pGain;

0.1 => pGain.gain;

BPM tempo;



// chord 2D array
[[45,48,52, 55],[50,42, 45,60], [45,48,52, 55], [38,42, 45,60], [45,48,52, 55], [50,42, 45,60], [43,46,48, 50], [41,45,48,52],[40,44,47,50]] @=> int chordz[][];



0 => int chordCount;
// loop 
while( true )  
{
    // build first chord
    for( 0 => int i; i < 4; i++ )  
    {
        Std.mtof(chordz[chordCount][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
        
    }
    5::(tempo.halfNote/6) => now;
    // build second chord
    for( 0 => int i; i < 4; i++ )  
    {
        Math.mtof(chordz[chordCount][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
    }
    1::(tempo.halfNote/6) => now;
    for( 0 => int i; i < 4; i++ )  
    {
        1 => piano[i].noteOff;
    }

    1::tempo.halfNote => now;
       
    
    chordCount++;
    
    if (chordCount >= 8)
    {
        0 => chordCount;
    }

    
}
