//
//  FileManagerHelper.swift
//  TestPhamNgocDuong
//
//  Created by Kai Pham on 8/31/18.
//  Copyright © 2018 Kai Pham. All rights reserved.
//


import Foundation

let countryCodeJsonPath = FileManagerHelper.getDocumentsDirectory().appendingPathComponent("countryCodes.json")

class FileManagerHelper {
    static func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return path
    }
    
    static func sizeForLocalFilePath(filePath: String) -> UInt64 {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            if let fileSize = fileAttributes[FileAttributeKey.size]  {
                return (fileSize as! NSNumber).uint64Value
            } else {
                print("Failed to get a size attribute from path: \(filePath)")
            }
        } catch {
            print("Failed to get file attributes for local path: \(filePath) with error: \(error)")
        }
        return 0
    }
    
    static func createFile() {
        do {
            if !FileManager.default.fileExists(atPath: countryCodeJsonPath.absoluteString) {
                print(countryCodeJsonPath.path)
                try FileManager.default.createFile(atPath: countryCodeJsonPath.path, contents: nil, attributes: nil)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func writeFile(text: String) {
        guard let textBase64 = text.toBase64() else { return }
        
        do {
            try textBase64.write(to: countryCodeJsonPath, atomically: false, encoding: String.Encoding.utf8)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func readFile() -> String? {
        do {
            let text = try String(contentsOf: countryCodeJsonPath, encoding: String.Encoding.utf8)
            return text.fromBase64()
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

