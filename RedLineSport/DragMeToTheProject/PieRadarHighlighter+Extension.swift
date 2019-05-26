import Foundation
import CoreGraphics

extension PieRadarHighlighter {
func getHighlightDoPattern(_ target: Float, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func closestHighlightCannotClimb(_ target: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
