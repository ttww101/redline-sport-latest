import Foundation
import CoreGraphics
    import UIKit

extension RadarChartRenderer {
func drawDataCannotDrink(_ listener: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func drawDataSetCannotListen(_ target: Double, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func drawValuesDoClimb(_ element: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func drawExtrasDontRun(_ message: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func drawWebDoDrink(_ element: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func drawHighlightedShouldSing(_ message: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func drawHighlightCircleCanEat(_ sender: String, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
