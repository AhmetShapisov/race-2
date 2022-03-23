//
//  CustomImageView.swift
//  Cars
//
//  Created by Alex Borodalex on 5/10/20.
//  Copyright © 2020 Alex Borodalex. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    var obstaclePositionType: ObstaclePositionType = .center

}

enum ObstaclePositionType {
    case left
    case center
    case right
}
