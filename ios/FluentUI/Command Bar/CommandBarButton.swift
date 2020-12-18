//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

class CommandBarButton: UIButton {
    let item: CommandBarItem

    private let isFixed: Bool

    override var isHighlighted: Bool {
        didSet {
            updateStyle()
        }
    }

    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }

    override var isEnabled: Bool {
        didSet {
            updateStyle()
        }
    }

    init(item: CommandBarItem, isFixed: Bool = false) {
        self.item = item
        self.isFixed = isFixed

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        widthAnchor.constraint(equalToConstant: Constants.buttonWidth).isActive = true
        setImage(item.iconImage, for: .normal)

        accessibilityLabel = item.accessibilityLabel

        updateState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateState() {
        isEnabled = item.isEnabled
        isSelected = !isFixed && item.isSelected
    }
}

private extension CommandBarButton {
    struct Constants {
        static let buttonWidth: CGFloat = 40
        static let normalTintColor: UIColor = Colors.textPrimary
        static let normalBackgroundColor = UIColor(light: Colors.gray50, dark: Colors.gray600)
        static let highlightedBackgroundColor = UIColor(light: Colors.gray100, dark: Colors.gray900)
    }

    var selectedTintColor: UIColor {
        guard let window = window else {
            return Colors.communicationBlue
        }

        return Colors.primary(for: window)
    }

    var selectedBackgroundColor: UIColor {
        guard let window = window else {
            return Colors.Palette.communicationBlueTint30.color
        }

        return Colors.primaryTint30(for: window)
    }

    func updateStyle() {
        tintColor = isSelected ? selectedTintColor : Constants.normalTintColor

        if isFixed {
            backgroundColor = .clear
        } else {
            if isSelected {
                backgroundColor = selectedBackgroundColor
            } else if isHighlighted {
                backgroundColor = Constants.highlightedBackgroundColor
            } else {
                backgroundColor = Constants.normalBackgroundColor
            }
        }
    }
}
