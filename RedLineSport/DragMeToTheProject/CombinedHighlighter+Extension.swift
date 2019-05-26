import Foundation
import CoreGraphics

extension CombinedHighlighter {
func getHighlightsDontWantJump(_ view: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
