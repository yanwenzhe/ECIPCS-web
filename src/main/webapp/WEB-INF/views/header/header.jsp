<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/4
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>Title</title>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>
</head>
<body>
<style>
    .layout{
        border: 1px solid #d7dde4;
        background: #f5f7f9;
        position: relative;
        border-radius: 4px;
        overflow: hidden;
    }
</style>
<div id="app">

    <div class="layout">
        <Layout>
            <i-header theme="theme2"  >
                <h1 style="color: wheat">工程认证指标点计算系统</h1>
            </i-header>
            <Layout>
                <Sider hide-trigger >
                    <i-menu active-name="1-2" theme="dark" width="auto" :open-names="['1']">
                        <Submenu name="1">
                            <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                                Item 1
                            </template>
                            <menu-item name="1-1">Option 1</menu-item>
                            <menu-item  name="1-2">Option 2</menu-item>
                            <menu-item name="1-3">Option 3</menu-item>
                        </Submenu>
                    </i-menu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>Home</breacrum-item>
                        <breacrum-item>Components</breacrum-item>
                        <breacrum-item>Layout</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">
                        Content
                    </i-content>

                </Layout>
            </Layout>
        </Layout>

    </div>
</div>
<%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>
<script>
    var vue=new Vue({
        el:"#app",
        data:{}
    })
</script>
</body>
</html>
