import Combine
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if DEBUG
enum DebugHooks {
    
    static let receiveRateLimitedError = PassthroughSubject<RateLimitedError, Never>()

}
#endif
