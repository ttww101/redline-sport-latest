import Foundation
import CoreGraphics

extension RadarHighlighter {
func closestHighlightDoWalk(_ delegate: Float, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func getHighlightsCannotLoud(_ sender: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
