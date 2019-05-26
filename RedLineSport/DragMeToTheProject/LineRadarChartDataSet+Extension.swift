import Foundation
import CoreGraphics

extension LineRadarChartDataSet {
func copyWithZoneCannotPattern(_ target: Double, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
