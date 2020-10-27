import Foundation


/**
 An error that is not directly produced by the Spotify web API.
 
 For example if you try to make an API request but have not
 authorized your application yet, you will get a `.unauthorized(String)`
 error, which is thrown before any network requests are even made.
 
 Use `localizedDescription` for an error message suitable for displaying
 to the end user. Use the string representation of this instance for a more
 detailed description suitable for debugging.
 */
public enum SpotifyLocalError: LocalizedError, CustomStringConvertible {
    
    /// You tried to access an endpoint that requires authorization,
    /// but you have not authorized your app yet.
    case unauthorized(String)
    
    /**
     Thrown if the value provided for the state parameter when you requested
     access and refresh tokens didn't match the value returned from spotify
     in the query string of the redirect URI.
     
     - supplied: The value supplied when requesting the access and refresh
       tokens.
     - received: The value received from Spotify in the query string of
       the redirect URI.
     */
    case invalidState(supplied: String?, received: String?)
    
    
    /// A [Spotify identifier][1] (URI, ID, URL) of a specific type
    /// could not be parsed. The message will contain more information.
    ///
    /// [1]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
    case identifierParsingError(message: String)

    /**
     You tried to access an endpoint that
     your app does not have the required scopes for.
    
     - requiredScopes: The scopes that are required for this endpoint.
     - authorizedScopes: The scopes that your app is authroized for.
     */
    case insufficientScope(
        requiredScopes: Set<Scope>, authorizedScopes: Set<Scope>
    )
    
    /**
     The category of a URI didn't match one of the expected categories.
    
      - expected: The expected categories. Some endpoints allow for
        URIS from multiple categories. For example, the endpoint for
        adding items to a playlist allows for track or episode URIs.
      - received: the id category that was received.
    
     For example, if you pass a track URI to the endpoint for retrieving
     an artist, you will get this error.
     
     See also `IDCategory`.
     */
    case invalidIdCategory(
        expected: [IDCategory], received: IDCategory
    )
    
    /**
     Spotify sometimes returns data wrapped in an extraneous top-level
     dictionary that the client doesn't need to care about. This error
     is thrown if the expected top level key associated with the data
     is not found.
     
     For example, adding a tracks to a playlist returns the following
     response:
     ```
     { "snapshot_id" : "3245kj..." }
     ```
     The value of the snapshot id is returned instead of the entire
     dictionary or this error is thrown if the key can't be found.
     */
    case topLevelKeyNotFound(
        key: String, dict: [AnyHashable: Any]
    )
    
    /// Some other error.
    case other(String)
    
    public var errorDescription: String? {
        switch self {
             case .unauthorized(_):
                return """
                    Authorization has not been granted for this \
                    operation.
                    """
            case .invalidState(_, _):
                return """
                    The authorization request has expired or is \
                    otherwise invalid.
                    """
            case .identifierParsingError(_):
                return "An internal error occurred."
            case .insufficientScope(_, _):
                return """
                    Authorization has not been granted for this \
                    operation.
                    """
            case .invalidIdCategory(_, _):
                return "An internal error occurred"
            case .topLevelKeyNotFound(_, _):
                return "The format of the data from Spotify was invalid."
            case .other(_):
                return "An unexpected error occurred."
        }
    }
    
    public var description: String {
        switch self {
             case .unauthorized(let message):
                return "SpotifyLocalError.unauthorized: \(message)"
            case .invalidState(let supplied, let received):
                return """
                    SpotifyLocalError.invalidState: The value for the state \
                    parameter provided when requesting access and refresh \
                    tokens '\(supplied ?? "nil")' did not match the value \
                    received from Spotify in the query string of the redirect URI: \
                    '\(received ?? "nil")'
                    """
            case .identifierParsingError(let message):
                return "SpotifyLocalError.identifierParsingError: \(message)"
            case .insufficientScope(let required, let authorized):
                return """
                    SpotifyLocalError.insufficientScope: The endpoint you \
                    tried to access requires the following scopes:
                    \(required.map(\.rawValue))
                    but your app is only authorized for theses scopes:
                    \(authorized.map(\.rawValue))
                    """
            case .invalidIdCategory(let expected, let received):
                return """
                    SpotifyLocalError.invalidIdCategory: expected URI to be \
                    one of the following types: \(expected.map(\.rawValue)),
                    but received \(received.rawValue)
                    """
            case .topLevelKeyNotFound(let key, let dict):
                return """
                    SpotifyLocalError.topLevelKeyNotFound: The expected top \
                    level key '\(key)' was not found in the dictionary:
                    \(dict)
                    """
            case .other(let message):
                return "SpotifyLocalError.other: \(message)"
        }
    }
  
}


