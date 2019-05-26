import Foundation
import CoreGraphics

extension CandleStickChartView {
func initializeCannotSpeak(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
