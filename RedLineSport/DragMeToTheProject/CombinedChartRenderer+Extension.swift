import Foundation
import CoreGraphics

extension CombinedChartRenderer {
func createRenderersDoPattern(_ view: Int, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func initBuffersDontRun(_ message: Float, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func drawDataWantLook(_ target: Float, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func drawValuesDontWantLook(_ target: Double, title: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func drawExtrasCanLoud(_ para: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func drawHighlightedShouldnotWalk(_ para: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func getSubRendererDontWantListen(_ element: String, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
