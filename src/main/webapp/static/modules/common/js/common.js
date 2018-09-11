/*!
 * Copyright &copy; 2012-2016 <a href="https://github.com/htiiot.admin">XFrame</a> All rights reserved.
 * 
 * 通用公共方法
 * @author XCD
 * @version 2014-4-29
 */



function successMsg(msg){

    //if(typeof(app) != "undefined")
        //app.$Message.success(msg);
        window.top.app.$Message.success(msg);
    //else
    //    window.top.toastr.success("", msg);
}

function errorMsg(msg){
   // if(typeof(app) != "undefined")
        window.top.app.$Message.error(msg);
   // else
   //     window.top.toastr.error("", msg);
}

/**
 * 通用GET方法
 * @param url 接口地址
 * @param successCallback 成功回调函数（可选）
 * @param errorCallback 失败回调函数（可选）
 * @param showMsg 是否显示返回消息（可选）
 * @return promise
 */
function ajaxGet(url, successCallback,errorCallback,showMsg, showLoading) {
    if(showMsg!==true){
        showMsg=false;
    }
    var index = 0;


    if(showLoading !== false){
        index =layer.load();
    }

    //headers['CSRFToken']=$("#csrftoken").val();
    $.ajax({
        type : 'get',
        url : url,
        cache: false,
        //dataType : 'json',
        success : function(d, status) {

            layer.close(index);

            if(typeof d == "string" && d.indexOf('login-body') != -1) {
                window.location.href= "/login";
                return;
            }

            //有返回消息
            if (showMsg && d.message && d.message != "") {
                if (d.code == 'success') {

                    successMsg(d.message);
                    //window.top.layer.msg(d.message, { offset: '100px' });
                    //window.top.toastr.success("", d.message);
                    //toastr.pop('success', "", d.message, 2000);
                } else {

                    errorMsg(d.message);
                    //window.top.layer.msg(d.message, { offset: '100px' });
                    //window.top.toastr.error("", d.message);
                    //toaster.pop('error', "", d.message, 2000);

                }
            }


            if (typeof (successCallback) == 'function') successCallback(d,status);

        },
        error : function(e, err1, err2) {

            layer.close(index);

            //webapi调用失败
            if (e && typeof (e) != 'object' && e != "") {

                errorMsg(e);
                //window.top.toastr.error("", e);
            }
            else if(e && e.responseText){
                errorMsg(e.responseText);
                //window.top.toastr.error("", e.responseText);
            }

            if (typeof (errorCallback) == 'function') errorCallback(e);

        }
    });

}


/**
 * 通用POST方法
 * @param url 接口地址
 * @param data 参数请求体
 * @param successCallback 成功回调函数（可选）
 * @param errorCallback 失败回调函数（可选）
 * @param showMsg 是否显示返回消息（可选）
 * @return promise
 */

function ajaxPost(url, data, successCallback,errorCallback,showMsg,showLoading) {
    if(showMsg!==true){
        showMsg=false;
    }
    var index = 0;


    if(showLoading !== false){
        index =layer.load();
    }

    // var headers={};
    // headers['CSRFToken']=$("#csrftoken").val();

    $.ajax({
        type : 'post',
        url : url,
        cache: false,
        data : data,
        //data: JSON.stringify(data),//将对象序列化成JSON字符串
        //dataType:"json",
        //contentType : 'application/json;charset=utf-8', //设置请求头信息

        //dataType : 'json',
        //headers:headers,
        success : function(d, status) {

            layer.close(index);
            if(typeof d == "string" && d.indexOf('login-body') != -1) {
                window.location.href= "/login";
                return;
            }

            //有返回消息
            if (showMsg && d.message && d.message != "") {
                if (d.code == 'success') {

                    successMsg(d.message);
                    //window.top.layer.msg(d.message, { offset: '100px' });
                    //window.top.toastr.success("", d.message);
                    //toaster.pop('success', "", d.message, 2000);
                } else {

                    errorMsg(d.message);
                    //window.top.layer.msg(d.message, { offset: '100px' });
                    //window.top.toastr.error("", d.message);
                    //toaster.pop('error', "", d.message, 2000);

                }
            }

            if (typeof (successCallback) == 'function') successCallback(d);

        },
        error : function(e, err1, err2) {

            layer.close(index);

            //webapi调用失败
           if (e && typeof (e) != 'object' && e != "") {
               errorMsg(e);
               //window.top.toastr.error("", e);
            }
            else if(e && e.responseText){

               errorMsg(e.responseText);
               //window.top.toastr.error("", e.responseText);
            }

            if (typeof (errorCallback) == 'function') errorCallback(e);

        }
    });

}



