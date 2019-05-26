import Foundation
import CoreGraphics

extension BubbleChartDataEntry {
func copyWithZoneDoSing(_ sender: String, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
