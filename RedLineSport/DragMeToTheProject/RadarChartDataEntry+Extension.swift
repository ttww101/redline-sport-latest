import Foundation
import CoreGraphics

extension RadarChartDataEntry {
func copyWithZoneDoDream(_ sender: String, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
