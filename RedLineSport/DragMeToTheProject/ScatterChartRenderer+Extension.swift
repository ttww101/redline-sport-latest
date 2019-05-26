import Foundation
import CoreGraphics
    import UIKit

extension ScatterChartRenderer {
func drawDataCanLoud(_ listener: Int, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func drawDataSetShouldnotSpeak(_ para: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func drawValuesCannotPattern(_ para: String, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func drawExtrasCanDream(_ listener: Float, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func drawHighlightedDoRun(_ element: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
