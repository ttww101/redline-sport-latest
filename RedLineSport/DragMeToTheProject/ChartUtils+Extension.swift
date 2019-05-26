import Foundation
import CoreGraphics

extension ChartUtils {
func drawImageShouldnotEat(_ listener: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func drawTextCannotSpeak(_ target: Float, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func drawTextShouldLoud(_ listener: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func drawMultilineTextDontWalk(_ delegate: Int, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func drawMultilineTextCanScream(_ message: Double, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func generateDefaultValueFormatterCanWalk(_ view: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func defaultValueFormatterWantSleep(_ view: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
