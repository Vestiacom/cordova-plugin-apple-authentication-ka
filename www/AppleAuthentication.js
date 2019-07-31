var exec = require("cordova/exec");
var PLUGIN_NAME = "AppleAuthentication";

module.exports = {
    getToken: function(success, error) {
        exec(success, error, PLUGIN_NAME, "getToken", []);
    }
};
