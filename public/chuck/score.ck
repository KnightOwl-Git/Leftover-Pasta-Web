// score.ck
// on the fly drumming with global BPM conducting
BPM tempo;
tempo.tempo(120.0, 4, 4);


Machine.add("kick.ck") => int kickID;
Machine.add("voice.ck") => int voiceID;
while (true) {
    1::second => now;
}


Machine.remove(kickID);
Machine.remove(voiceID);



