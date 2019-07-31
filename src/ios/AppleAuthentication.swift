import AuthenticationServices

@available(iOS 13.0, *)
@objc(AppleAuthentication) class AppleAuthentication : CDVPlugin, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    var CDVWebview:UIWebView;
    var command: CDVInvokedUrlCommand;

    // This is just called if <param name="onload" value="true" /> in plugin.xml.
    init(webView: UIWebView) {
        self.CDVWebview = webView
        self.command = CDVInvokedUrlCommand()
    }

    @objc func getToken(_ command: CDVInvokedUrlCommand) {
        self.command = command
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    @objc func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

        let pluginResult = CDVPluginResult(
          status: CDVCommandStatus_OK,
          messageAs: credentials.authorizationCode?.base64EncodedString()
        )

        self.commandDelegate.send(
          pluginResult,
          callbackId: self.command.callbackId
        )
    }

    @objc func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }

    @objc func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.CDVWebview.window ?? UIWindow()
    }
}
