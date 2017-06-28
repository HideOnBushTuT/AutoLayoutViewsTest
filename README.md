
# iOS 小知识-使用AutoLayout循环创建控件

# 前言

​	之前在项目中布局一直使用的AutoLayout，但是在碰到轮播图这种需要循环创建控件并且设置每个控件的布局的时候，就偷懒直接使用`frame`来做。直到最近一次面试，面试官问道我这个问题的时候，我就懵逼了。所以在面试的时候当场想了想，给出了一种答案，但是自己对于这种方案很没有底。面试完后，回来自己试了一试。以下就是我的做法。（个人感觉做法很丑陋，不知各位大佬有何高见，小弟虚心请教）

## 正文

* 首先设置一个全局的数组来存放循环创建的控件。作用是：为了之后在方便设置布局。

  ```swift
  var views: [UIView]? = [UIView]()
  ```

* 其次，通过for循环，循环创建控件并且将其添加到之前创建了数组中和父视图中，这里我将`view`添加到`scrollView`中来展示。

  ```swift
  for index in 0..<(numberOfViews ?? 1) {
      let vview = UIView()
  	vview.tag = 100 + index
  	vview.backgroundColor = .orange
  	//将view添加到数组中
  	views?.append(vview)
  	//将view添加到scrollview中
  	scrollview.addSubview(vview)       
  }
  ```

* 最后，通过for循环设置每个view的布局。需要分辨的是第一个视图、中间的视图和最后一个视图（笔者使用SnapKit库来编写）

  * 第一个视图只需要和父控件有约束就可以了。
  * 中间的视图需要和前一个视图有约束。
  * 最后的视图不仅和之前的视图有约束而且还和父视图有约束。

  ```swift
  for index in 0..<(view?.count)! {
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
          let preview = views?[index - 1]
          let newview = views?[index]
          newView?.snp.makeConstraints({ (make) in                 	     
          make.top.equalTo((preView?.snp.bottom)!).offset(20)
          make.centerX.equalToSuperview()
          make.height.equalTo((preView?.snp.height)!)
          make.width.equalTo(202)
       })
    }
  }
  ```

* 大功告成，不过这种方式真的丑陋，等有好的方法在来更新吧。如有不对希望指出。希望大家有好的想法可以分享一下。谢谢。
