//
//  UIExpandableView.swift
//  UIKitExtension
//
//  Copyright © 2017 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 7/17/17.
//

open class UIExpandableView: UIView {
    
    open var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    open var detailTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    open var toggleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        return button
    }()
    
    fileprivate var isExpanded: Bool = false
    fileprivate var detailHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        addSubview(textLabel)
        addSubview(detailTextLabel)
        addSubview(toggleButton)
        toggleButton.addTarget(self, action: #selector(handleToggle(_:)), for: .touchUpInside)
        
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: detailTextLabel.topAnchor, right: toggleButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 2, rightConstant: 2, widthConstant: 0, heightConstant: 20)
        toggleButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        toggleButton.anchorHeightToItem(textLabel)
        toggleButton.anchorAspectRatio()
        
        detailHeightConstraint = detailTextLabel.anchorWithReturnAnchors(textLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 2, rightConstant: 8, widthConstant: 0, heightConstant: .leastNonzeroMagnitude).last
    }
    
    // MARK: View Toggle
    
    open func handleToggle(_ button: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.isExpanded {
                // Close
                button.imageView?.transform = CGAffineTransform.identity
                self.detailHeightConstraint?.isActive = true
                self.superview?.layoutIfNeeded()
            } else {
                // Open
                button.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.detailHeightConstraint?.isActive = false
                self.superview?.layoutIfNeeded()
            }
        }) { success in
            if success {
                self.isExpanded = !self.isExpanded
            }
        }
    }
}

