import singleSpaHtml from "single-spa-html"; // single-spa lifecycles helper

const htmlLifecycles = singleSpaHtml({
  template: '<x-my-web-component></x-my-web-component>',
});

export const mount = async (props) => {
  // Listen until Flutter tells us it's ready to rumble
  window.addEventListener("flutter-initialized", function (event) {
    const state = event.detail;
    window["_debugCounter"] = state;
    state.onClicksChanged(() => {
      console.log("New clicks value: ", state.getClicks());
    });
  });
  window.addEventListener("load", function (ev) {
    // Download main.dart.js
    _flutter.loader.loadEntrypoint({
      serviceWorker: {
       serviceWorkerVersion : "serviceWorkerVersion",
      },
      entrypointUrl : 'http://localhost:8083/main.dart.js',
      onEntrypointLoaded: async function (engineInitializer) {
        await engineInitializer.autoStart();
      },
    });
  });
}

export const { bootstrap, unmount } = htmlLifecycles; // export other lifecycles as-is
