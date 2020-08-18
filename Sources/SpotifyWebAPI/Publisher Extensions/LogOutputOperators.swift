import Foundation
import Combine
import Logger

public extension Publisher {
    
    /// Logs any errors in the stream.
    func logError(
        _ prefix: String = "",
        to logger: Logger,
        level: Logger.Level = .trace,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Publishers.MapError<Self, Failure>  {
        
        return self.mapError { error in
            logger.log(
                level: level,
                "\(prefix) \(error)",
                file: file,
                function: function,
                line: line
            )
            return error
        }
    }
    
    /// Logs all values in the stream.
    func logOutput(
        _ prefix: String = "",
        to logger: Logger,
        level: Logger.Level = .trace,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Publishers.HandleEvents<Self> {
        
        return self.handleEvents(
            receiveOutput: { output in
                logger.log(
                    level: level,
                    "\(prefix) \(output)",
                    file: file,
                    function: function,
                    line: line
                )
            }
        )
        
    }
    
}