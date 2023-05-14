import Foundation
import Combine

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {

    /**
     The network adaptor that this library uses by default for all network
     requests. Uses `URLSession`.
    
     During tests it will sometimes use a different network adaptor.

     - Parameter request: The request to send.
     */
    public static func defaultNetworkAdaptor(
        request: URLRequest
    ) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        
        return Self._defaultNetworkAdaptor(request)

    }

    /// This property exists so that it can be replaced with a different
    /// networking client during testing. Other than in the test targets, it
    /// will not be modified.
    static var _defaultNetworkAdaptor: (
        URLRequest
    ) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> = { request in
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .map { data, response -> (data: Data, response: HTTPURLResponse) in
                guard let httpURLResponse = response as? HTTPURLResponse else {
                    fatalError(
                        "could not cast URLResponse to HTTPURLResponse:\n\(response)"
                    )
                }
               // let dataString = String(data: data, encoding: .utf8) ?? "nil"
               // print("_defaultNetworkAdaptor: \(response.url!): \(dataString)")
                return (data: data, response: httpURLResponse)
            }
            .eraseToAnyPublisher()

    }
    
}
