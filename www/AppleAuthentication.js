var exec = require("cordova/exec");
var PLUGIN_NAME = "AppleAuthentication";

module.exports = {
    getToken: function(success, error) {
        function modelData(args) {
            var fields = ['email', 'fullName', 'userId', 'identityToken', 'authorizationCode'],
                result = {};

            fields.forEach(function(item, key){
               result[item] = args[key] || undefined;
            });

            success(result);
        }
        exec(modelData, error, PLUGIN_NAME, "getToken", []);
    }
};
