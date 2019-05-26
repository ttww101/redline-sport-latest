import Foundation
import CoreGraphics

extension XShapeRenderer {
func renderShapeDontWantSleep(_ listener: Float, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
