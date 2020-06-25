#!/usr/bin/env node

module.exports = function (context) {
    var jsSDKVersion = "v2.17.3";
    var downloadFile = require('./downloadFile.js'),
        Q = require('q'),
        deferral = new Q.defer();
    console.log('Downloading OpenTok JS SDK ' + jsSDKVersion);
    downloadFile('https://enterprise.opentok.com/' + jsSDKVersion + '/js/opentok.min.js', context.opts.plugin.dir + '/opentok-web.js', function (err) {
        if (!err) {
            console.log('Downloaded OpenTok JS SDK ' + jsSDKVersion);
            deferral.resolve();
        }
    });
    return deferral.promise;
};