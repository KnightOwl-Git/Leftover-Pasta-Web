// main.ck

SndBuf toni => dac;
SndBuf player => dac;

//global variable trackers
false => global int perfectRN;
0 => global int syllableRN;

//set bar length
1::second => dur bar;

bar/2 => dur quarterNote;


//amount of time per beat
bar/8 => dur beat;

quarterNote/3 => dur triplet;

false => int yourTurn;

//current said item
int say;
//current real item
int real;




//amount of time for perfect button presses
40::ms => dur perfect;

if (perfect > beat) {
    //making sure the perfect zone can't be longer than the beats
    beat >= perfect;
}

//set up keyboard input
0 => int device;
Hid hid;
HidMsg msg;

// open keyboard device - code from webchuck IDE
if (!hid.openKeyboard(device)) me.exit();
<<< "keyboard " + hid.name() + "ready", "" >>>;


//function for keeping track of mouse+keyboard - code from webChuck IDE

//spork the input listening
spork ~ inputListen();

fun void inputListen() {
    while (true) {
        hid => now;

        false => int buttonPress;

        while (hid.recv(msg)) {
            if (msg.isButtonDown()) {
                if(!buttonPress) {
                    //only execute once per button press
                    <<< "key", msg.key, "(ascii)",  msg.which >>>;

                    //play sound
                    
                    //fire message to javascript
                    

                    //increment syllableRN
                    syllableRN++;
                    true => buttonPress;
                }
              
            } else {
                //button up
                false => buttonPress;
                <<<"buttonUp">>>;

                
            }
        }
    }
    
}

//function for keeping track of game logic

fun void logic() { 
    

    //increment time until the playhead starts moving
    0.75::bar => now;

    //amount of time on either side of the perfect section: half a beat minus half the perfect length
    (beat/2 - perfect/2) => dur notPerfect;

    //set global syllableRN to 0
    0 => syllableRN;

    //temporary current syllable counter
    0 => int currentSyllable;
    <<<"syllable: 0">>>;

    //repeat 8 times for the 8 beats
    for (0 => int i; i < 8; i++) {

        //increment temporary syllable counter
        currentSyllable++;
        
        //play notPerfect duration
        notPerfect => now;
        //report perfect
        true => perfectRN;
        <<<"perfect zone!">>>;
        //play the perfect length
        perfect => now;
        //report not perfect
        false => perfectRN;
        <<<"sad zone :(">>>;
        //play the rest of the beat, same length as before
        notPerfect => now;

        //increment global syllableRN but only if it's lower than the temp counter

        if (currentSyllable > syllableRN) {
            syllableRN++;
            <<<"syllable: " + syllableRN >>>;
        }

    }
  
}



//function for player saying words


while (1)  {
    // update our basic beat each measure
    
    // one bar
    for (0 => int i; i < 12; i++) {
        
        //declare mainvariation randomness
        Math.random2(0,5) => int mRand;
        //declare item randomness
        Math.random2(0,3) => int iRand; 
        
        
        //Deliver line
        
        if (!yourTurn) {
            //Toni's turn!

            //reroll randomness
            
            Math.random2(0,5) => int mRand;
            Math.random2(0,3) => int iRand; 

            
            //decide item to say - temp if statement
            Math.random2(0, 1) => say;
            if (say == 0) { 
                61 => say;
            } else {
                63 => say;
            }
            //decide real item - temp if statement
            Math.random2(0, 1) => real;
            if (real == 0) {
                61 => real;
            } else {
                63 => real;
            }
            if (i == 0) {
                "t_i_" + mRand + ".wav" => toni.read;
                0 => toni.pos;
            } else if (i == 3) {
                "t_have_" + mRand + ".wav" => toni.read;
                0 => toni.pos;
            } else if (i == 6) {
                "t_" + say + "_" + iRand + ".wav" => toni.read;
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
  
    
