import Foundation

public class Countdown {

    // MARK: - Properties.

    private var timer: Timer?
    private var completion: ((_ secondsLeft: String?, _ seconds: Int?) -> Void)?
    private var seconds: Int?
    private var secondsPassed: Int = 0
    private var startDate: Date?

    // MARK: - Public Methods.

    public func start(for seconds: Int?, then completion: @escaping (_ secondsLeft: String?, _ seconds: Int?) -> Void) {
        self.completion = completion
        self.secondsPassed = 0
        self.seconds = seconds
        if let seconds = seconds {
            let second = ((seconds % 3600) % 60) > 9 ? "\((seconds % 3600) % 60)": "0\((seconds % 3600) % 60)"
            completion("0\((seconds % 3600) / 60):\(second)", seconds)
        }
        timer?.invalidate()
        
        startDate = Date()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Private Methods.

    @objc
    private func handleTimer(_ sender: Timer) {
        guard let startDate = startDate else {
            assertionFailure()
            return
        }
        
        secondsPassed = Int(Date().timeIntervalSince1970) - Int(startDate.timeIntervalSince1970)

        if let seconds = seconds {
            let secondsLeft = seconds - secondsPassed

            if secondsLeft >= 0 {
                let second = ((secondsLeft % 3600) % 60) > 9 ? "\((secondsLeft % 3600) % 60)": "0\((secondsLeft % 3600) % 60)"
                completion?("0\((secondsLeft % 3600) / 60):\(second)", secondsLeft)
            }
        }
        else {
            completion?(nil, nil)
        }
    }

}
