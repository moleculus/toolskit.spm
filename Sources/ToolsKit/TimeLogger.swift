import Foundation

public class TimeLogger {
    
    // MARK: - Properties.
    
    private var stamps: [(date: Date, message: String)] = [] {
        didSet {
            guard stamps.count > 1 else {
                return
            }
            
            let count = stamps.count
            let start = stamps[count - 2]
            let end = stamps[count - 1]
            
            let interval = end.date.timeIntervalSince1970 - start.date.timeIntervalSince1970
            let formattedInterval = String(format: "%.5f", interval)
            
            print(formattedInterval, end.message)
        }
    }
    
    // MARK: - Initialization.
    
    public init() {}
    
    // MARK: - Public Methods.
    
    public func logTime(message: String = "") {
        stamps.append((date: Date(), message: message))
    }
    
}
