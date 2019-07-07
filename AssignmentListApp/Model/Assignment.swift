//
//  Assignment.swift
//  AssignmentListApp
//
//  Created by nanashiki on 2019/05/25.
//  Copyright © 2019 nanashiki. All rights reserved.
//

import Foundation

struct Assignment {
    let title: String
    
    var isValid: Bool {
        return !title.isEmpty
    }
}
