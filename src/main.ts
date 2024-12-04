import './style.css'

import { Rive, Layout, Fit, Alignment } from '@rive-app/canvas';


const riveCanvas = document.getElementById('rive-canvas') as HTMLCanvasElement | null;

if (riveCanvas != null) {
  const r = new Rive({

    src: "/rive/LP_UI_JS.riv",
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

}



