//
//  CommonClass.swift
//  ToDoListCoreDataAY
//
//  Created by Abhishek Yadav on 24/02/24.
//

import UIKit

class CommonClass {
    static let shared = CommonClass()
    func attributedString(withText text: String, image: UIImage, imageSize: CGSize) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: .zero, size: imageSize)
        
        let attributedString = NSMutableAttributedString(string: text)
        let attachmentString = NSAttributedString(attachment: attachment)
        attributedString.append(attachmentString)
        
        return attributedString
    }
}