/**
 * 通用POST方法
 * @param url 接口地址
 * @param data 参数请求体
 * @param successCallback 成功回调函数（可选）
 * @param errorCallback 失败回调函数（可选）
 * @param showMsg 是否显示返回消息（可选）
 * @return promise
 */

function ajaxPostJSON(url, data, successCallback,errorCallback,showMsg,showLoading) {
    if(showMsg!==true){
        showMsg=false;
    }
    // var headers={};
    // headers['CSRFToken']=$("#csrftoken").val();
    var index = 0;


    if(showLoading !== false){
        index =layer.load();
    }

    $.ajax({
        type : 'post',
        url : url,
        cache: false,
        //data : data,
        data: JSON.stringify(data),//将对象序列化成JSON字符串
        dataType:"json",
        contentType : 'application/json;charset=utf-8', //设置请求头信息


        //headers:headers,
        success : function(d, status) {

            layer.close(index);
            if(typeof d == "string" && d.indexOf('login-body') != -1) {
                window.location.href= "/login";
                return;
            }

            //有返回消息
            if (showMsg && d.message && d.message != "") {
                if (d.code == 'success') {

                    successMsg(d.message);

                    //window.top.layer.msg(d.message, { offset: '100px' });
                    //window.top.toastr.success("", d.message);
                    //toaster.pop('success', "", d.message, 2000);
                } else {

                    errorMsg(d.message);

                    //window.top.layer.msg(d.message, { offset: '100px' });
                    //window.top.toastr.error("", d.message);
                    //toaster.pop('error', "", d.message, 2000);

                }
            }

            if (typeof (successCallback) == 'function') successCallback(d);

        },
        error : function(e, err1, err2) {

            layer.close(index);

            //webapi调用失败
            if (e && typeof (e) != 'object' && e != "") {
                errorMsg(e);
                //window.top.toastr.error("", e);
            }
            else if(e && e.responseText){
                errorMsg(e.responseText);
                //window.top.toastr.error("", e.responseText);
            }

            if (typeof (errorCallback) == 'function') errorCallback(e);

        }
    });

}



// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
// 例子：
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}




/**
 * json格式转树状结构
 * @param   {json}      json数据
 * @param   {String}    id的字符串
 * @param   {String}    父id的字符串
 * @param   {String}    children的字符串
 * @return  {Array}     数组
 */
function toTreeData(a, idStr, pidStr, childrenStr) {
    var r = [], hash = {},len = (a||[]).length;
    for (var i=0; i < len; i++) {
        hash[a[i][idStr]] = a[i];

    }
    for (var j=0; j < len; j++) {
        var aVal = a[j], hashVP = hash[aVal[pidStr]];
        if (!aVal[childrenStr])
            aVal[childrenStr] = [];
        if (hashVP) {
            if (!hashVP[childrenStr]) hashVP[childrenStr] = [];
            //!hashVP[childrenStr] && (hashVP[childrenStr] = []);
            hashVP[childrenStr].push(aVal);
        } else {
            r.push(aVal);
        }
    }
    return r;
};




// 引入js和css文件
function include(id, path, file){
	if (document.getElementById(id)==null){
        var files = typeof file == "string" ? [file] : file;
        for (var i = 0; i < files.length; i++){
            var name = files[i].replace(/^\s|\s$/g, "");
            var att = name.split('.');
            var ext = att[att.length - 1].toLowerCase();
            var isCSS = ext == "css";
            var tag = isCSS ? "link" : "script";
            var attr = isCSS ? " type='text/css' rel='stylesheet' " : " type='text/javascript' ";
            var link = (isCSS ? "href" : "src") + "='" + path + name + "'";
            document.write("<" + tag + (i==0?" id="+id:"") + attr + link + "></" + tag + ">");
        }
	}
}


