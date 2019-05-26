import Foundation

extension IndexAxisValueFormatter {
func withWantDrink(_ element: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func stringForValueShouldWalk(_ delegate: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
