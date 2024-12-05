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

//global variable trackers
false => global int perfectRN;
0 => global int syllableRN;
0 => global int syllBroadcast;

SndBuf toni => dac;
SndBuf player => dac;



//set bar length
1::second => dur bar;

bar/2 => dur quarterNote;


//amount of time per beat
bar/6 => dur beat;

quarterNote/3 => dur triplet;

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

if (perfect > beat) {
    //making sure the perfect zone can't be longer than the beats
    beat >= perfect;
}




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
    0.75::bar => now;

    //adjustable delay
    1::delay => now;

    startPlayhead.broadcast();

    //amount of time on either side of the perfect section: half a beat minus half the perfect length
    (beat/2 - perfect/2) => dur notPerfect;

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



//function for player saying words


while (1)  {
    // update our basic beat each measure
    
    // one bar
    for (0 => int i; i < 12; i++) {
        
        //declare mainvariation randomness
        Math.random2(0,5) => mRand;
        //declare item randomness
        Math.random2(0,3) => iRand; 
        
        
        //Deliver line
        
        if (!yourTurn) {
            //Toni's turn!
            
            if (i == 0) {
                //reroll randomness
            
            Math.random2(0,5) => mRand;
            Math.random2(0,3) => iRand; 

            
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
                talk.broadcast();
                reset.broadcast();
                toniReset.broadcast();
                "t_i_" + mRand + ".wav" => toni.read;
                0 => toni.pos;
                
                
            } else if (i == 3) {
                talk.broadcast();
                "t_have_" + mRand + ".wav" => toni.read;
                0 => toni.pos;
            } else if (i == 6) {
                talk.broadcast();
                //tell the UI to have Toni hold up the thing
                hold.broadcast();
                "t_" + say + "_" + iRand + ".wav" => toni.read;
            } else if (i == 9) {
                talk.broadcast();
            }
            
        } else {
            //Player's turn!
            
            if (i == 0) {
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
    1::triplet => now;

        
    }
    !yourTurn => yourTurn;
}
  
    
