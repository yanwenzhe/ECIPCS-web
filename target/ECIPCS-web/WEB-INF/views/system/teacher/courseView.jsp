<%--
  Created by IntelliJ IDEA.
  User: 27758_000
  Date: 2018/9/3
  Time: 20:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>
    <%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>

    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>

    <style>
        .el-header, .el-footer {
            background-color: #B3C0D1;
            color: #333;
            text-align: center;
            line-height: 60px;
        }

        .el-aside {
            background-color: #D3DCE6;
            color: #333;
            text-align: center;
            line-height: 200px;
        }

        .el-main {
            background-color: #E9EEF3;
            color: #333;
            text-align: center;
            line-height: 160px;
        }

        body > .el-container {
            margin-bottom: 40px;
        }

        .el-container:nth-child(5) .el-aside,
        .el-container:nth-child(6) .el-aside {
            line-height: 260px;
        }

        .el-container:nth-child(7) .el-aside {
            line-height: 320px;
        }
    </style>
    <title>课程查看</title>
</head>
<body>

<div id="test" >
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
                    <i-menu active-name="1-1" theme="blue" width="auto" :open-names="['1']" :style="{background:'#CCCCFF'}">
                        <Submenu name="1">
                            <template slot="title">
                                <Icon type="ios-navigate"></Icon>
                                原始成绩
                            </template>
                            <menu-item name="1-1"><a href="/teacher/courseView">查看课程</a></menu-item>
                            <menu-item  name="1-2"><a href="/teacher/gradeReview">成绩查看</a></menu-item>
                        </Submenu>
                        <Submenu name="2">
                            <template slot="title">
                                <Icon type="ios-navigate"></Icon>
                                评价与改进
                            </template>
                            <menu-item name="2-1"><a href="/teacher/result">评价结果</a></menu-item>
                            <menu-item  name="2-2"><a href="/teacher/improvedRecord">改进记录管理</a></menu-item>
                        </Submenu>
                    </i-menu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>原始成绩</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>查看课程</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>
                        <el-container>
                            <el-header style="text-align: right">
                                <p style="font-size: 15px;display: inline-block">年份：</p>
                                <div style="display: inline-block">
                                    <el-date-picker
                                            v-model="value"
                                            type="year"
                                            placeholder="选择年"
                                            value-format="yyyy"
                                            @change="change(value)">
                                    </el-date-picker>
                                </div>

                            </el-header>
                            <el-main style="background-color: #B3C0D1;margin-top: 20px" >

                                <div >
                                    <template>
                                        <el-table
                                                :data="tableData3"
                                        <%--style="width: 100%;height: 100%;"--%>
                                                stripe="true"
                                                border
                                        >
                                            <el-table-column
                                                    prop="number"
                                                    align="center"
                                                    label="编号">
                                            </el-table-column>
                                            <el-table-column
                                                    prop="subject"
                                                    align="center"
                                                    label="科目">
                                            </el-table-column>
                                            <el-table-column label="操作"
                                                             align="center">
                                                <template slot-scope="scope">
                                                    <el-button
                                                            size="mini"
                                                            @click="handleEdit(scope.$index, scope.row)">成绩录入</el-button>
                                                </template>
                                            </el-table-column>
                                        </el-table>
                                    </template>
                                </div>

                            </el-main>
                        </el-container>
                    </i-content>

                </Layout>
            </Layout>
        </Layout>

    </div>
<Modal :title="modal.title" width="600" v-model="modal.show" :loading="modal.loading"
       @on-ok="modal_ok()" :mask-closable="false">
    <Upload
            multiple
            type="drag"
            action="/teacher/upload">
                <div style="padding: 20px 0">
            <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
            <p>  点击或拖放文件到此来上传  </p>
        </div>
    </Upload>
</Modal>
</div>


<script src="/static/js/teacher/courseView.js"></script>

</body>
</html>