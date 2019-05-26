import Foundation

extension CandleChartDataEntry {
func copyWithZoneDoRaise(_ message: Int, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
