import Foundation
import CoreGraphics

extension BarChartView {
func initializeShouldRaise(_ sender: Float, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func calcMinMaxDontWantSpeak(_ target: Double, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func getHighlightByTouchPointShouldnotRaise(_ message: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func getBarBoundsCanLook(_ listener: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func groupBarsShouldListen(_ listener: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func highlightValueWantListen(_ element: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
