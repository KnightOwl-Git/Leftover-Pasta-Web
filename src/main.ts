import './style.css'

import { Rive, Layout, Fit, Alignment } from '@rive-app/canvas';


const riveCanvas = document.getElementById('rive-canvas') as HTMLCanvasElement;


const r = new Rive({

  src: "/rive/LP_UI_JS_final.riv",
  canvas: riveCanvas,
  layout: new Layout({
    fit: Fit.Layout,
    alignment: Alignment.TopCenter,
    layoutScaleFactor: 0.6, // 2x scale of the layout, when using `Fit.Layout`. This allows you to resize the layout as needed.
  }),

  autoplay: true,
  stateMachines: "LPUI",
  onLoad: () => {
    // Ensure the drawing surface matches the canvas size and device pixel ratio
    computeSize();
  },
});


function computeSize() {
  r.resizeDrawingSurfaceToCanvas();
}

// Subscribe to window size changes and update call `resizeDrawingSurfaceToCanvas`
window.onresize = computeSize;

// Subscribe to devicePixelRatio changes and call `resizeDrawingSurfaceToCanvas`
window
  .matchMedia(`(resolution: ${window.devicePixelRatio}dppx)`)
  .addEventListener("change", computeSize);



// CHUCK LISTENERS

export function buttPress(syll: number, perfect: number) {
  if (perfect) {
    r.fireStateAtPath("Perfect", "Full Timeline Widget/Syllable " + syll);
    
  } else {
    r.fireStateAtPath("Good", "Full Timeline Widget/Syllable " + syll);

  }
  

}
export function reset() {
  for (let i = 0; i < 8; i++) {
    r.fireStateAtPath("Reset", "Full Timeline Widget/Syllable " + i);
    r.fireStateAtPath("phReset", "Full Timeline Widget");

  }
}
export function changeActive(syll: number) {
  r.fireStateAtPath("In the Zone", "Full Timeline Widget/Syllable " + syll);
  r.fireStateAtPath("Out of the Zone", "Full Timeline Widget/Syllable " + (syll - 1));
}

export function startPlayhead() {
  r.fireStateAtPath("AutoStart", "Full Timeline Widget");


}

export function talk() {
  r.fireStateAtPath("Talk", "Toni 2");

}

export function holdItem(itemno: number) {

  r.setNumberStateAtPath("ItemNo", itemno, "Toni 2/Items")
  r.fireStateAtPath("Hold Item", "Toni 2");

}

export function toniReset() {
  r.fireStateAtPath("Reset", "Toni 2");

}

export function sad() {
  r.setBooleanStateAtPath("Sad", true, "Toni2");

}

export function happy() {
  r.setBooleanStateAtPath("Sad", false, "Toni2");

}





