//
//  ImageMediaItem.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/25/23.
//

import Foundation
import UIKit
import MessageKit

struct ImageMediaItem: MediaItem {
  var url: URL?
  var image: UIImage?
  var placeholderImage: UIImage
  var size: CGSize

  init(image: UIImage) {
    self.image = image
    self.size = CGSize(width: 240, height: 240)
    self.placeholderImage = UIImage()
  }
}
