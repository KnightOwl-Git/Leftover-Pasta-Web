// main.ck

SndBuf toni => dac;
SndBuf player => dac;

// make a conductor for our tempo 
// this is set and updated elsewhere

second/2 => dur quarterNote;

quarterNote/3 => dur triplet;

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
    <<<yourTurn>>>;
    
}
  
    
