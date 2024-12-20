import { Chuck, HID } from 'webchuck'
import { buttPress, holdItem, sad, setBPM, talk, toniReset } from './main.ts'
import { reset } from './main.ts'
import { changeActive } from './main.ts'
import { startPlayhead } from './main.ts'

document.getElementById('action')!.addEventListener('click', async () => {
    //hide button
    document.getElementById('action')!.style.display = "none";

    // Initialize default ChucK object

    console.log("loading");

    const theChuck = await Chuck.init([{ "serverFilename": "./p_29_0_2.wav", "virtualFilename": "p_29_0_2.wav" }, { "serverFilename": "./p_29_0_3.wav", "virtualFilename": "p_29_0_3.wav" }, { "serverFilename": "./p_29_0_4.wav", "virtualFilename": "p_29_0_4.wav" }, { "serverFilename": "./p_29_0_6.wav", "virtualFilename": "p_29_0_6.wav" }, { "serverFilename": "./p_29_1_2.wav", "virtualFilename": "p_29_1_2.wav" }, { "serverFilename": "./p_29_1_3.wav", "virtualFilename": "p_29_1_3.wav" }, { "serverFilename": "./p_29_1_4.wav", "virtualFilename": "p_29_1_4.wav" }, { "serverFilename": "./p_29_1_6.wav", "virtualFilename": "p_29_1_6.wav" }, { "serverFilename": "./p_29_2_2.wav", "virtualFilename": "p_29_2_2.wav" }, { "serverFilename": "./p_29_2_3.wav", "virtualFilename": "p_29_2_3.wav" }, { "serverFilename": "./p_29_2_4.wav", "virtualFilename": "p_29_2_4.wav" }, { "serverFilename": "./p_29_2_6.wav", "virtualFilename": "p_29_2_6.wav" }, { "serverFilename": "./p_29_3_2.wav", "virtualFilename": "p_29_3_2.wav" }, { "serverFilename": "./p_29_3_3.wav", "virtualFilename": "p_29_3_3.wav" }, { "serverFilename": "./p_29_3_4.wav", "virtualFilename": "p_29_3_4.wav" }, { "serverFilename": "./p_29_3_6.wav", "virtualFilename": "p_29_3_6.wav" }, { "serverFilename": "./p_61_0_1.wav", "virtualFilename": "p_61_0_1.wav" }, { "serverFilename": "./p_61_0_2.wav", "virtualFilename": "p_61_0_2.wav" }, { "serverFilename": "./p_61_0_3.wav", "virtualFilename": "p_61_0_3.wav" }, { "serverFilename": "./p_61_0_4.wav", "virtualFilename": "p_61_0_4.wav" }, { "serverFilename": "./p_61_0_6.wav", "virtualFilename": "p_61_0_6.wav" }, { "serverFilename": "./p_61_1_1.wav", "virtualFilename": "p_61_1_1.wav" }, { "serverFilename": "./p_61_1_2.wav", "virtualFilename": "p_61_1_2.wav" }, { "serverFilename": "./p_61_1_3.wav", "virtualFilename": "p_61_1_3.wav" }, { "serverFilename": "./p_61_1_4.wav", "virtualFilename": "p_61_1_4.wav" }, { "serverFilename": "./p_61_1_6.wav", "virtualFilename": "p_61_1_6.wav" }, { "serverFilename": "./p_61_2_1.wav", "virtualFilename": "p_61_2_1.wav" }, { "serverFilename": "./p_61_2_2.wav", "virtualFilename": "p_61_2_2.wav" }, { "serverFilename": "./p_61_2_3.wav", "virtualFilename": "p_61_2_3.wav" }, { "serverFilename": "./p_61_2_4.wav", "virtualFilename": "p_61_2_4.wav" }, { "serverFilename": "./p_61_2_6.wav", "virtualFilename": "p_61_2_6.wav" }, { "serverFilename": "./p_61_3_1.wav", "virtualFilename": "p_61_3_1.wav" }, { "serverFilename": "./p_61_3_2.wav", "virtualFilename": "p_61_3_2.wav" }, { "serverFilename": "./p_61_3_3.wav", "virtualFilename": "p_61_3_3.wav" }, { "serverFilename": "./p_61_3_4.wav", "virtualFilename": "p_61_3_4.wav" }, { "serverFilename": "./p_61_3_6.wav", "virtualFilename": "p_61_3_6.wav" }, { "serverFilename": "./p_63_0_1.wav", "virtualFilename": "p_63_0_1.wav" }, { "serverFilename": "./p_63_0_2.wav", "virtualFilename": "p_63_0_2.wav" }, { "serverFilename": "./p_63_0_3.wav", "virtualFilename": "p_63_0_3.wav" }, { "serverFilename": "./p_63_0_4.wav", "virtualFilename": "p_63_0_4.wav" }, { "serverFilename": "./p_63_0_5.wav", "virtualFilename": "p_63_0_5.wav" }, { "serverFilename": "./p_63_0_6.wav", "virtualFilename": "p_63_0_6.wav" }, { "serverFilename": "./p_63_1_1.wav", "virtualFilename": "p_63_1_1.wav" }, { "serverFilename": "./p_63_1_2.wav", "virtualFilename": "p_63_1_2.wav" }, { "serverFilename": "./p_63_1_3.wav", "virtualFilename": "p_63_1_3.wav" }, { "serverFilename": "./p_63_1_4.wav", "virtualFilename": "p_63_1_4.wav" }, { "serverFilename": "./p_63_1_5.wav", "virtualFilename": "p_63_1_5.wav" }, { "serverFilename": "./p_63_1_6.wav", "virtualFilename": "p_63_1_6.wav" }, { "serverFilename": "./p_63_2_1.wav", "virtualFilename": "p_63_2_1.wav" }, { "serverFilename": "./p_63_2_2.wav", "virtualFilename": "p_63_2_2.wav" }, { "serverFilename": "./p_63_2_3.wav", "virtualFilename": "p_63_2_3.wav" }, { "serverFilename": "./p_63_2_4.wav", "virtualFilename": "p_63_2_4.wav" }, { "serverFilename": "./p_63_2_5.wav", "virtualFilename": "p_63_2_5.wav" }, { "serverFilename": "./p_63_2_6.wav", "virtualFilename": "p_63_2_6.wav" }, { "serverFilename": "./p_63_3_1.wav", "virtualFilename": "p_63_3_1.wav" }, { "serverFilename": "./p_63_3_2.wav", "virtualFilename": "p_63_3_2.wav" }, { "serverFilename": "./p_63_3_3.wav", "virtualFilename": "p_63_3_3.wav" }, { "serverFilename": "./p_63_3_4.wav", "virtualFilename": "p_63_3_4.wav" }, { "serverFilename": "./p_63_3_5.wav", "virtualFilename": "p_63_3_5.wav" }, { "serverFilename": "./p_63_3_6.wav", "virtualFilename": "p_63_3_6.wav" }, { "serverFilename": "./p_have_0.wav", "virtualFilename": "p_have_0.wav" }, { "serverFilename": "./p_have_1.wav", "virtualFilename": "p_have_1.wav" }, { "serverFilename": "./p_have_2.wav", "virtualFilename": "p_have_2.wav" }, { "serverFilename": "./p_have_3.wav", "virtualFilename": "p_have_3.wav" }, { "serverFilename": "./p_have_4.wav", "virtualFilename": "p_have_4.wav" }, { "serverFilename": "./p_have_5.wav", "virtualFilename": "p_have_5.wav" }, { "serverFilename": "./p_whoops_1.wav", "virtualFilename": "p_whoops_1.wav" }, { "serverFilename": "./p_whoops_2.wav", "virtualFilename": "p_whoops_2.wav" }, { "serverFilename": "./p_whoops_3.wav", "virtualFilename": "p_whoops_3.wav" }, { "serverFilename": "./p_whoops_4.wav", "virtualFilename": "p_whoops_4.wav" }, { "serverFilename": "./p_whoops_5.wav", "virtualFilename": "p_whoops_5.wav" }, { "serverFilename": "./p_whoops_6.wav", "virtualFilename": "p_whoops_6.wav" }, { "serverFilename": "./p_whoops_7.wav", "virtualFilename": "p_whoops_7.wav" }, { "serverFilename": "./p_whoops_8.wav", "virtualFilename": "p_whoops_8.wav" }, { "serverFilename": "./p_whoops_9.wav", "virtualFilename": "p_whoops_9.wav" }, { "serverFilename": "./p_whoops_10.wav", "virtualFilename": "p_whoops_10.wav" }, { "serverFilename": "./p_whoops_11.wav", "virtualFilename": "p_whoops_11.wav" }, { "serverFilename": "./p_whoops_12.wav", "virtualFilename": "p_whoops_12.wav" }, { "serverFilename": "./p_whoops_13.wav", "virtualFilename": "p_whoops_13.wav" }, { "serverFilename": "./p_whoops_14.wav", "virtualFilename": "p_whoops_14.wav" }, { "serverFilename": "./p_whoops_15.wav", "virtualFilename": "p_whoops_15.wav" }, { "serverFilename": "./p_whoops_16.wav", "virtualFilename": "p_whoops_16.wav" }, { "serverFilename": "./p_whoops_17.wav", "virtualFilename": "p_whoops_17.wav" }, { "serverFilename": "./p_whoops_18.wav", "virtualFilename": "p_whoops_18.wav" }, { "serverFilename": "./p_whoops_19.wav", "virtualFilename": "p_whoops_19.wav" }, { "serverFilename": "./p_whoops_20.wav", "virtualFilename": "p_whoops_20.wav" }, { "serverFilename": "./p_whoops_21.wav", "virtualFilename": "p_whoops_21.wav" }, { "serverFilename": "./p_whoops_22.wav", "virtualFilename": "p_whoops_22.wav" }, { "serverFilename": "./p_whoops_23.wav", "virtualFilename": "p_whoops_23.wav" }, { "serverFilename": "./p_whoops_24.wav", "virtualFilename": "p_whoops_24.wav" }, { "serverFilename": "./p_whoops_25.wav", "virtualFilename": "p_whoops_25.wav" }, { "serverFilename": "./p_whoops_26.wav", "virtualFilename": "p_whoops_26.wav" }, { "serverFilename": "./p_you_0.wav", "virtualFilename": "p_you_0.wav" }, { "serverFilename": "./p_you_1.wav", "virtualFilename": "p_you_1.wav" }, { "serverFilename": "./p_you_2.wav", "virtualFilename": "p_you_2.wav" }, { "serverFilename": "./p_you_3.wav", "virtualFilename": "p_you_3.wav" }, { "serverFilename": "./p_you_4.wav", "virtualFilename": "p_you_4.wav" }, { "serverFilename": "./p_you_5.wav", "virtualFilename": "p_you_5.wav" }, { "serverFilename": "./t_29_0.wav", "virtualFilename": "t_29_0.wav" }, { "serverFilename": "./t_29_1.wav", "virtualFilename": "t_29_1.wav" }, { "serverFilename": "./t_29_2.wav", "virtualFilename": "t_29_2.wav" }, { "serverFilename": "./t_29_3.wav", "virtualFilename": "t_29_3.wav" }, { "serverFilename": "./t_61_0.wav", "virtualFilename": "t_61_0.wav" }, { "serverFilename": "./t_61_1.wav", "virtualFilename": "t_61_1.wav" }, { "serverFilename": "./t_61_2.wav", "virtualFilename": "t_61_2.wav" }, { "serverFilename": "./t_61_3.wav", "virtualFilename": "t_61_3.wav" }, { "serverFilename": "./t_63_0.wav", "virtualFilename": "t_63_0.wav" }, { "serverFilename": "./t_63_1.wav", "virtualFilename": "t_63_1.wav" }, { "serverFilename": "./t_63_2.wav", "virtualFilename": "t_63_2.wav" }, { "serverFilename": "./t_63_3.wav", "virtualFilename": "t_63_3.wav" }, { "serverFilename": "./t_have_0.wav", "virtualFilename": "t_have_0.wav" }, { "serverFilename": "./t_have_1.wav", "virtualFilename": "t_have_1.wav" }, { "serverFilename": "./t_have_2.wav", "virtualFilename": "t_have_2.wav" }, { "serverFilename": "./t_have_3.wav", "virtualFilename": "t_have_3.wav" }, { "serverFilename": "./t_have_4.wav", "virtualFilename": "t_have_4.wav" }, { "serverFilename": "./t_have_5.wav", "virtualFilename": "t_have_5.wav" }, { "serverFilename": "./t_i_0.wav", "virtualFilename": "t_i_0.wav" }, { "serverFilename": "./t_i_1.wav", "virtualFilename": "t_i_1.wav" }, { "serverFilename": "./t_i_2.wav", "virtualFilename": "t_i_2.wav" }, { "serverFilename": "./t_i_3.wav", "virtualFilename": "t_i_3.wav" }, { "serverFilename": "./t_i_4.wav", "virtualFilename": "t_i_4.wav" }, { "serverFilename": "./t_i_5.wav", "virtualFilename": "t_i_5.wav" }]);

    const hid = await HID.init(theChuck); // Initialize HID with mouse and keyboard

    console.log(hid); //this is literally just so typescript doesn't get mad at me because it doesn't know that chuck is using it :P

    //load chuck files
    await theChuck.loadFile("/chuck/main.ck");
    await theChuck.loadFile("/chuck/initialize.ck");
    await theChuck.loadFile("/chuck/kick.ck");
    await theChuck.loadFile("/chuck/score.ck");
    await theChuck.loadFile("/chuck/BPM.ck");
    await theChuck.loadFile("/chuck/piano.ck");
    await theChuck.loadFile("/chuck/bass.ck");
    await theChuck.loadFile("/chuck/drums.ck");
    await theChuck.loadFile("/chuck/flute.ck");
    await theChuck.loadFile("/chuck/fluteOctave.ck");
    
    //load samples from class
    await theChuck.loadFile("/chuck/audio/clap_01.wav");
    await theChuck.loadFile("/chuck/audio/click_01.wav");
    await theChuck.loadFile("/chuck/audio/click_02.wav");
    await theChuck.loadFile("/chuck/audio/click_03.wav");
    await theChuck.loadFile("/chuck/audio/click_04.wav");
    await theChuck.loadFile("/chuck/audio/click_05.wav");
    await theChuck.loadFile("/chuck/audio/cowbell_01.wav");
    await theChuck.loadFile("/chuck/audio/hihat_01.wav");
    await theChuck.loadFile("/chuck/audio/hihat_02.wav");
    await theChuck.loadFile("/chuck/audio/hihat_03.wav");
    await theChuck.loadFile("/chuck/audio/hihat_04.wav");
    await theChuck.loadFile("/chuck/audio/kick_01.wav");
    await theChuck.loadFile("/chuck/audio/kick_03.wav");
    await theChuck.loadFile("/chuck/audio/kick_04.wav");
    await theChuck.loadFile("/chuck/audio/kick_05.wav");
    await theChuck.loadFile("/chuck/audio/snare_03.wav");
    await theChuck.loadFile("/chuck/audio/stereo_fx_01.wav");
    await theChuck.loadFile("/chuck/audio/stereo_fx_02.wav");
    await theChuck.loadFile("/chuck/audio/stereo_fx_03.wav");
    await theChuck.loadFile("/chuck/audio/stereo_fx_04.wav");
    await theChuck.loadFile("/chuck/audio/stereo_fx_05.wav");



    await theChuck.runFile("main.ck");
    console.log("done loading");
    theChuck.startListeningForEvent("uiSyllable", uiChange);
    theChuck.startListeningForEvent("reset", reset);
    theChuck.startListeningForEvent("changeActive", advance);
    theChuck.startListeningForEvent("startPlayhead", startPlayhead);
    theChuck.startListeningForEvent("talk", talk);
    theChuck.startListeningForEvent("sad", sad);
    theChuck.startListeningForEvent("hold", holdThing);
    theChuck.startListeningForEvent("toniReset", toniReset);
    theChuck.startListeningForEvent("checkBPM", setberp);
    theChuck.startListeningForEvent("theEnd", stopit);

    async function stopit() {
        document.getElementById("theEnd")!.style.display = "flex";
        
    }



    async function uiChange() {
        const currentSyll = await theChuck.getInt("syllBroadcast");
        const perf = await theChuck.getInt("perfectRN");
        console.log("syllbroadcast: " + currentSyll);
        buttPress(currentSyll,perf);

    }
    async function advance() {
        const currentSyll = await theChuck.getInt("syllableRN");
        changeActive(currentSyll);

    }

    async function holdThing() {
        const itemHold = await theChuck.getInt("real");
        
        holdItem(itemHold);

    }
    async function setberp() {
        const currentBPM = await theChuck.getInt("beatsPM");
        setBPM(currentBPM);

    }



});


