//
//  AppDelegate.swift
//  KeyPathThemeManager
//
//  Created by patsluth on 01/12/2019.
//  Copyright (c) 2019 patsluth. All rights reserved.
//

import UIKit

import KeyPathThemeManager
import Sluthware





extension Theme
{
	static let light = Theme(name: "Light",
							 barTintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
							 tintColor: #colorLiteral(red: 0.2823529412, green: 0.5176470588, blue: 0.2745098039, alpha: 1),
							 isTranslucent: false,
							 keyboardAppearance: .default)
	
	static let dark = Theme(name: "Dark",
							barTintColor: #colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1254901961, alpha: 1),
							tintColor: #colorLiteral(red: 0.4980392157, green: 0.7294117647, blue: 0.4901960784, alpha: 1),
							isTranslucent: false,
							keyboardAppearance: .dark)
}




//class KeyPathChain<Root, Value>
//{
//	let kp: KeyPath<Root, Value>
//	var next: AnyKeyPath?
//
//	init(prev: KeyPath<Root, Value>)
//	{
//		self.kp = prev
//	}
//
//	func add<NextValue>(_ kp: WritableKeyPath<Root, NextValue>) -> KeyPathChain<Value, NextValue>
//	{
//		return
//	}
//}


//extension Any
//{
//	
//}



//func map<Root, V>(keyPath: KeyPath<Root, Optional<V>>,
////				  to: PartialKeyPath<V>,
//				  for root: Root) -> Promise<V>
////	where K1: KeyPath<Root, Optional<V>>, K2: PartialKeyPath<V>
//{
//	print("?")
//	return Promise { resolver in
//		switch root[keyPath: keyPath] {
//		case .none:
//			resolver.reject(Errors.Message("UNWRAP TEMP"))
//		case .some(let value):
//			resolver.fulfill(value)
//		}
//	}
//}
//
//func map<Root, V>(keyPath: KeyPath<Root, V>,
//				  //				  to: PartialKeyPath<V>,
//	for root: Root) -> Promise<V>
//	//	where K1: KeyPath<Root, Optional<V>>, K2: PartialKeyPath<V>
//{
////	print("!")
////	success(r[keyPath: me])
//
//	return Promise { resolver in
//		resolver.fulfill(root[keyPath: keyPath])
//	}
//}


extension KeyPath
{
	func test<V>(_ w: WritableKeyPath<Root, V>)
		where Value == V?
	{
		
	}
//	func test<T>() where Value == T?
//	{}
	
//	func test2<T>() where T == Value
//	{}
}




//protocol AnySafeKeyPath
//{
//	associatedtype Root
//	associatedtype Value
//
//	func set(value: Value, forObject object: inout Root)
//}


//protocol WritableKeyPathProvider
//{
//	func writableKeyPath<R, V>(_ rootType: R.Type, valueType: V.Type) -> WritableKeyPath<R, V>
//}
//
//extension WritableKeyPath: WritableKeyPathProvider
//{
//	func writableKeyPath<R, V>(_ rootType: R.Type, valueType: V.Type) -> WritableKeyPath<R, V>
//		where Self.R == Root, V == Self.Value
//	{
//		return self
//	}
//}

class PartialSafeWritableKeyPath<Root, Value>
{
	private let keyPath: WritableKeyPath<Root, Value>
	
	init(_ keyPath: WritableKeyPath<Root, Value>)
	{
		self.keyPath = keyPath
	}
	
	func update(object root: inout Root, with value: Value)
	{
		root[keyPath: self.keyPath] = value
	}
}

class SafeWritableKeyPath<Root, Value>: PartialSafeWritableKeyPath<Root, Value>
{
	private let keyPath: PartialKeyPath<Root>
	
	init<V>(_ keyPath1: KeyPath<Root, V?>, _ keyPath2: WritableKeyPath<Root, Value>)
	{
		self.keyPath = keyPath1
		
		super.init(keyPath2)
	}
	
	override func update(object root: inout Root, with value: Value)
	{
		if Optional(root[keyPath: self.keyPath]) != nil {
			super.update(object: &root, with: value)
		}
	}
}






@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	
	
	struct Person {
		var address: Address!
	}
	struct Address {
		var fullAddress: String
	}
	
	struct Person2 {
		var address: Address2! = Address2()
	}
	struct Address2 {
		var a3: Address3 = Address3()
	}
	struct Address3 {
		var fullAddress: String = "V"
	}
	
	
	
