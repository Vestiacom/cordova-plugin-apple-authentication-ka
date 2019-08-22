var exec = require("cordova/exec");
var PLUGIN_NAME = "AppleAuthentication";

module.exports = {
    getToken: function(success, error) {
        function modelData() {
            success({
                email: arguments[0],
                fullName: arguments[1],
                userId: arguments[2],
                identityToken: arguments[3],
                authorizationCode: arguments[4]
            });
        }
        exec(modelData, error, PLUGIN_NAME, "getToken", []);
    }
};
