var self;
fixMethod('ViewController','addView',1,function(instance,invocation,arg){

//          var color = runMethod('UIColor','greenColor');
//          var view = runInstanceMethod(instance,'view');
//          var label = runMethod('UILabel','new');
//          runInstanceMethod(label,'setFrame:',new Array('{{100, 100}, {100, 100}}'));
//          runInstanceMethod(label,'setText:','更新后');
//          runInstanceMethod(view,'addSubview:',label);
//          runInstanceMethod(label,'setBackgroundColor:',new Array(color));
          
//          var view = runInstanceMethod(instance,'view');
//          var v = runMethod('UIView','new');
//          var color = runMethod('UIColor','greenColor');
//          runInstanceMethod(v,'setBackgroundColor:',color);
//          runInstanceMethod(v,'setFrame:',new Array('{{100, 100}, {50, 50}}'));
//          runInstanceMethod(view,'addSubview:',v);
          
          var view = runInstanceMethod(instance,'view');
          var v = runMethod('YCButton','new');
          // 数组
          var array = new Array('list','att');
          runInstanceMethod(v,'testArr:',new Array(array));
          // 字典
          var dict = {"key":"111","value":"222"};
          runInstanceMethod(v,'testDict:',new Array(dict));
          
          runInstanceMethod(v,'testSelect:',new Array('selectClick:'));
          
          var color = runMethod('UIColor','greenColor');
          runInstanceMethod(v,'setBackgroundColor:',color);
          runInstanceMethod(v,'setTitle:forState:',new Array('文字', 0));
          runInstanceMethod(v,'setFrame:',new Array('{{100, 100}, {50, 50}}'));
          // SEL
          runInstanceMethod(v,'addTarget:action:forControlEvents:', new Array(instance,'showLoading',64))
          runInstanceMethod(view,'addSubview:',v);
          
          
          });


//fixMethod('ViewController','showLoading',2,function(instance,invocation,arg){
//          runMethod('MBProgressHUD','dd_showLoading');
//          var color = runMethod('UIColor','blueColor');
//          var red = runMethod('UIColor','redColor');
//          var view = runInstanceMethod(instance,'view');
//          var sw = runInstanceMethod(instance,'sw');
//          runInstanceMethod(view,'setBackgroundColor:',color);
//          runInstanceMethod(sw,'setOnTintColor:',red);
//          });
