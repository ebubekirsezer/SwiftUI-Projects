//
//  FileManagerExtension.swift
//  Cards
//
//  Created by Ebubekir Sezer on 13.11.2021.
//

import Foundation

extension FileManager {
  static var documentURL: URL? {
    return Self.default.urls(
      for: .documentDirectory,
      in: .userDomainMask).first
  }
}
