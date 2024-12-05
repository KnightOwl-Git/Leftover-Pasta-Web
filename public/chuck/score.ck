// score.ck
// on the fly drumming with global BPM conducting
BPM tempo;
 

// paths to chuck file

// 4 seconds kick with nothing else
"kick.ck" => string kickPath;
"piano.ck" => string pianoPath;
"flute.ck" => string flutePath;
"bass.ck" => string bassPath;
"drums.ck" => string drumsPath;
"fluteOctave.ck" => string fluteOctavePath;
int kickID;
int bassID;
int fluteID;
int pianoID;
int drumsID;
int fluteOID;

Machine.add(kickPath) => kickID; 

<<<tempo.quarterNote>>>;
4::tempo.halfNote => now;



14::tempo.halfNote => now;
Machine.remove(kickID);
2::tempo.halfNote => now;
Machine.add(kickPath) => kickID;


Machine.add(bassPath) => bassID;


16::tempo.halfNote => now;
Machine.remove(bassID);


12::tempo.halfNote => now;
Machine.remove(kickID);

4::tempo.halfNote => now;
Machine.add(flutePath) => fluteID;
Machine.add(bassPath) => bassID;
Machine.add(kickPath) => kickID;

Machine.add(pianoPath) => pianoID;

16::tempo.halfNote => now;

Machine.remove(fluteID);
Machine.remove(drumsID);
Machine.remove(bassID);

16::tempo.halfNote => now;
Machine.add(flutePath) => fluteID;
Machine.add(bassPath) => bassID;
Machine.add(kickPath) => kickID;
Machine.add(drumsPath) => drumsID;
Machine.add(pianoPath) => pianoID;
16::tempo.halfNote=> now;
//them add octave
Machine.add(fluteOctavePath) => fluteOID;
16::tempo.halfNote=> now;
// allow for the rate to change


Machine.remove(fluteID);
Machine.remove(drumsID);
Machine.remove(bassID);
Machine.remove(pianoID);
Machine.remove(kickID);




