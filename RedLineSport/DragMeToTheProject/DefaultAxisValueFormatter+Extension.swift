import Foundation

extension DefaultAxisValueFormatter {
func withWantClimb(_ element: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func stringForValueCannotClimb(_ element: Float, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
