import Foundation
import CoreGraphics

extension SquareShapeRenderer {
func renderShapeDoDrink(_ view: Bool, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
