//
//  TextField.swift
//  My Grandpa
//
//  Created by Rick Crane on 14/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import UIKit
import SpriteKit

class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.viewWithTag(999)
        self.textColor = UIColor.white
        self.backgroundColor = UIColor.black
        self.borderStyle = UITextBorderStyle.roundedRect
        self.keyboardType = UIKeyboardType.asciiCapable
        self.textAlignment = .center
        self.attributedPlaceholder = NSAttributedString(string: "Ex. Cedric", attributes: [NSForegroundColorAttributeName : UIColor.gray])
        self.autocapitalizationType = UITextAutocapitalizationType.words
        self.returnKeyType = UIReturnKeyType.done
        
        self.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
