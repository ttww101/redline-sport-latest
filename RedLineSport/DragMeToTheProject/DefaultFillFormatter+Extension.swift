import Foundation
import CoreGraphics
    import UIKit

extension DefaultFillFormatter {
func withShouldDream(_ para: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func getFillLinePositionDoListen(_ message: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
