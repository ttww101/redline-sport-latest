import Foundation
import CoreGraphics

extension PieChartDataEntry {
func copyWithZoneCanRun(_ view: Int, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
