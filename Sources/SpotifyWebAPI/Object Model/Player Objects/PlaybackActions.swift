import Foundation

/**
 The various actions that can be performed within the context
 of the user's current playback.
 
 For example, you cannot skip to the previous or next track/episode
 or seek to a position in a track/episode while an ad is playing.
 
 This enum maps to Spotify's [dissallows object][1].
 
 [1]: https://developer.spotify.com/documentation/web-api/reference/object-model/#disallows-object
 */
public enum PlaybackActions: String, Codable, Hashable, CaseIterable {
    
    case interruptPlayback = "interrupting_playback"
    case pause = "pausing"
    case resume = "resuming"
    case seek = "seeking"
    case skipToNext = "skipping_next"
    case skipToPrevious = "skipping_prev"
    case toggleRepeatContext = "toggling_repeat_context"
    case toggleRepeatTrack = "toggling_repeat_track"
    case toggleShuffle = "toggling_shuffle"
    case transferPlayback = "transferring_playback"
    
    // The default implementation returns an array,
    // but a set is more useful.
    public static let allCases: Set<PlaybackActions> = [
        .interruptPlayback,
        .pause,
        .resume,
        .seek,
        .skipToNext,
        .skipToPrevious,
        .toggleRepeatContext,
        .toggleRepeatTrack,
        .toggleShuffle,
        .transferPlayback
    ]
    
}
