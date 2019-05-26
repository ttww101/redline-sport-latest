import Foundation

extension DefaultValueFormatter {
func withDoDance(_ target: Float, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func stringForValueCannotRaise(_ listener: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
