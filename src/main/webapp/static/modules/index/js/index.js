/**
 * Created by xcd on 2017/4/15.
 */
var settings = {
    homeTabTitle: "首页",
    homeTabUrl: "/admin/sys/user/info",
    homtTabIcon: "glyphicon glyphicon-home",
}


function iFrameHeight(obj) {
    if (obj) {
        //obj.style.height = obj.parentNode.offsetHeight+"px";
        ;
        //obj.style.height = "99%";
    }
}


function openHomeTab() {
    var url = settings.homeTabUrl;
    var icon = settings.homtTabIcon;
    var subtitle = settings.homeTabTitle;

    if (!url || url == '#') return false;
    var $tab = $('#maintabs');
    var tabCount = $tab.tabs('tabs').length;
    var hasTab = $tab.tabs('exists', subtitle);

    if (!hasTab) {
        $tab.tabs('add', { title: subtitle, content: createFrame(url), closable: true });
    }

}


//设置页面链接
function setLocationHash() {

    var fnSrc = function (tab) {
        var iframe = tab.find('iframe');
        return iframe.length ? iframe[0].src.replace(location.host, '').replace('http://', '').replace('.jsp', '') : '';
    };

    try {

        var tab = $('.tab-content').find('.active');

        if (tab) {
            src = fnSrc(tab);
            if (src) window.location.hash = '!' + src;   //如果src没有，就不设置，case在f5刷新时出现
            if (src == homeUrl) window.location.hash = '';
        }
        else {
            src = fnSrc(tabs[tabs.length - 1]); //关闭tabs时，当前tab为空
            window.location.hash = '!' + src;
        }
        return;




        var $obj = $('#maintabs');
        var src = '', tabs = $obj.data().tabs.tabs;
        var tab = $obj.tabs('getSelected');

        if (tab) {
            src = fnSrc(tab);
            if (src) window.location.hash = '!' + src;   //如果src没有，就不设置，case在f5刷新时出现
            if (src == homeUrl) window.location.hash = '';
        }
        else {
            src = fnSrc(tabs[tabs.length - 1]); //关闭tabs时，当前tab为空
            window.location.hash = '!' + src;
        }
    }
    catch (e) { }
}


//获取tab页标题
function getTabTitles($tab) {
    var titles = [];
    var tabs = $tab.tabs('tabs');
    $.each(tabs, function () { titles.push($(this).panel('options').title); });
    return titles;
};



//选择tab页面事件
function openTabHandler($tab, hasTab,subtitle,url) {
    if (!hasTab) {
        $tab.tabs('add', { title: subtitle, content: createFrame(url), closable: true});
    } else {
        $tab.tabs('select', subtitle);
        tabRefresh(url);   //选择TAB时刷新页面
    }


    setLocationHash();
};


//添加新tab
function addTab(subtitle,url) {
    if (!url || url == '#') return false;

    addTabs(({ id: subtitle, title: subtitle, close: true, url: url }));
    setLocationHash();
    return;

    var $tab = $('#maintabs');
    var tabCount = $tab.tabs('tabs').length;
    var hasTab = $tab.tabs('exists', subtitle);

    openTabHandler($tab, hasTab, subtitle, url);

};


//刷新tab页面
function tabRefresh(url) {
    var $tab = $("#maintabs");
    var currentTab = $tab.tabs('getSelected');
    var src = $(currentTab.panel('options').content).attr('src');
    if (typeof src === 'string') src = url;
    $tab.tabs('update', { tab: currentTab, options: { content: createFrame(src) } })
};


function createFrame(url) {

    return '<iframe  width="100%" height="100%" class="tab_iframe" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" src="' + url + '" ></iframe>';
}

//菜单点击
function rightMenuClick(item) {
    var $tab = $('#maintabs');
    var currentTab = $tab.tabs('getSelected');
    var titles = getTabTitles($tab);

    switch (item.id) {
        case "refresh":
            var src = $(currentTab.panel('options').content).attr('src');
            $tab.tabs('update', { tab: currentTab, options: { content: createFrame(src) } });
            break;
        case "close":
            var currtab_title = currentTab.panel('options').title;
            $tab.tabs('close', currtab_title);
            break;
        case "closeall":
            $.each(titles, function () {
                if (this != settings.homeTabTitle)
                    $tab.tabs('close', this);
            });
            break;
        case "closeother":
            var currtab_title = currentTab.panel('options').title;
            $.each(titles, function () {
                if (this != currtab_title && this != settings.homeTabTitle)
                    $tab.tabs('close', this);
            });
            break;
        case "closeright":
            var tabIndex = $tab.tabs('getTabIndex', currentTab);
            if (tabIndex == titles.length - 1) {
                alert('亲，后边没有啦 ^@@^!!');
                return false;
            }
            $.each(titles, function (i) {
                if (i > tabIndex && this != settings.homeTabTitle)
                    $tab.tabs('close', this);
            });

            break;
        case "closeleft":
            var tabIndex = $tab.tabs('getTabIndex', currentTab);
            if (tabIndex == 1) {
                alert('亲，前边那个上头有人，咱惹不起哦。 ^@@^!!');
                return false;
            }
            $.each(titles, function (i) {
                if (i < tabIndex && this != settings.homeTabTitle)
                    $tab.tabs('close', this);
            });
            break;
        case "exit":
            $('#closeMenu').menu('hide');
            break;
    }

};


//右击事件
function tabContextMenu(e, title) {
    //alert("右键点击" + e.pageX + ";" + e.pageY);
    $('#tabMenu').menu('show', { left: e.pageX, top: e.pageY });
    $('#maintabs').tabs('select', title);
    e.preventDefault();
};


function initLocationHash(data) {
    var subUrl = location.hash.replace('#!', '');
    $.each(data, function () {
        if (!this.funcUrl)
            return;
        var s = this.funcUrl.replace('.jsp', '');
        if (this.funcUrl && this.funcUrl != '#' && (subUrl == s || subUrl.indexOf(s) > -1))
        {
            addTab(this.funcName, this.funcUrl);
        }
        //$scope.setTab(subUrl);

    });
};