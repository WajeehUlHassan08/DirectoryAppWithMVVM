//
//  Localization.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 12/10/2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "GermanLocalizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