// 获取URL地址参数
function getQueryString(name, url) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    if (!url || url == ""){
        url = window.location.search;
    }else{
        url = url.substring(url.indexOf("?"));
    }
    r = url.substr(1).match(reg)
    if (r != null) return unescape(r[2]); return null;
}

//获取字典标签
function getDictLabel(data, value, defaultValue){
    for (var i=0; i<data.length; i++){
        var row = data[i];
        if (row.value == value){
            return row.label;
        }
    }
    return defaultValue;
}



// 打开一个窗体
function windowOpen(url, name, width, height){
	var top=parseInt((window.screen.height-height)/2,10),left=parseInt((window.screen.width-width)/2,10),
		options="location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,"+
		"resizable=yes,scrollbars=yes,"+"width="+width+",height="+height+",top="+top+",left="+left;
	window.open(url ,name , options);
}

// 警告对话框
function alertx(mess, closed){
	top.$.jBox.info(mess, '提示', {closed:function(){
		if (typeof closed == 'function') {
			closed();
		}
	}});
	top.$('.jbox-body .jbox-icon').css('top','55px');
}

// 确认对话框
function confirmx(mess, href, closed){
	top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
		if(v=='ok'){
			if (typeof href == 'function') {
				href();
			}else{
				resetTip(); //loading();
				location = href;
			}
		}
	},{buttonsFocus:1, closed:function(){
		if (typeof closed == 'function') {
			closed();
		}
	}});
	top.$('.jbox-body .jbox-icon').css('top','55px');
	return false;
}

// 提示输入对话框
function promptx(title, lable, href, closed){
	top.$.jBox("<div class='form-search' style='padding:20px;text-align:center;'>" + lable + "：<input type='text' id='txt' name='txt'/></div>", {
			title: title, submit: function (v, h, f){
	    if (f.txt == '') {
	        top.$.jBox.tip("请输入" + lable + "。", 'error');
	        return false;
	    }
		if (typeof href == 'function') {
			href();
		}else{
			resetTip(); //loading();
			location = href + encodeURIComponent(f.txt);
		}
	},closed:function(){
		if (typeof closed == 'function') {
			closed();
		}
	}});
	return false;
}


// cookie操作
function cookie(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
}

// 数值前补零
function pad(num, n) {
    var len = num.toString().length;
    while(len < n) {
        num = "0" + num;
        len++;
    }
    return num;
}

// 转换为日期
function strToDate(date){
	return new Date(date.replace(/-/g,"/"));
}

// 日期加减
function addDate(date, dadd){  
	date = date.valueOf();
	date = date + dadd * 24 * 60 * 60 * 1000;
	return new Date(date);  
}

//截取字符串，区别汉字和英文
function abbr(name, maxLength){  
 if(!maxLength){  
     maxLength = 20;  
 }  
 if(name==null||name.length<1){  
     return "";  
 }  
 var w = 0;//字符串长度，一个汉字长度为2   
 var s = 0;//汉字个数   
 var p = false;//判断字符串当前循环的前一个字符是否为汉字   
 var b = false;//判断字符串当前循环的字符是否为汉字   
 var nameSub;  
 for (var i=0; i<name.length; i++) {  
    if(i>1 && b==false){  
         p = false;  
    }  
    if(i>1 && b==true){  
         p = true;  
    }  
    var c = name.charCodeAt(i);  
    //单字节加1   
    if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {  
         w++;  
         b = false;  
    }else {  
         w+=2;  
         s++;  
         b = true;  
    }  
    if(w>maxLength && i<=name.length-1){  
         if(b==true && p==true){  
             nameSub = name.substring(0,i-2)+"...";  
         }  
         if(b==false && p==false){  
             nameSub = name.substring(0,i-3)+"...";  
         }  
         if(b==true && p==false){  
             nameSub = name.substring(0,i-2)+"...";  
         }  
         if(p==true){  
             nameSub = name.substring(0,i-2)+"...";  
         }  
         break;  
    }  
 }  
 if(w<=maxLength){  
     return name;  
 }  
 return nameSub;  
}

// 判断是否为正整数
function isPositiveNum(s){
    var re = /^[0-9]*[1-9][0-9]*$/;
    return re.test(s);
}