//
//  UIContainerController.swift
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
//  Created by Nathan Tannar on 7/10/17.
//

import UIKit

/// A controller designed to be subclassed to easily make custom container controllers
open class UIContainerController: UIViewController {
    
    public var viewControllers: [String:UIViewController] {
        get {
            return _viewControllers
        }
    }
    fileprivate var _viewControllers: [String:UIViewController] = [:]
   
    // MARK: - Initialization
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - UIContainerController Methods
    
    /// Called after initialization to set up the containers initial state
    open func setup() {
        // Implement your own logic
    }
    
    /// Adds a view controller's view and parent pointer to the container
    ///
    /// - Parameter viewController: The view controller to add
    ///   - animated: If the appearance transition is animated
    ///   - key: If not nil, the viewController will be hashable via the 'viewControllers' array
    open func addViewController(_ viewController: UIViewController, animated: Bool = false, forKey key: String?) {
        
        viewController.willMove(toParentViewController: self)
        addChildViewController(viewController)
        viewController.beginAppearanceTransition(true, animated: animated)
        view.addSubview(viewController.view)
        controllerIsTransitioning(viewController, isAppearing: true, animated: animated)
        viewController.endAppearanceTransition()
        viewController.didMove(toParentViewController: self)
        if let key = key {
            _viewControllers[key] = viewController
        }
    }
    
    
    /// Called while the viewController is transitioning
    ///
    /// - Parameters:
    ///   - viewController: The view controller that is transitioning
    ///   - isAppearing: If the viewController is being added or removed
    ///   - animated: If the transition is animated
    open func controllerIsTransitioning(_ viewController: UIViewController, isAppearing: Bool, animated: Bool = false) {
        // Implement your own logic
    }
    
    /// Removes a view controller's view and parent pointer from the container. Removes the hashable reference if one existed
    ///
    /// - Parameter viewController: The view controller to remove
    /// - Returns: If the viewController passed was able to be removed
    @discardableResult
    open func removeViewController(_ viewController: UIViewController, animated: Bool = false) -> Bool {
        if !childViewControllers.contains(viewController) {
            return false
        }
        viewController.willMove(toParentViewController: nil)
        viewController.beginAppearanceTransition(false, animated: animated)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
        viewController.endAppearanceTransition()
        for (key, controller) in _viewControllers {
            if controller == viewController {
                _viewControllers.removeValue(forKey: key)
            }
        }
        return true
    }
}
