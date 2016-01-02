//
//  NowShowingViewController.swift
//  One09Cinemas
//
//  Created by nobukatsu on 2015/10/29.
//  Copyright © 2015年 nobukatsu. All rights reserved.
//

import UIKit
import Kanna
import SDWebImage

class NowShowingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var nowShowingTableView: UITableView!
    
    let TableViewCellIdentifier:String = "movieCell"
    let showMovieInfoSegueIdentifier: String = "showMovieInfoSegue"

    var theater: Theater?

    var refresh: UIRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: 設定から取得
        theater = Theater(id: "kawasaki", name: "109シネマズ川崎", shortName: "川崎", url: "http://109cinemas.net/kawasaki/")

        self.navigationItem.title = (theater?.shortName)! + "で上映中の映画"

        // TODO: 動作がちょっとおかしい
//        refresh.addTarget(self, action: "pullToRefresh", forControlEvents: UIControlEvents.ValueChanged)
//        nowShowingTableView.addSubview(refresh)
    }

    func pullToRefresh(){
        // TODO: 更新
        nowShowingTableView.reloadData()
        refresh.endRefreshing()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        nowShowingTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theater!.nowShowing!.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifier, forIndexPath: indexPath)

        let titleLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let image: UIImageView = cell.viewWithTag(2) as! UIImageView

        titleLabel.text = theater!.nowShowing![indexPath.row].title
        image.sd_setImageWithURL(NSURL(string: theater!.nowShowing![indexPath.row].thumbUrl))

        return cell
    }

    /**
     * 画面遷移時の処理
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == showMovieInfoSegueIdentifier {
            if let destination = segue.destinationViewController as? MovieInfoViewController {
                let path = self.nowShowingTableView.indexPathForSelectedRow?.row
                destination.movieDetailUrl = (theater?.nowShowing![path!].detailUrl)!
            }
        }
    }

}
