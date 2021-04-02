//
//  CustomDropDownView.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 02/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class CustomDropDownView: CustomDesignableView {
    
    private var dropDown: DropDown!
    private var selectedLabel: UILabel? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initDropdown()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDropdown()
    }
    
    private func initDropdown() {
        dropDown = DropDown()
        dropDown.anchorView = self
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedLabel?.text = item
        }
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:))))
        styleDropDown()
    }
    
    private func styleDropDown() {
        DropDown.appearance().textColor = UIColor(named: "darkBlueTextColor")!
        DropDown.appearance().selectedTextColor = UIColor(named: "aviBlue")!
        DropDown.appearance().textFont = UIFont(name: "Quicksand-SemiBold", size: CGFloat(17))!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.white
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        dropDown.show()
    }
    
    func setLabelView(label labelView: UILabel) {
        selectedLabel = labelView
    }
    
    func setDropDownData(_ options: [String]) {
        dropDown.dataSource = options
    }
    
    func getSelectedItem() -> String? {
        dropDown.selectedItem
    }
    
}
