
#if canImport(Combine)
import Combine
#else
import OpenCombine
import OpenCombineDispatch
import OpenCombineFoundation

#endif
import XCTest
import SpotifyWebAPI

/// The base class for all tests involving
/// `SpotifyAPI<ClientCredentialsFlowManager>`.
open class SpotifyAPIClientCredentialsFlowTests: XCTestCase, SpotifyAPITests {
    
    public static var spotify =
            SpotifyAPI<ClientCredentialsFlowManager>.sharedTestNetworkAdaptor
    
    public static var cancellables: Set<AnyCancellable> = []

    /// If you only need to setup the authorization,
    /// override `setupAuthorization()` instead.
    override open class func setUp() {
        print(
            "setup debugging and authorization for " +
            "SpotifyAPIClientCredentialsFlowTests"
        )
        setUpDebugging()
        setupAuthorization()
    }

    open class func setupAuthorization() {
        if Bool.random() {
            spotify = .sharedTest
        }
        else {
            spotify = .sharedTestNetworkAdaptor
        }
        
        spotify.waitUntilAuthorized()
    }
    
}



/// The base class for all tests involving
/// `SpotifyAPI<AuthorizationCodeFlowManager>`.
open class SpotifyAPIAuthorizationCodeFlowTests: XCTestCase, SpotifyAPITests {
    
    public static var spotify =
            SpotifyAPI<AuthorizationCodeFlowManager>.sharedTestNetworkAdaptor
    
    public static var cancellables: Set<AnyCancellable> = []

    /// If you only need to setup the authorization,
    /// override `setupAuthorization()` instead.
    override open class func setUp() {
        print(
            "setup debugging and authorization for " +
            "SpotifyAPIAuthorizationCodeFlowTests"
        )
        setUpDebugging()
        setupAuthorization()
    }

    open class func setupAuthorization(
        scopes: Set<Scope> = Scope.allCases,
        showDialog: Bool = true
    ) {
        if Bool.random() {
            spotify = .sharedTest
        }
        else {
            spotify = .sharedTestNetworkAdaptor
        }

        spotify.authorizeAndWaitForTokens(
            scopes: scopes, showDialog: true
        )
    }
    

}

/// The base class for all tests involving
/// `SpotifyAPI<AuthorizationCodeFlowPKCEManager>`.
open class SpotifyAPIAuthorizationCodeFlowPKCETests: XCTestCase, SpotifyAPITests {
    
    public static var spotify =
            SpotifyAPI<AuthorizationCodeFlowPKCEManager>.sharedTestNetworkAdaptor
    
    public static var cancellables: Set<AnyCancellable> = []

    /// If you only need to setup the authorization,
    /// override `setupAuthorization()` instead.
    override open class func setUp() {
        print(
            "setup debugging and authorization for " +
            "SpotifyAPIAuthorizationCodeFlowPKCETests"
        )
        setUpDebugging()
        setupAuthorization()
    }

    open class func setupAuthorization(
        scopes: Set<Scope> = Scope.allCases
    ) {
        if Bool.random() {
            spotify = .sharedTest
        }
        else {
            spotify = .sharedTestNetworkAdaptor
        }
        
        spotify.authorizeAndWaitForTokens(scopes: scopes)
    }
    

}
