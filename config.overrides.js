const reactAppRewireBuildDev = require('react-app-rewire-build-dev');

/* config-overrides.js */

const options = {
    outputPath: "<location of watch directory i.e. '../server/build' >",  /***** required *****/
    basename: "<location of subdirectory>", // deploy react-app in a subdirectory /***** optional *****/
    hotReloadPort: "<port of webpack-server>" // default:3000,simply relaod the webpage on changes./***** optional *****/
}

module.exports = function override(config, env) {
    return reactAppRewireBuildDev(config, env, options);
}