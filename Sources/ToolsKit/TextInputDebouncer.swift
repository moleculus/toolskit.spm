import Foundation

public class TextInputDebouncer {
    
    private let timeInterval: TimeInterval
    private var timer: Timer?
    private var handler: ((String) -> Void)?
    
    public init(timeInterval: TimeInterval = 0.25) {
        self.timeInterval = timeInterval
    }
    
    public func check(input: String, then handler: @escaping (String) -> Void) {
        self.handler = handler
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] _ in
            self?.handler?(input)
        })
    }
    
}
