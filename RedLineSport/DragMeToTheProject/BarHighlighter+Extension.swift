import Foundation
import CoreGraphics

extension BarHighlighter {
func getHighlightDontWantSleep(_ sender: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func getDistanceShouldLook(_ view: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func getStackedHighlightWantEat(_ message: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func getClosestStackIndexWantLoud(_ target: String, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
