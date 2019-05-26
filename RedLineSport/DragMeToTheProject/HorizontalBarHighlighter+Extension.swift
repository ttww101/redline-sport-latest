import Foundation
import CoreGraphics

extension HorizontalBarHighlighter {
func getHighlightShouldnotListen(_ para: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func buildHighlightsShouldnotSing(_ listener: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func getDistanceDontListen(_ element: Int, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
