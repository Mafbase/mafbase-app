{{flutter_js}}
{{flutter_build_config}}

window.addEventListener('load', async function () {
  await _flutter.loader.load({
    serviceWorkerSettings: {
      serviceWorkerVersion: {{flutter_service_worker_version}},
      serviceWorkerUrl: 'flutter_service_worker.js',
    },
    onEntrypointLoaded: async function (engineInitializer) {
      const appRunner = await engineInitializer.initializeEngine();
      await appRunner.runApp();
    },
  });
});