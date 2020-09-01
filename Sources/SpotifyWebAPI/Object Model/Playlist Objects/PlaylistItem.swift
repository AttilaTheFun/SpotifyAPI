/**
 Either a track or an episode. Used for endpoints
 that return track and/or episode objects.

 This enum has two cases with associated values:
 ```
 case track(Track)
 case episode(Episode)
 ```
 
 It also has convenience properties for every property
 that is common to both tracks and episodes, such as the name and URI.
 
 
 This is usually, but not always, returned in the context of
 a playlist.
 
 */
public enum PlaylistItem: Hashable {
    
    case track(Track)
    case episode(Episode)
    
    /// The name of the item
    @inlinable
    public var name: String {
        switch self {
            case .track(let track):
                return track.name
            case .episode(let episode):
                return episode.name
        }
    }
    
    /// The [Spotify URI][1] for the item.
    ///
    /// [1]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
    @inlinable
    public var uri: String? {
        switch self {
            case .track(let track):
                return track.uri
            case .episode(let episode):
                return episode.uri
        }
    }
    
    /// The [Spotify ID] for the item.
    ///
    /// [1]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
    @inlinable
    public var id: String? {
        switch self {
            case .track(let track):
                return track.id
            case .episode(let episode):
                return episode.id
        }
    }
    
    /// The length of the item in milliseconds.
    @inlinable
    public var durationMS: Int? {
        switch self {
            case .track(let track):
                return track.durationMS
            case .episode(let episode):
                return episode.durationMS
        }
    }
    
    /// Whether or not the item has explicit content.
    /// `false` if unknown.
    @inlinable
    public var isExplicit: Bool {
        switch self {
            case .track(let track):
                return track.isExplicit
            case .episode(let episode):
                return episode.isExplicit
        }
    }
    
    /// Part of the response when [Track Relinking][1] is applied.
    /// Else, `nil`. If `true`, the item is playable in the given market.
    /// Otherwise, `false`.
    ///
    /// [1]: https://developer.spotify.com/documentation/general/guides/track-relinking-guide/
    @inlinable
    public var isPlayable: Bool? {
        switch self {
            case .track(let track):
                return track.isPlayable
            case .episode(let episode):
                return episode.isPlayable
        }
    }
    
    /**
     A link to the Spotify web API endpoint
     providing the full version of the item.
     
     Use `getHref(_:responseType:)` to retrieve the full results.
     */
    @inlinable
    public var href: String? {
        switch self {
            case .track(let track):
                return track.href
            case .episode(let episode):
                return episode.href
        }
    }
    
    /**
     Known [external urls][1] for this item.

     - key: The type of the URL, for example:
           "spotify" - The [Spotify URL][2] for the object.
     - value: An external, public URL to the object.

     [1]: https://developer.spotify.com/documentation/web-api/reference/object-model/#external-url-object
     [2]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
     */
    @inlinable
    public var externalURLs: [String: String]? {
        switch self {
            case .track(let track):
                return track.externalURLs
            case .episode(let episode):
                return episode.externalURLs
        }
    }
    
    /// Either `track` or `episode`.
    @inlinable
    public var type: IDCategory {
        switch self {
            case .track(_):
                return .track
            case .episode(_):
                return .episode
        }
    }

}

extension PlaylistItem: Codable {
    
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let type = try container.decode(IDCategory.self, forKey: .type)
        
        switch type {
            case .track:
                self = try .track(Track(from: decoder))
            case .episode:
                self = try .episode(Episode(from: decoder))
            default:
                let debugDescription = "expected type of object to be " +
                    "track or episode but received \(type.rawValue)"
                throw DecodingError.dataCorruptedError(
                    forKey: .type,
                    in: container,
                    debugDescription: debugDescription
            )
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        
        switch self {
            case .track(let track):
                try track.encode(to: encoder)
            case .episode(let episode):
                try episode.encode(to: encoder)
        }
        
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
}