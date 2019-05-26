import Foundation
import CoreGraphics
    import UIKit

extension YAxisRendererRadarChart {
func computeAxisValuesCanWalk(_ listener: String, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func renderAxisLabelsDontDance(_ sender: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func renderLimitLinesDoLook(_ target: Bool, title: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
