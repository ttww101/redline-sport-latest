import Foundation
import CoreGraphics

extension CrossShapeRenderer {
func renderShapeDontClimb(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
