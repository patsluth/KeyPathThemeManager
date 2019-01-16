//
//  Theme.swift
//  KeyPathThemeManager
//
//  Created by Pat Sluth on 2018-02-15.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit





public class Theme
{
	public let name: String
	
	public let barTintColor: UIColor?
	public let tintColor: UIColor
	public let isTranslucent: Bool
	public let keyboardAppearance: UIKeyboardAppearance
	
	public let tintedTextAttibutes: [NSAttributedString.Key: Any]
	private var components: [AnyThemeComponent]
	
	
	
	
	
	public required init(name: String,
						 barTintColor: UIColor?,
						 tintColor: UIColor!,
						 isTranslucent: Bool!,
						 keyboardAppearance: UIKeyboardAppearance!)
	{
		self.name = name
		
		// fallback to system defaults
		self.barTintColor = barTintColor ?? UINavigationBar().barTintColor
		self.tintColor = tintColor ?? UIView().tintColor
		self.isTranslucent = isTranslucent ?? UINavigationBar().isTranslucent
		self.keyboardAppearance = keyboardAppearance ?? .default
		
		self.tintedTextAttibutes = [.foregroundColor: self.tintColor]
		self.components = []
		
		
		
		self.add(ThemeComponent<UIViewController>({
			$0.property(\UIViewController.view!.tintColor, self.tintColor)
		}))
		
		if #available(iOS 11.0, *) {
			self.add(ThemeComponent<UINavigationBar>({
				$0.property(\UINavigationBar.barTintColor, self.barTintColor)
				$0.property(\UINavigationBar.tintColor, self.tintColor)
				$0.property(\UINavigationBar.isTranslucent, self.isTranslucent)
				$0.property(\UINavigationBar.titleTextAttributes, self.tintedTextAttibutes)
				$0.property(\UINavigationBar.largeTitleTextAttributes, self.tintedTextAttibutes)
			}))
		}
		
		self.add(ThemeComponent<UITabBar>({
			$0.property(\UITabBar.barTintColor, self.barTintColor)
			$0.property(\UITabBar.tintColor, self.tintColor)
			$0.property(\UITabBar.isTranslucent, self.isTranslucent)
		}))
		
		self.add(ThemeComponent<UIToolbar>({
			$0.property(\UIToolbar.barTintColor, self.barTintColor)
			$0.property(\UIToolbar.tintColor, self.tintColor)
			$0.property(\UIToolbar.isTranslucent, self.isTranslucent)
		}))
		
		self.add(ThemeComponent<UISearchBar>({
			$0.property(\UISearchBar.barTintColor, self.barTintColor)
			$0.property(\UISearchBar.tintColor, self.tintColor)
			$0.property(\UISearchBar.isTranslucent, self.isTranslucent)
		}))
		
		self.add(ThemeComponent<UITextView>({
			$0.property(\UITextView.keyboardAppearance, self.keyboardAppearance)
		}))
		
//		self.add(ThemeComponent<UITextField>({
////			ThemeProperty(\UITextField.tintColor, self.tintColor),
//			ThemeProperty(\UITextField.defaultTextAttributes, self.tintedTextAttibutes),
//			]) {
//				// Apply tint to image views
//				for case let subview as UIImageView in $0.subviews {
//					subview.image = subview.image?.withRenderingMode(.alwaysTemplate)
//				}
//
//				// Apply tint to placeholder text
//				guard let placeholder = $0.attributedPlaceholder?.string ?? $0.placeholder else { return }
//				$0.attributedPlaceholder = NSAttributedString(string: placeholder,
//																attributes: $0.defaultTextAttributes)
//			}
//			.addingConstraint(when: .ContainedIn, is: UISearchBar.self)
//		}))
	}
	
	@discardableResult
	public func add<T>(_ themeComponent: ThemeComponent<T>) -> Self
		where T: AnyObject
	{
		self.components.append(themeComponent)
		return self
	}
	
	internal func applyTo<T>(_ viewController: T)
		where T: UIViewController
	{
		self.components.forEach {
			$0.applyTo(viewController, for: self)
		}
	}
	
	internal func applyTo<T>(_ view: T)
		where T: UIView
	{
		self.components.forEach {
			$0.applyTo(view, for: self)
		}
	}
	
	
	
//	public static func +(lhs: Fraction, rhs: Fraction) -> Fraction
//	{
//		let num = (lhs.num * rhs.den) + (lhs.den * rhs.num)
//		let den = (lhs.den * rhs.den)
//
//		return Fraction(num, den)//.reduced()
//	}
}





precedencegroup ThemeComponentPrecedence {
	associativity: left
	higherThan: LogicalConjunctionPrecedence
}

infix operator ++: ThemeComponentPrecedence

@discardableResult
public func ++<T>(lhs: Theme, rhs: ThemeComponent<T>) -> Theme
	where T: AnyObject
{
	lhs.add(rhs)
	return lhs
}



//precedencegroup ThemePropertyPrecedence {
//	associativity: left
//	higherThan: ThemeComponentPrecedence
//}
//
//infix operator +++: ThemePropertyPrecedence
//
//@discardableResult
//public func +++<R, V>(lhs: ThemeComponent<R>, rhs: (WritableKeyPath<R, V>, V)) -> ThemeComponent<R>
//{
//	lhs.add(rhs.0, rhs.1)
//	return lhs
//}
//
//@discardableResult
//public func +++<R>(lhs: ThemeComponent<R>, rhs: @escaping ThemeComponent<R>.OnApplyClosure) -> ThemeComponent<R>
//{
//	lhs.onApply(rhs)
//	return lhs
//}





extension Theme
{
	static let none = Theme(name: "None",
							barTintColor: nil,
							tintColor: nil,
							isTranslucent: nil,
							keyboardAppearance: nil)
}





extension Theme: Equatable
{
	public static func == (lhs: Theme, rhs: Theme) -> Bool
	{
		return (lhs.name == rhs.name)
	}
}





extension Theme: Hashable
{
	public func hash(into hasher: inout Hasher)
	{
		hasher.combine(self.name)
	}
}





extension Theme: CustomStringConvertible
{
	public var description: String {
		return "\(type(of: self)).\(self.name)"
	}
}




