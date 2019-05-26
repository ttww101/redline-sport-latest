import Foundation
import CoreGraphics

extension PieChartDataSet {
func initializeCanClimb(_ sender: String, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func calcMinMaxShouldnotWalk(_ view: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func copyWithZoneWantSpeak(_ target: String, title: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