//	class SafePartialWritableKeyPath<Root, Value>
//	{
//		private let keyPath: WritableKeyPath<Root, Value>
//
//		init(_ keyPath: WritableKeyPath<Root, Value>)
//		{
//			self.keyPath = keyPath
//		}
//
//		func set(value: Value, forObject object: inout Root)
//		{
//			object[keyPath: self.keyPath] = value
//		}
//	}
//
//
//
//	class SafeWritableKeyPath<Root, Value>: SafePartialWritableKeyPath<Root, Value>
//	{
//		private let keyPath: KeyPath<Root, Optional<Value>>
//
//		init(_ keyPath1: KeyPath<Root, Optional<Value>>, _ keyPath2: WritableKeyPath<Root, Value>)
//		{
//			self.keyPath = keyPath1
//
//			super.init(keyPath2)
//		}
//
//		//		init(_ keyPath2: WritableKeyPath<Root, Value>)
//		//		{
//		//			self.keyPath1 = nil
//		//			self.keyPath2 = keyPath2
//		//		}
//
//		override func set(value: Value, forObject object: inout Root)
//		{
//			switch object[keyPath: self.keyPath] {
//			case .none:
//				break
//			case .some(_):
//				super.set(value: value, forObject: &object)
//			}
//		}
//
//		//		public subscript (object: Root) -> Value!
//		//		{
//		//			get
//		//			{
//		//				ret
//		//			}
//		//			set
//		//			{
//		//
//		//			}
//		//		}
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
	{
		let any = \Person2.address?.a3// as PartialKeyPath<Person2>
		
//		if let a = any as?WritableKeyPath<Person2, Address3> {
//
//		}
//		switch any {
//		case let p as WritableKeyPath<Person2, Address3>:
//			print("W")
//		case let p as KeyPath<Person2, Optional<Address3>>:
//			print("K")
//		default:
//			print("B")
//		}
		var p2 = Person2()
		let x = \Person2.address?.a3 as PartialKeyPath<Person2>
		print(Optional(p2[keyPath: x]))
		
		print("A", p2.address.a3.fullAddress)
		SafeWritableKeyPath(\Person2.address?.a3, \Person2.address!.a3.fullAddress)
			.update(object: &p2, with: "Yulia")
		print("A", p2.address.a3.fullAddress)
//		SafeWritableKeyPath(\Person2.address!.a3.fullAddress)
//			.set(value: "Yulia", forObject: &p2)
//		print("A", p2.address?.a3.fullAddress)
		
		
//		print(((\Person.address?.fullAddress) as AnyKeyPath) as? WritableKeyPath<Person, String>)
//		print(((\Person.address!.fullAddress) as AnyKeyPath) as? WritableKeyPath<Person, String>)
		
		
		
		
		
//		let a = \Person.address.fullAddress//?.fullAddress[0]
//		let b = a as AnyKeyPath
//		let b = a.appending(path: \Address.fullAddress)
//		print(a)
//		let a = \Person.address.fullAddress
//		print(a as? KeyPath<Person, String!>)
		
		var pers1 = Person.init(address: AppDelegate.Address.init(fullAddress: "PAT"))
		var pers2 = Person.init(address: nil)
		
//		let n = \Address?.fullAddress
//		let aa = \Person.address
//		let bbb = \Address.fullAddress
		
//		map(keyPath: \Person.address, for: pers1)
//			.done({
//				print("A", $0)
//			})
//
//		map(keyPath: \Person.address, for: pers2)
//			.done({
//				print("B", $0)
//			})
		
//		map(r: pers1, me: \Person.address, next: \Address.fullAddress, success: { vvv in
//			print(vvv)
//		})
//		map(r: pers2, me: \Person.address, next: \Address.fullAddress, success: { vvv in
//			print(vvv)
//		})
//		map(r: pers1, me: aa, next: bbb, success: { v in
//
//		})
//		map(r: pers2, me: aa, next: bbb, success: { v in
//
//		})
		
//		print(pers1[keyPath: b])
////		pers1[keyPath: b] = "A"
//		print(pers1[keyPath: b])
//		print(pers1)
		
//		var pers2 = Person.init(address: nil)
////		pers2[keyPath: \Person.address.fullAddress] = "A" as String?
//		print(pers2[keyPath: \Person.address])
//		print(pers2[keyPath: \Person.address.fullAddress])
//		let b = \Address?.fullAddress?.fileName
//		dump(a.appending(path: b as AnyKeyPath))
//		dump(\Person.address)
		
		
//		Theme.light.add(ThemeComponent([
//			ThemeProperty(\UITableView.backgroundColor, UIColor.red),
//			])
//		)
//		Theme.light.add(ThemeComponent([
//			ThemeProperty(\ViewController.view!.alpha, 0.5),
//			])
//		)
//		Theme.dark.add(ThemeComponent([
//			ThemeProperty(\UITableView.backgroundColor, UIColor.yellow),
//			])
//		)
		
//		let a = ThemeComponent<ViewController>({ _ in })
//			+++ (\ViewController.tableView.backgroundColor, UIColor.orange)
//			+++ (\ViewController.tableView.alpha, 0.8)
		
		Theme.light ++
			ThemeComponent<ViewController>({
				$0.property(\ViewController.tableView.backgroundColor, UIColor.orange)
				$0.property(\ViewController.tableView.alpha, 0.8)
				
				$0.onApply({
					print($0.view.bounds)
				})
				$0.onApply({
					print($0.view.bounds)
				})
				$0.onApply({
					print($0.view.bounds)
				})
				$0.onApply({
					print($0.view.bounds)
				})
			})
		
		
		
		
		
//		Theme.light
//			.add(ThemeComponent<ViewController>({
//				$0.add(\ViewController.tableView.backgroundColor, UIColor.orange)
//			}))
//			.add(ThemeComponent<ViewController>({
//				$0.add(\ViewController.tableView.alpha, 0.8)
//			}))
		Theme.dark
			.add(ThemeComponent<ViewController>({
				$0.property(\ViewController.tableView.backgroundColor, UIColor.purple)
				$0.property(\ViewController.tableView.alpha, 0.1)
			}))
//			.add(ThemeComponent<ViewController>({
//			}))
		
		
		ThemeManager.initialize([Theme.light, Theme.dark])
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication)
	{
	}
	
	func applicationDidEnterBackground(_ application: UIApplication)
	{
	}
	
	func applicationWillEnterForeground(_ application: UIApplication)
	{
	}
	
	func applicationDidBecomeActive(_ application: UIApplication)
	{
	}
	
	func applicationWillTerminate(_ application: UIApplication)
	{
	}
}





