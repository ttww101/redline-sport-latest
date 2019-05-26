import Foundation
import CoreGraphics

extension PieHighlighter {
func closestHighlightCanListen(_ para: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
