//
//  Item.swift
//  Todoey
//
//  Created by Snarf on 21.08.19.
//  Copyright © 2019 Snarf. All rights reserved.
//

import Foundation


class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
    }
