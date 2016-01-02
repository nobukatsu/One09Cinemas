//
//  Movie.swift
//  One09CinemasViewer
//
//  Created by nobukatsu on 2015/10/26.
//  Copyright © 2015年 nobukatsu.jp. All rights reserved.
//

import UIKit
import Kanna

public class Movie: NSObject {

    var title: String = ""
    var thumbUrl: String = ""
    var detailUrl: String

    var imageUrl: String = ""
    var story: String = ""

    init(title: String, thumbUrl: String, detailUrl: String) {
        self.title = title
        self.thumbUrl = thumbUrl
        self.detailUrl = detailUrl
    }

    init(detailUrl: String) {
        self.detailUrl = detailUrl
        super.init()

        self.setupDetail()
    }

    private func setupDetail() {
        let data = NSData(contentsOfURL: NSURL(string: detailUrl)!)
        let doc = HTML(html: data!, encoding: NSUTF8StringEncoding)

        self.title = (doc?.body?.css("section#contents header#title h1").text!)!
        self.imageUrl = "http://109cinemas.net" + (doc?.body?.css("section#contents div#movie div#video img").first!["src"])!
        self.story = (doc?.body?.css("section#contents div#movie section#story p").text!)!
    }

    /**
     *
     */
    public func getScheduleList(theaterId: String) -> [Schedule]? {
        return nil
    }

}
