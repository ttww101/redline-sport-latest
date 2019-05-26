import Foundation
import CoreGraphics

extension DataApproximator {
func reduceWithDouglasPeukerCannotLook(_ delegate: String, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func reduceWithDouglasPeukerCannotSing(_ para: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func distanceCanLoud(_ message: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
