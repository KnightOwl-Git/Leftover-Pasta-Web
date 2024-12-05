// main.ck

//events for triggering UI stuff
global Event uiSyllable;

global Event startPlayhead;
global Event changeActive;
global Event reset;
global Event talk;
global Event sad;
global Event hold;
global Event toniReset;
global Event checkBPM;
global Event theEnd;

//global variable trackers
false => global int perfectRN;
0 => global int syllableRN;
0 => global int syllBroadcast;
120 => global int beatsPM; // global beats per minute of project

Gain voices => dac;

SndBuf toni => voices;
SndBuf player => voices;
0.15 => voices.gain;

// initialize BPM class - I had to put the code in this file for annoying reasons

// BPM.ck
public class BPM
{
    
    // global member variable
    
    static dur wholeNote, halfNote, quarterNote, eighthNote, sixteenthNote, thirtysecondNote;
    
    dur noteArray[6];
    
    //[wholeNote, halfNote, quarterNote, eighthNote, sixteenthNote, thirtysecondNote] @=> noteArray;   
    
    //time signature 
    
    fun void tempo(float BPM, int sigTop, int sigBottom)
    {
        // beat is BPM, example 120 beats per minute
        
        60.0/(BPM) => float SPB; // second per beat
        
        //set each note type's duration using really fucking weird math that took me hours to figure out
         
        for (0 => int i; i < noteArray.size(); i++) {
            (SPB::second)*((sigBottom/(Math.pow(2,i-1)))/2) => noteArray[i];
        }   
        
        //set durations to the values in the array
        
        noteArray[0] => wholeNote;
        noteArray[1] => halfNote;
        noteArray[2] => quarterNote;
        noteArray[3] => eighthNote;
        noteArray[4] => sixteenthNote;
        noteArray[5] => thirtysecondNote;
    }
}
BPM tempo;
tempo.tempo(beatsPM, 4, 4);

false => int yourTurn;

//current said item
global int say;
//current real item
global int real;

//declare random variables for later
Math.random2(0,5) => int mRand;
Math.random2(0,3) => int iRand; 




//amount of time for perfect button presses
20::ms => dur perfect;

//account for input delay
5::ms => dur delay;

if (perfect > tempo.halfNote/6) {
    //making sure the perfect zone can't be longer than the beats
    tempo.halfNote/6 >= perfect;
}



//run a little bit before the real game starts

SinOsc osc => dac; 
0.2 => osc.gain;
SndBuf hey => dac;
2::second => now;
0 => osc.gain;

// initialize score
Machine.add("score.ck");








//=============== MOUSE AND KEYBOARD INPUT ================

//set up keyboard input
0 => int device;
Hid hid;
HidMsg msg;

// open keyboard device - code from webchuck IDE
if (!hid.openKeyboard(device)) me.exit();
<<< "keyboard " + hid.name() + "ready", "" >>>;

//open mouse
if( !hid.openMouse( device ) ) me.exit();
<<< "mouse '" + hid.name() + "' ready", "" >>>;



//function for keeping track of mouse+keyboard - code from webChuck IDE

//spork the input listening
spork ~ inputListen();

fun void inputListen() {
    while (true) {
        hid => now;

        false => int buttonPress;

        while (hid.recv(msg)) {
            if (msg.isButtonDown() || msg.isButtonDown()) {
                if(buttonPress == false) {
                    //*************** ON BUTTON PRESS **************
                    <<< "key", msg.key, "(ascii)",  msg.which >>>;
                    syllableRN => syllBroadcast;

                    //play sound
                    "p_" + real + "_" + iRand + "_" + (syllBroadcast) + ".wav" => player.read;
                    0 => player.pos;

                    //fire message to javascript
                    uiSyllable.broadcast();

                    

                    syllableRN++;
                    <<<"syllableRN: " + syllableRN>>>;
                    changeActive.broadcast();
                    true => buttonPress;
                }
              
            } else {
                //button up
                false => buttonPress;
                
            }
        }
    }
    
}

//====================== GAME LOGIC ================================


fun void logic() { 

    

    

    //increment time until the playhead starts moving
    0.75::tempo.halfNote => now;

    //adjustable delay
    1::delay => now;

    startPlayhead.broadcast();

    //amount of time on either side of the perfect section: half a beat minus half the perfect length
    ((tempo.halfNote/6)/2 - perfect/2) => dur notPerfect;

    //set global syllableRN to 0
    0 => syllableRN;

    //reset UI
    

    //temporary current syllable counter
    0 => int currentSyllable;
    <<<"syllable: 0">>>;

    //repeat 7 times for the 7 beats
    for (0 => int i; i < 7; i++) {

        //increment temporary syllable counter
        currentSyllable++;

        
        //play notPerfect duration
        notPerfect => now;
        //report perfect
        true => perfectRN;
        <<<"perf zone enter">>>;
        //play the perfect length
        perfect => now;
        //report not perfect
        false => perfectRN;
        <<<"perf zone exit">>>;
        //play the rest of the beat, same length as before
        notPerfect => now;

        //increment global syllableRN but only if it's lower than the temp counter

        if (currentSyllable > syllableRN) {
            syllableRN++;
            <<<"syllableRN: " + syllableRN>>>;
            changeActive.broadcast();
        }

    }
    
  
}



