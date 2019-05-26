import Foundation
import CoreGraphics

extension TriangleShapeRenderer {
func renderShapeDontPattern(_ element: Int, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
