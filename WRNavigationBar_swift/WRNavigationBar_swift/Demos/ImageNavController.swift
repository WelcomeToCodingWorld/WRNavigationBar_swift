//
//  ImageNavController .swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit

private let IMAGE_HEIGHT:CGFloat = 220
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom * 2)

class ImageNavController: UIViewController
{    
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var topView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image7"))
        imgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: IMAGE_HEIGHT)
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "玛丽莲·梦露"
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        tableView.tableHeaderView = topView
        
        // 设置导航栏显示图片
        navBarBackgroundImage = UIImage(named: "imageNav")
        
        // 设置初始导航栏透明度
        navBarBackgroundAlpha = 0
        
        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white
        
        // 设置状态栏style
        statusBarStyle = .lightContent
    }
    
    deinit {
        tableView.delegate = nil
        print("FirstVC deinit")
    }
}


// MARK: - 滑动改变导航栏透明度、标题颜色、左右按钮颜色、状态栏颜色
extension ImageNavController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
        }
        else
        {
            navBarBackgroundAlpha = 0
        }
    }
}


extension ImageNavController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:UIViewController = UIViewController()
        vc.view.backgroundColor = UIColor.white
        let str = "WRNavigationBar"
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}
