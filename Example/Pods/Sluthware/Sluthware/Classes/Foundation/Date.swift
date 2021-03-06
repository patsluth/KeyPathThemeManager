//
//  Date.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Date
{
	public init?(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int)
	{
		let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
		guard let date = calendar.date(from: DateComponents(year: year,
															month: month,
															day: day,
															hour: hour,
															minute: minute,
															second: second)) else {
																return nil
		}
		
		self = date
	}
}




