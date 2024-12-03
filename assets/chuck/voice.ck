// hat.ck
// on the fly drumming with global BPM conducting
SndBuf toni => dac;
SndBuf player => dac;



//declare sample libraries

string Samps_I[4];
string Samps_You[4];
string Samps_tHave[4];
string Samps_pHave[4];
string Samps_whoops[24];

//3d array for player items: [0=lp,1=dm][variation][syllable]
string Samps_pItems[2][4][6];
//2d array for toni items: [0=lp, 1=dm][variation]
string Samps_tItems[2][4];


//initialize main words

for (1 => int i; i <= 4; i++) {
    string temp;
    me.dir() + "voice/toni/i/" + i + ".wav" => temp;
    temp => Samps_I[i-1];
    
    me.dir() + "voice/toni/have/" + i + ".wav" => temp;
    temp => Samps_tHave[i-1];
    
    me.dir() + "voice/player/have/" + i + ".wav" => temp;
    temp => Samps_pHave[i-1];
    
    me.dir() + "voice/player/you/" + i + ".wav" => temp;
    temp => Samps_You[i-1];
}

//initialize items: i for item, v for variation, s for syllable

for (0 => int i; i < 2; i++) {
    for (0 => int v; v < 4; v++) {
        
        //set toni's items
        me.dir() + "voice/toni/" + i + "/" + v + ".wav" => Samps_tItems[i][v];
        
        for (0 => int s; s < 6; s++) {
            
            
            //set player's items
            me.dir() + "voice/player/" + i + "/" + v + "/" + s + ".wav" => Samps_pItems[i][v][s];
            if (i == 0 && s == 4) {
                //temporary thingy to fix invalid path for incorrect syllable
                "null" => Samps_pItems[i][v][s];
            }
            

        }
        
    }
    
}

//initialize whoops
for (0 => int i; i < 24; i++) {
    me.dir() + "voice/player/whoops/" + i + ".wav" => Samps_whoops[i];
}


// make a conductor for our tempo 
// this is set and updated elsewhere
BPM tempo;

tempo.quarterNote/3 => dur triplet;

false => int yourTurn;

//current said item
int say;
//current real item
int real;

while (1)  {
    // update our basic beat each measure
    
    // one bar
    for (0 => int i; i < 12; i++) {
        
        //declare mainvariation randomness
        Math.random2(0,3) => int mRand;
        //declare item randomness
        Math.random2(0,3) => int iRand; 
        
        
        //Deliver line
        
        if (!yourTurn) {
            //Toni's turn!
            
            //decide item to say
            Math.random2(0, 1) => say;
            //decide real item
            Math.random2(0, 1) => real;
            if (i == 0) {
                Samps_I[mRand] => toni.read;
                0 => toni.pos;
            } else if (i == 3) {
                Samps_tHave[mRand] => toni.read;
                0 => toni.pos;
            } else if (i == 6) {
                Samps_tItems[say][iRand] => toni.read;
            }
            
        } else {
            //Player's turn!
            if (i == 0) {
                Samps_You[mRand] => player.read;
                0 => player.pos;
            } else if (i == 3) {
                Samps_pHave[mRand] => player.read;
                0 => player.pos;
            } 
            
        }
        
    //advance time
    1::triplet => now;

        
    }
    !yourTurn => yourTurn;
    <<<yourTurn>>>;
    
}
  
    
