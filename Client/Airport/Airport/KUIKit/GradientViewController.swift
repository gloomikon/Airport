import UIKit

class GradientViewController: BaseViewController {
    private let layer = CAGradientLayer()
    private let colors = [[UIColor.sakuraTree.cgColor, UIColor.clearSky.cgColor],
                          [UIColor.coldAir.cgColor, UIColor.morningMilk.cgColor]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        layer.frame = view.bounds
        layer.colors = colors.randomElement()
        view.layer.insertSublayer(layer, at: 0)
    }
}
