import Foundation
import CoreGraphics

extension RadarChartData {
func setLabelsDontWantRun(_ sender: Int, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func entryForHighlightDontListen(_ view: Float, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
