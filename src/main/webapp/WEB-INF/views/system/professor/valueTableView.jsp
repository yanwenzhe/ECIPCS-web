<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/11
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/7
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>
    <%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>


    <title>矩阵表</title>
    <style>
        .centerContent{
            margin-top: 8px;
            margin-left:8px;
            margin-right: 8px;
            background-color:#B3C0D1;
            overflow: auto;
        }
        .backGroundWidth{
            width: 100%;
            overflow: auto;
        }

    </style>
</head>
<body>

<div id="app" >
    <div class="layout">
        <Layout>
            <i-header theme="theme2"  >
                <image src="/static/image/Fate.png" style="width: 80px;height: 40px;float: left;margin-top: 15px;"></image>
                <p style="font-size: 30px;font-family: STXinwei;margin-top: 2px;color:navajowhite;float: left;">工程认证指标点计算系统</p>

                <div style="float: right;margin-top: 2px; color:navajowhite">
                    欢迎您！${username}&nbsp;&nbsp;
                    <i-button size="small" type="info"><a href="/system/login/returnLogin">退出</a></i-button>
                </div>
            </i-header>
            <Layout>
                <Sider hide-trigger :style="{background:'#CCCCFF'}">
                    <i-menu active-name="2-3" theme="blue" width="auto" :open-names="['2']" :style="{background:'#CCCCFF'}">
                        <Submenu name="1">
                            <template slot="title">
                                <Icon type="ios-navigate"></Icon>
                                管理
                            </template>
                            <menu-item name="1-1"><a href="/system/professor/manageIndexPoint">指标点管理</a></menu-item>
                            <menu-item  name="1-2"><a href="/system/professor/manageCourse">课程管理</a></menu-item>
                        </Submenu>
                        <Submenu name="2">
                            <template slot="title">
                                <Icon type="ios-navigate"></Icon>
                                达成度计算
                            </template>
                            <menu-item name="2-1"><a href="/system/professor/valueCalculated">毕业达成度计算</a></menu-item>
                            <menu-item  name="2-2"><a href="/system/professor/valueChart">毕业达成度图形化</a></menu-item>
                            <menu-item  name="2-3"><a href="/system/professor/valueTable">支撑系数矩阵</a></menu-item>
                        </Submenu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>达成度计算</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>支撑系数矩阵</breacrum-item>

                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>

                        <div class="centerContent">
                            <div class="backGroundWidth">
                                <div style="margin-top: 12px;margin-bottom: 12px">

                                    <i-select  v-model="years"
                                               style="float:right;width:150px;margin-right: 30px;"
                                    >
                                        <i-option v-for="item in yearsList " :value="item.id" :key="item.label">
                                            {{item.label}}
                                        </i-option>
                                    </i-select>
                                    <p style="margin-right:5px;float: right; font-size:15px;margin-top: 4px">请选择年限</p>
                                    <br>
                                </div>
                            </div>
                        </div>
                        <br>

                        <div class="centerContent">
                            <div class="backgroundWidth" >

                                <div style="margin-top: 20px;margin-bottom: 12px;margin-left:30px;margin-right: 30px">
                                    <table class="table  table-bordered table-hover " >
                                        <tbody>
                                        <tr><td></td>
                                            <td colspan="4">毕业要求 1</td><td colspan="5">毕业要求 2</td><td colspan="4">毕业要求 3</td>
                                            <td colspan="4">毕业要求 4</td><td colspan="5">毕业要求 5</td><td colspan="4">毕业要求 6</td>
                                            <td colspan="3">毕业要求 7</td><td colspan="3">毕业要求 8</td><td colspan="3">毕业要求 9</td>
                                            <td colspan="3">毕业要求 10</td><td colspan="4">毕业要求 11</td><td colspan="3">毕业要求 12</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>1.1</td><td>1.2</td><td>1.3</td><td>1.4</td>
                                            <td>2.1</td><td>2.2</td><td>2.3</td><td>2.4</td><td>2.5</td>
                                            <td>3.1</td><td>3.2</td><td>3.3</td><td>3.4</td>
                                            <td>4.1</td><td>4.2</td><td>4.3</td><td>4.4</td>
                                            <td>5.1</td><td>5.2</td><td>5.3</td><td>5.4</td><td>5.5</td>
                                            <td>6.1</td><td>6.2</td><td>6.3</td><td>6.4</td>
                                            <td>7.1</td><td>7.2</td><td>7.3</td>
                                            <td>8.1</td><td>8.2</td><td>8.3</td>
                                            <td>9.1</td><td>9.2</td><td>9.3</td>
                                            <td>10.1</td><td>10.2</td><td>10.3</td>
                                            <td>11.1</td><td>11.2</td><td>11.3</td><td>11.4</td>
                                            <td>12.1</td><td>12.2</td><td>12.3</td>
                                        </tr>
                                        <tr>
                                            <td>马克思主义基本原理</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.4</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td>0.2</td>
                                        </tr>
                                        <tr>
                                            <td>大学生心理素质发展</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td>0.4</td><td>0.4</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>中国近代史纲要</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.3</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.2</td>
                                        </tr>
                                        <tr>
                                            <td>思想道德修养与法律基础</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.6</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>毛泽东思想与中国特色社会主义理论体系概论</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.3</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>军事理论</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td>0.4</td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>军事训练</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td>0.5</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>体育（I-IV）</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td>0.5</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>知识产权法基础</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td>0.5</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>人文社会实践</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td>0.6</td><td> </td>
                                            <td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.5</td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>德育答辩</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.5</td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>专项英语</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.2</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>大学英语（I，II）</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.4</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>大学英语视听说（I，II）</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.4</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>工科数学分析（I，II）</td>
                                            <td>0.4</td><td>0.4</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>线性代数A</td>
                                            <td>0.3</td><td>0.3</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>概率与数理统计</td>
                                            <td>0.3</td><td>0.3</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>大学物理（I，II）</td>
                                            <td> </td><td> </td><td>0.5</td><td> </td>
                                            <td>0.6</td><td> </td><td> </td><td>0.5</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>物理实验B（I，II）</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.6</td><td> </td><td> </td><td>0.4</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>数字电子技术基础B</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.4</td><td> </td><td> </td><td>0.5</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>数字电子技术实验B</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.4</td><td> </td><td> </td><td>0.4</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>计算机科学导论</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>软件工程专业导论</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.3</td><td>0.2</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>程序设计基础（C语言）</td>
                                            <td> </td><td> </td><td> </td><td>0.2</td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td>0.3</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>离散数学</td>
                                            <td> </td><td> </td><td>0.5</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td>0.2</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>数据结构</td>
                                            <td> </td><td> </td><td> </td><td>0.2</td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td>0.2</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>计算机组成原理</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.4</td><td> </td><td>0.2</td><td>0.2</td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>面向对象程序设计（C++）或 面向对象程序设计（Java）</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.2</td><td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>算法设计与分析</td>
                                            <td> </td><td> </td><td> </td><td>0.2</td>
                                            <td> </td><td> </td><td> </td><td> </td><td>0.2</td>
                                            <td> </td><td>0.4</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>软件工程基础</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td>0.5</td><td>0.4</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.4</td><td> </td><td> </td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>软件工程需求与建模</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.6</td><td>0.4</td><td> </td><td> </td><td>0.3</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>数据库原理与设计</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.2</td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>计算机网络</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.2</td><td> </td><td>0.3</td><td>0.2</td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>操作系统</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.2</td><td>0.3</td><td> </td><td>0.2</td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>软件项目管理</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.4</td><td>0.4</td><td>0.6</td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>软件体系结构与设计模式</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.4</td><td> </td>
                                            <td> </td><td>0.4</td><td> </td><td> </td><td>0.4</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>软件测试技术</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td>0.7</td><td>0.3</td>
                                            <td> </td><td> </td><td> </td><td>0.3</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>编译原理</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td>0.2</td><td>0.3</td><td> </td><td>0.3</td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>程序设计方法实践</td>
                                            <td> </td><td> </td><td> </td><td>0.4</td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.2</td><td>0.4</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>网站开发基础</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td>0.3</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td>0.3</td><td> </td><td> </td><td>0.2</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>软件工程实践</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.4</td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.5</td><td> </td><td> </td>
                                            <td> </td><td>0.4</td><td> </td>
                                            <td> </td><td> </td><td> </td><td>0.4</td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>应用系统开发实践</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.3</td><td>0.4</td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.3</td><td>0.3</td><td>0.4</td><td>0.3</td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>分布式系统开发实践</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td>0.3</td><td>0.3</td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td>0.3</td><td>0.3</td><td> </td><td>0.3</td>
                                            <td> </td><td> </td><td> </td>
                                        </tr>
                                        <tr>
                                            <td>毕业设计（论文）</td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td><td> </td>
                                            <td>0.7</td><td> </td><td> </td><td>0.5</td>
                                            <td> </td><td>0.4</td><td>0.3</td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td> </td>
                                            <td> </td><td>0.6</td><td> </td>
                                            <td> </td><td> </td><td> </td><td> </td>
                                            <td> </td><td> </td><td>0.6</td>
                                        </tr>

                                        </tbody>
                                    </table>


                                </div>
                            </div>
                        </div>
                    </i-content>

                </Layout>
            </Layout>
        </Layout>

    </div>

</div>

<script src="/static/echarts/echarts.min.js" type="text/javascript"></script>
<script>
    var app = new Vue({
        el:"#app",
        data:{
            years:'001',
            yearsList:[{id:'001',label:'2009-2011'}]

        },
        methods:{

        },
    });


</script>

</body>
</html>
