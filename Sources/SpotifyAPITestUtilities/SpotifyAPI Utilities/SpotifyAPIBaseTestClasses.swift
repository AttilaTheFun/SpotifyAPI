import Foundation
import Combine
import XCTest
@testable import SpotifyWebAPI

/// The base class for all tests involving
/// `SpotifyAPI<ClientCredentialsFlowManager>`.
open class SpotifyAPIClientCredentialsFlowTests: XCTestCase, SpotifyAPITests {
    
    public static let spotify =
            SpotifyAPI<ClientCredentialsFlowManager>.sharedTest
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
        spotify.waitUntilAuthorized()
    }
    
}



/// The base class for all tests involving
/// `SpotifyAPI<AuthorizationCodeFlowManager>`.
open class SpotifyAPIAuthorizationCodeFlowTests: XCTestCase, SpotifyAPITests {
    
    public static let spotify =
            SpotifyAPI<AuthorizationCodeFlowManager>.sharedTest
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

    open class func setupAuthorization(scopes: Set<Scope> = Scope.allCases) {
        spotify.authorizeAndWaitForTokens(scopes: scopes)
    }
    

}

/// The base class for all tests involving
/// `SpotifyAPI<AuthorizationCodeFlowPKCEManager>`.
open class SpotifyAPIAuthorizationCodeFlowPKCETests: XCTestCase, SpotifyAPITests {
    
    public static let spotify =
            SpotifyAPI<AuthorizationCodeFlowPKCEManager>.sharedTest
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

    open class func setupAuthorization(scopes: Set<Scope> = Scope.allCases) {
        spotify.authorizeAndWaitForTokens(scopes: scopes)
    }
    

}
