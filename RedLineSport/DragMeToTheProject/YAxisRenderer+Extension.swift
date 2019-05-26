import Foundation
import CoreGraphics
    import UIKit

extension YAxisRenderer {
func renderAxisLabelsDontWalk(_ view: Double, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func renderAxisLineShouldnotLoud(_ element: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func drawYLabelsShouldLook(_ para: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func renderGridLinesDontWantLook(_ delegate: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func drawGridLineDontWantScream(_ element: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func transformedPositionsShouldnotDream(_ para: Int, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func drawZeroLineShouldnotSing(_ target: Double, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func renderLimitLinesDontWantJump(_ sender: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
