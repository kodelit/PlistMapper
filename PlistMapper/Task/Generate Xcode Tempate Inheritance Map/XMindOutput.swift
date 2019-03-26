//
//  XMindOutput.swift
//  PlistMapper
//
//  Created by Grzegorz on 25/03/2019.
//  Copyright © 2019 kodelit. All rights reserved.
//

import Foundation

private struct XMindSubfileInfo {
    let fileName:String
    let subDir:String
    var content:String?
}

struct XMindOutput: OutputType {
    static let outputDirName = ""
    static let outputFileExt = XMind.fileExtension

    fileprivate static let xmindSubfiles =
        [XMindSubfileInfo(fileName: "content.xml", subDir: "", content:nil),
         XMindSubfileInfo(fileName: "manifest.xml", subDir: "META-INF", content:XMindOutput.manifestFileContent),
         XMindSubfileInfo(fileName: "styles.xml", subDir: "", content:XMindOutput.stylesFileContent)]

    func write(content:String, fileName:String) {
        let tempDir = NSTemporaryDirectory() + "PlistMapper/"
        _ = Output.reset(dir: tempDir)
        _ = Output.reset(dir: tempDir + "META-INF/")

        let fileManager = FileManager.default

        // create archive
        let currentWorkingPath = tempDir
        var archiveURL = URL(fileURLWithPath: currentWorkingPath)
        archiveURL.appendPathComponent("\(fileName).zip")
        guard let _ = Archive(url: archiveURL, accessMode: .create) else  {
            return
        }

        XMindOutput.xmindSubfiles.forEach { (info) in
            let relativeFilePath = (info.subDir as NSString).appendingPathComponent(info.fileName)
            let tempPath = (tempDir as NSString).appendingPathComponent(relativeFilePath)

            let fileContent:String = info.content ?? content

            do{
                if fileManager.fileExists(atPath: tempPath) {
                    try fileManager.removeItem(atPath: tempPath)
                }
                try fileContent.write(toFile: tempPath, atomically: true, encoding: .utf8)
            }catch{
                print("Failed to save content of file `\(fileName)`:",error)
            }

            // add entries to archive
            guard let archive = Archive(url: archiveURL, accessMode: .update) else  {
                return
            }

            let tempDirUrl = URL(fileURLWithPath: tempDir)
            do {
                try archive.addEntry(with: relativeFilePath, relativeTo: tempDirUrl)
            } catch {
                print("Adding entry to ZIP archive failed with error:\(error)")
            }
        }

        let tempResultFilePath = archiveURL.path
        let filePath = outputFilePath(for: fileName)
        do{
            if fileManager.fileExists(atPath: tempResultFilePath) {
                if fileManager.fileExists(atPath: filePath) {
                    try fileManager.removeItem(atPath: filePath)
                }

                try fileManager.moveItem(atPath: tempResultFilePath, toPath: filePath)
            }else{
                print("XMind file missing at path:",tempResultFilePath)
            }

        }catch{
            print("Failed to save content of file `\(fileName)`:",error)
        }

        // cleanup
        _ = Output.reset(dir: tempDir)
    }
}

extension XMindOutput {
    static var manifestFileContent:String {
        return """
        <?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <manifest password-hint="" xmlns="urn:xmind:xmap:xmlns:manifest:1.0">
        <file-entry full-path="content.xml" media-type="text/xml"/>
        <file-entry full-path="META-INF/" media-type=""/>
        <file-entry full-path="META-INF/manifest.xml" media-type="text/xml"/>
        <file-entry full-path="styles.xml" media-type="text/xml"/>
        </manifest>
        """
    }

