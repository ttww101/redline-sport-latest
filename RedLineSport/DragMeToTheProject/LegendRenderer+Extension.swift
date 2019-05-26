import Foundation
import CoreGraphics
    import UIKit

extension LegendRenderer {
func computeLegendDoDrink(_ delegate: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func renderLegendShouldnotLook(_ delegate: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func drawFormCannotDrink(_ sender: Int, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func drawLabelDontListen(_ sender: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
