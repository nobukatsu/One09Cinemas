//
//  Theater.swift
//  One09CinemasViewer
//
//  Created by nobukatsu on 2015/10/26.
//  Copyright © 2015年 nobukatsu.jp. All rights reserved.
//

import UIKit
import Kanna

/**
 * 劇場
 */
public class Theater: NSObject {

    /** 劇場ID */
    var id: String
    /** 劇場名 */
    var name: String
    /** 劇場名(短縮) */
    var shortName: String
    /** 劇場URL */
    var url: String
    /** 公開中の映画 */
    var nowShowing: [Movie]?
    /** 公開予定の映画 */
    var comingSoon: [Movie]?

    init(id:String, name:String, shortName:String, url:String) {

        self.id = id
        self.name = name
        self.shortName = shortName
        self.url = url

        super.init()

        nowShowing = self.getNowShowing()
    }

    private func getNowShowing() -> [Movie] {
        var movies: [Movie] = []

        let data = NSData(contentsOfURL: NSURL(string: Const.nowShowingUrl)!)
        let doc = HTML(html: data!, encoding: NSUTF8StringEncoding)

        let contents = doc?.body?.css("section#contents article")

        for content in contents! {
            let title: String = content.css("div.main header h1").text!
            let thumbUrl: String = "http://109cinemas.net" + ((content.css("div.main div.thumb div.img img").first)?["src"])!
            let detailUrl: String = "http://109cinemas.net" + ((content.css("div.main a").first)?["href"])!

            let movie:Movie = Movie(title:title , thumbUrl: thumbUrl, detailUrl: detailUrl)

            var showFlag:Bool = true

            // 上映しない映画は除外
            let notShowingTheaters = content.css("div.side ul li.hidden")
            for notshowingTheater in notShowingTheaters {
                if notshowingTheater.text == self.shortName {
                    showFlag = false
                }
            }
            if showFlag {
                movies.append(movie)
            }
        }

        return movies
    }

}