//keep track of how many rounds there have been
4::tempo.halfNote => now;
0 => int rounds;

while (1)  {
    // update our basic beat each measure
    
    // one tempo.halfNote
    for (0 => int i; i < 12; i++) {
        
        //declare mainvariation randomness
        Math.random2(0,5) => mRand;
        //declare item randomness
        Math.random2(0,3) => iRand;
        
        
        //Deliver line
        
        if (!yourTurn) {
            //Toni's turn!
            
            
            if (i == 0) {

                //increment round
                rounds++;

                checkBPM.broadcast();
                //reroll randomness
                
                Math.random2(0,5) => mRand;
                Math.random2(0,3) => iRand; 

                //some rounds have pre-selected items

                if (rounds == 1 || rounds == 2 || rounds == 4){
                    61 => say;
                    61 => real;
            //         tempo.tempo(30.0, 4, 4);
            //         <<<tempo.quarterNote>>>;
                } else if (rounds == 3) {
                    63 => say;
                    63 => real;
                } else if (rounds == 9) {
                    61 => say;
                    63 => real;
                } else if (rounds == 10) {
                    63 => say;
                    61 => real;

                } else if (rounds == 11) {
                
                    29 => say;
                    61 => real;
                } else if (rounds == 12) {
                    29 => say;
                    29 => real;

                } else if (rounds > 4 && rounds <=8) {
                    Math.random2(0,1) => say;
                    if (say == 0) { 
                        61 => say;
                        61 => real;
                    } else {
                        63 => say;
                        63 => real;
                    }
                } else if (rounds == 17) {
                    90 => beatsPM;
                    tempo.tempo(beatsPM, 4, 4);


                } else if (rounds == 18) {
                    50 => beatsPM;
                    tempo.tempo(beatsPM, 4, 4);


                } else if (rounds == 19) {
                    20 => beatsPM;
                    tempo.tempo(beatsPM, 4, 4);

                } else if (rounds == 20) {
                    90 => beatsPM;
                    tempo.tempo(beatsPM, 4, 4);
                    //then 4 rounds of all inst, then 4 rounds of octave
                } else if (rounds == 29) {
                    140 => beatsPM;
                    tempo.tempo(beatsPM, 4, 4);
                } else if (rounds == 30) {
                    180 => beatsPM;
                } else if (rounds == 39) {
                    theEnd.broadcast();
                    break; // end the song


                
                
                
                
                


                } else {
                    // 120 => beatsPM;
                    // tempo.tempo(beatsPM, 4, 4);
                    //decide item to say
                    Math.random2(0, 2) => say;
                    if (say == 0) { 
                        61 => say;
                    } else if (say == 1){
                        63 => say;
                    } else {
                        29 => say;
                    }
                    //decide real item - temp if statement
                    Math.random2(0, 2) => real;
                    if (real == 0) {
                        61 => real;
                    } else if (real == 1){
                        63 => real;
                    } else {
                        29 => real;
                    }

                }
                
                talk.broadcast();
                reset.broadcast();
                toniReset.broadcast();
                beatsPM/120 $ float => toni.rate;
                "t_i_" + mRand + ".wav" => toni.read;
                0 => toni.pos;
                
                
            } else if (i == 3) {
                beatsPM/120 $ float => toni.rate;
                talk.broadcast();
                

                "t_have_" + mRand + ".wav" => toni.read;
                0 => toni.pos;
            } else if (i == 6) {
                beatsPM/120 $ float => toni.rate;

                talk.broadcast();
                //tell the UI to have Toni hold up the thing
                hold.broadcast();
                //change toni's rate if the bpm changes
                "t_" + say + "_" + iRand + ".wav" => toni.read;
            } else if (i == 9) {
                talk.broadcast();
                beatsPM/120 $ float => toni.rate;
            }
            
        } else {
            //Player's turn!
            

            
            
            if (i == 0) {
                //reset toni's rate
                1 => toni.rate;
                //start the logic spork
                spork ~ logic();
                "p_you_" + mRand + ".wav" => player.read;
                0 => player.pos;
            } else if (i == 3) {
                "p_have_" + mRand + ".wav" => player.read;
                0 => player.pos;
            }
            
        }
        
    //advance time
    1::tempo.quarterNote/3 => now;

        
    }
    !yourTurn => yourTurn;
}

    
