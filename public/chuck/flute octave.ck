// flute.ck
// Our famous headliner flute solo (with EFX)

NRev rev;
Flute solo => rev => dac;

0.1 => rev.mix;
0.1 => solo.gain;
BPM tempo;

// shared jazz scale data
[57,60,57,55,52,48,51,50,
57,60,57,55,52,48,51,50,
57,60,57,55,52,48,51,50,
43,46,48,52,48,40,43,41] @=> int scale[];

0 => int notePos;
0.5 => float rand; 


// then our main loop headliner flute soloist
for (0 => int i; i < 4; i++)
{

    1::tempo.quarterNote => now;
    note(2);
    note(1);
    note(2);
    note(1);
    note(2);
    note(1);
    note(2);
    note(4);
    0 => solo.noteOn;

    2::tempo.quarterNote => now;


    
    
}

function note(int trip) {
    Math.mtof(36+scale[notePos])=> solo.freq;
    Math.random2(0,1) => int rand;
    
    Math.random2f(0.3,1.0) => solo.noteOn;
        
        if (rand == 1){
            trip::(tempo.quarterNote/6) => now;
            0 => solo.noteOn;

            trip::(tempo.quarterNote/6) => now;

        } else {
            trip::(tempo.quarterNote/3) => now;
            0 => solo.noteOn;


        }
        
        notePos++;
}
    
        

