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
