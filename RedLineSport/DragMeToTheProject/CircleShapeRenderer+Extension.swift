import Foundation
import CoreGraphics

extension CircleShapeRenderer {
func renderShapeWantSpeak(_ message: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
