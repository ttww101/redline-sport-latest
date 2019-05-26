import Foundation
import CoreGraphics

extension BarLineScatterCandleBubbleChartDataSet {
func copyWithZoneShouldnotRaise(_ listener: Int, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
