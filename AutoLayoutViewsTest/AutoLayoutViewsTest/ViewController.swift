//
//  ViewController.swift
//  AutoLayoutViewsTest
//
//  Created by HideOnBush on 2017/5/27.
//  Copyright © 2017年 HideOnBush. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var views: [UIView]? = [UIView]()
    private var numberOfViews: Int? {
        didSet {
            scrollView.contentSize = CGSize(width: 0, height: numberOfViews! * 240 + 20)
            addViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }

    private func layoutViews() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private func addViews() {
        for index in 0..<(numberOfViews ?? 1) {
            let vview = UIView()
            vview.tag = 100 + index
            vview.backgroundColor = .orange
            //将view添加到数组中
            views?.append(vview)
            //将view添加到scrollview中
            scrollView.addSubview(vview)
        }
        
        for index in 0..<(views?.count)! {
            if index == 0 {
                let view = views?[index]
                view?.snp.makeConstraints({ (make) in
                    make.top.equalToSuperview().offset(20)
                    make.centerX.equalToSuperview()
                    make.width.height.equalTo(202)
                })
            } else if index == ((views?.count)! - 1) {
                let preView = views?[index - 1]
                let newView = views?[index]
                newView?.snp.makeConstraints({ (make) in
                    make.bottom.equalToSuperview().offset(-20)
                    make.top.equalTo((preView?.snp.bottom)!).offset(20)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(202)
                    make.height.equalTo((preView?.snp.height)!)
                })
            } else {
                let preView = views?[index - 1]
                let newView = views?[index]
                newView?.snp.makeConstraints({ (make) in
                    make.top.equalTo((preView?.snp.bottom)!).offset(20)
                    make.centerX.equalToSuperview()
                    make.height.equalTo((preView?.snp.height)!)
                    make.width.equalTo(202)
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

