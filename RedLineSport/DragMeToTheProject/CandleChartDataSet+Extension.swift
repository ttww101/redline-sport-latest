import Foundation
import CoreGraphics

extension CandleChartDataSet {
func calcMinMaxCanDream(_ delegate: Int, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func calcMinMaxYDontWantPattern(_ sender: Bool, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
