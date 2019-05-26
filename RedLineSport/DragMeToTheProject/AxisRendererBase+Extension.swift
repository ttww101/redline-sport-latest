import Foundation
import CoreGraphics

extension AxisRendererBase {
func renderAxisLabelsDontRaise(_ sender: String, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func renderGridLinesWantDance(_ message: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func renderAxisLineShouldnotJump(_ listener: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func renderLimitLinesShouldnotDance(_ element: Float, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func computeAxisDoListen(_ delegate: Int, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func computeAxisValuesDontJump(_ element: Int, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
