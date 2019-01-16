//
//  ThemeManager.swift
//  KeyPathThemeManager
//
//  Created by Pat Sluth on 2018-02-15.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit

import Sluthware





//public protocol ThemeProvider: RawRepresentable, CaseIterable
//{
//	var theme: Theme { get }
//}

//struct Temes: OptionSet
//{
//	init() {
//		<#code#>
//	}
//
//	typealias Element = Theme
//
//	let rawValue: Theme
//
//	 static let None = Temes(rawValue: Theme.none)
//}
//
//enum B: String, A
//{
//	case b
//}

//public enum ThemeType: String, ThemeProvider
//{
//	case None
//	case Light
//	case Dark
//	
//	public var theme: Theme {
//		var theme: Theme!
//		switch self {
//		case .None:
//			theme = Theme.none
//		case .Light:
//			theme = Theme(name: "Light",
//						  barTintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
//						  tintColor: #colorLiteral(red: 0.2823529412, green: 0.5176470588, blue: 0.2745098039, alpha: 1),
//						  isTranslucent: false,
//						  keyboardAppearance: .default)
//		case .Dark:
//			theme = Theme(name: "Dark",
//						  barTintColor: #colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1254901961, alpha: 1),
//						  tintColor: #colorLiteral(red: 0.4980392157, green: 0.7294117647, blue: 0.4901960784, alpha: 1),
//						  isTranslucent: false,
//						  keyboardAppearance: .dark)
//		}
//		
//		return theme
//	}
//}



public extension DispatchQueue
{
	private static var _onceTracker = Set<String>()
	
	
	
	
	
	/**
	Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
	only execute the code once even in the presence of multithreaded calls.
	
	- parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
	- parameter block: Block to execute once
	*/
	class func once(token: String = "\(#file):\(#function):\(#line)",
					_ block: () -> Void)
	{
		objc_sync_enter(self)
		defer { objc_sync_exit(self) }
		
		guard self._onceTracker.insert(token).inserted else { return }
		
		block()
	}
}






public final class ThemeManager
{
	public static private(set) var themes: Set<Theme> = [Theme.none]
	public private(set) static var current: Theme? = nil {
		didSet
		{
			self.userDefaults.setValue(self.current?.name, forKey: "\(Theme.self)")
			
			guard let theme = self.current else { return }
			guard theme != oldValue else { return }
			guard let window = UIApplication.shared.keyWindow else { return }
			guard let viewController = window.rootViewController else { return }
			
			viewController.recurseDecendents {
				theme.applyTo($0)
				return false
			}
		}
	}

	public static var userDefaults = UserDefaults.standard {
		didSet
		{
			// syncronize to new UserDefaults
			self.current = { self.current }()
		}
	}
	
	
	
	
	
	public class func initialize<T>(_ themes: T)
		where T: Sequence, T.Element == Theme
	{
		DispatchQueue.once({
			
			self.themes.formUnion(themes)
			self.current = self.themes.first(where: {
				$0.name == self.userDefaults.string(forKey: "\(Theme.self)")
			})
			
			
			
			do {
				try Runtime.swizzle(UIView.self,
									#selector(UIView.didMoveToSuperview),
									#selector(UIView.keyPathThemeManager_didMoveToSuperview))
				try Runtime.swizzle(UIView.self,
									#selector(UIView.didMoveToWindow),
									#selector(UIView.keyPathThemeManager_didMoveToWindow))
				try Runtime.swizzle(UIViewController.self,
									#selector(UIViewController.viewWillAppear(_:)),
									#selector(UIViewController.keyPathThemeManager_viewWillAppear(_:)))
				try Runtime.swizzle(UIViewController.self,
									#selector(UIViewController.viewDidAppear(_:)),
									#selector(UIViewController.keyPathThemeManager_viewDidAppear(_:)))
			} catch {
				print(#file.fileName, #function, error)
			}
		})
	}
	
	public class func apply(_ theme: Theme)
	{
		guard self.current != theme else { return }
		self.current = theme
		
		guard let window = UIApplication.shared.keyWindow else { return }
		guard let viewController = window.rootViewController else { return }
		
		viewController.recurseDecendents {
			theme.applyTo($0)
			return false
		}
	}
	
	@available(iOS 10.0, *)
	public class func apply(_ theme: Theme, animator: () -> UIViewPropertyAnimator)
	{
		let animator = animator()
		animator.addAnimations({
			self.apply(theme)
		})
		animator.startAnimation()
	}

	
	
	
	
	private init()
	{
		fatalError()
	}
}





fileprivate extension UIView
{
	@objc fileprivate func keyPathThemeManager_didMoveToSuperview()
	{
		self.keyPathThemeManager_didMoveToSuperview()
		
		guard let _ = self.superview else { return }
		
		ThemeManager.current?.applyTo(self)
	}
	
	@objc fileprivate func keyPathThemeManager_didMoveToWindow()
	{
		self.keyPathThemeManager_didMoveToWindow()
		
		guard let _ = self.window else { return }
		
		ThemeManager.current?.applyTo(self)
	}
}





fileprivate extension UIViewController
{
//	@objc fileprivate func keyPathThemeManager_viewDidLoad()
//	{
//		self.keyPathThemeManager_viewDidLoad()
//	}
	
	@objc fileprivate func keyPathThemeManager_viewWillAppear(_ animated: Bool)
	{
		self.keyPathThemeManager_viewWillAppear(animated)
		
		ThemeManager.current?.applyTo(self)
	}
	
	@objc func keyPathThemeManager_viewDidAppear(_ animated: Bool)
	{
		self.keyPathThemeManager_viewDidAppear(animated)
		
		ThemeManager.current?.applyTo(self)
	}
}




