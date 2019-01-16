//
//  ThemeProperty.swift
//  KeyPathThemeManager
//
//  Created by Pat Sluth on 2018-02-15.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit





internal class PartialThemeProperty<Root>: CustomStringConvertible
{
	fileprivate init()
	{
	}
	
	internal func applyTo(_ object: inout Root, for theme: Theme)
	{
	}
	
	// MARK: CustomStringConvertible
	
	var description: String {
		return "\(type(of: self))"
	}
}





internal final class ThemeProperty<Root, Value>: PartialThemeProperty<Root>
{
	private let keyPath: WritableKeyPath<Root, Value>
	private let value: Value
	
	
	
	
	
	init(_ keyPath: WritableKeyPath<Root, Value>, _ value: Value)
	{
		self.keyPath = keyPath
		self.value = value
		
		super.init()
	}
	
//	public init(_ keyPath: ReferenceWritableKeyPath<Root, Value>, _ value: Value)
//	{
//		self.keyPath = keyPath
//		self.value = value
//
//		super.init()
//	}
	
	override func applyTo(_ object: inout Root, for theme: Theme)
	{
		if let themeable = object as? Themeable {
			guard themeable.themeManager(shouldApply: self.keyPath, for: theme) else { return }
		}
		
		object[keyPath: self.keyPath] = self.value
	}
}