    static var stylesFileContent:String {
        return """
        <?xml version="1.0" encoding="UTF-8" standalone="no"?><xmap-styles xmlns="urn:xmind:xmap:xmlns:style:2.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:svg="http://www.w3.org/2000/svg" version="2.0"><automatic-styles><style id="57dnvq4f0on9hkeildskteljtk" name="" type="topic"><topic-properties border-line-width="1pt" fo:color="#d9cc9c" fo:font-family="Roboto Slab" fo:text-decoration="normal" fo:text-transform="manual" line-class="org.xmind.branchConnection.curve" line-color="#595959" line-width="1pt" shape-class="org.xmind.topicShape.rect" svg:fill="none"/></style><style id="14kdabu9l0n7gsnqlrft6gcd7h" name="" type="boundary"><boundary-properties fo:color="#F2F2F2" fo:font-family="Raleway" fo:font-weight="bold" line-color="#999999" line-pattern="dash" line-width="1pt" shape-class="org.xmind.boundaryShape.roundedRect" svg:fill="#030303" svg:opacity=".2"/></style><style id="3dib1c5go6m02gil9siqaii340" name="" type="summary"><summary-properties line-color="#FFFFFF" shape-class="org.xmind.summaryShape.square"/></style><style id="36qlndf2na2t47i2lv33vnk5qj" name="" type="topic"><topic-properties border-line-color="#de3315" callout-shape-class="org.xmind.calloutTopicShape.balloon.rectangle" fo:color="#FFFFFF" fo:font-family="Raleway" fo:font-style="italic" fo:text-transform="manual" svg:fill="#de3315"/></style><style id="17o9l1vc7thi5o9i3m5hjr68of" name="" type="topic"><topic-properties border-line-color="#FFFFFF" border-line-width="1pt" fo:color="#d9cc9c" fo:font-family="Roboto Slab" fo:font-weight="normal" fo:text-transform="manual" line-class="org.xmind.branchConnection.elbow" line-color="#FFFFFF" line-width="1pt" shape-class="org.xmind.topicShape.roundedRect" svg:fill="#1e1e20"/></style><style id="00i80h3o9qq0825cacgtos6lcv" name="" type="topic"><topic-properties fo:color="#d9cc9c" fo:font-family="Roboto Slab" fo:text-align="center" fo:text-transform="manual" shape-class="org.xmind.topicShape.roundedRect" svg:fill="#1e1e20"/></style><style id="5seg9iib1hhrqs7mbr5uco5tnu" name="" type="topic"><topic-properties border-line-width="0pt" fo:color="#1e1e20" fo:font-family="Roboto Slab" fo:font-size="11pt" fo:font-style="normal" fo:font-weight="bold" line-class="org.xmind.branchConnection.straight" shape-class="org.xmind.topicShape.roundedRect" svg:fill="#d9cc9c"/></style><style id="1a2js7kfkrl6nn6p0sfa3rmsno" name="" type="relationship"><relationship-properties arrow-begin-class="org.xmind.arrowShape.none" arrow-end-class="org.xmind.arrowShape.triangle" fo:color="#FFFFFF" fo:font-family="Raleway" fo:font-size="10pt" fo:text-align="center" fo:text-transform="manual" line-color="#FFFFFF" line-pattern="solid" line-width="2pt" shape-class="org.xmind.relationshipShape.curved"/></style><style id="6o9c3k9kll7ca3h1v4jqjiino3" name="" type="topic"><topic-properties fo:color="#d9cc9c" fo:font-family="Roboto Slab" fo:font-weight="normal" fo:text-align="center" fo:text-transform="manual" line-class="org.xmind.branchConnection.roundedElbow" line-color="#FFFFFF" shape-class="org.xmind.topicShape.roundedRect" svg:fill="#1e1e20"/></style><style id="11367iaq09jurbs9f8tbsjmhmv" name="" type="map"><map-properties svg:fill="#1e1e20" svg:opacity="0.1"/></style></automatic-styles><master-styles><style id="43immodm6i9ppor1t7uf68ui7o" name="TK Main" type="theme"><theme-properties><default-style style-family="subTopic" style-id="57dnvq4f0on9hkeildskteljtk"/><default-style style-family="boundary" style-id="14kdabu9l0n7gsnqlrft6gcd7h"/><default-style style-family="summary" style-id="3dib1c5go6m02gil9siqaii340"/><default-style style-family="calloutTopic" style-id="36qlndf2na2t47i2lv33vnk5qj"/><default-style style-family="centralTopic" style-id="17o9l1vc7thi5o9i3m5hjr68of"/><default-style style-family="mainTopic" style-id="00i80h3o9qq0825cacgtos6lcv"/><default-style style-family="summaryTopic" style-id="5seg9iib1hhrqs7mbr5uco5tnu"/><default-style style-family="relationship" style-id="1a2js7kfkrl6nn6p0sfa3rmsno"/><default-style style-family="floatingTopic" style-id="6o9c3k9kll7ca3h1v4jqjiino3"/><default-style style-family="map" style-id="11367iaq09jurbs9f8tbsjmhmv"/></theme-properties></style></master-styles></xmap-styles>
        """
    }
}
