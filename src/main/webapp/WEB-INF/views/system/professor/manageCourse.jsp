<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/6
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>
    <%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>


    <title>课程管理</title>
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
                    <i-menu active-name="1-1" theme="blue" width="auto" :open-names="['1']" :style="{background:'#CCCCFF'}">
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
                    </i-menu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>管理</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>课程管理</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>

                        <div class="centerContent">
                            <div class="backGroundWidth">
                                <div style="margin-top: 12px;margin-bottom: 12px">
                                    <i-button type="success" style="margin-left: 30px;"  @click="addCourse()">添加课程</i-button>
                                    <i-button type="success" style="margin-left: 20px;" @click="allCourse()">查看所有课程</i-button>

                                    <i-select  v-model="indexPoint"
                                               style="float:right;width:150px;margin-right: 30px;"
                                               @on-change="indexPointChange()">
                                        <i-option v-for="item in indexPointList " :value="item.point">
                                            {{item.point}}
                                        </i-option>
                                    </i-select>
                                    <p style="margin-right:5px;float: right; font-size:15px;margin-top: 4px">指标点</p>

                                    <date-picker type="year" v-model="year0"
                                                 clearable="false"
                                                 style="float:right;width:150px;margin-right: 30px;"
                                                 @on-change="yearChange">
                                    </date-picker>
                                    <p style="margin-right:5px;float: right; font-size:15px;margin-top: 4px">年份</p>

                                </div>
                            </div>
                        </div>
                        <br>

                        <div class="centerContent">
                            <div class="backgroundWidth" >
                                <div style="margin-top: 20px;margin-bottom: 12px; margin-left:30px;margin-right: 30px">
                                    <table class="table table-bordered table-hover">
                                        <tbody>
                                        <tr >
                                            <td style="background-color: #ffffff;width:20%;">指标点{{indexPoint}}</td>
                                            <td style="background-color: #ffffff">{{indexPointDescription}}</td>

                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div style="margin-top: 20px;margin-bottom: 12px;margin-left:30px;margin-right: 30px">

                                    <table class="table  table-bordered table-hover" style="background-color: #ffffff">
                                        <thead>
                                        <tr>
                                            <th>编号</th>
                                            <th>课程名</th>
                                            <th>支撑程度/系数</th>
                                            <th>教学内容</th>
                                            <th>考核内容</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="item in list">
                                            <td>{{item.id}}</td>
                                            <td>{{item.courseId}}</td>
                                            <td v-if="item.supportDegree=='H'">
                                                {{item.supportDegree}}/{{item.supportFactor}}
                                            </td>
                                            <td v-else>
                                                {{item.supportDegree}}
                                            </td>
                                            <td>{{item.teachingContent}}</td>
                                            <td>{{item.assessmentContent}}</td>
                                            <td>
                                                <i-button type="primary" size="small" @click="updateCourseFunc(item.id)">编辑</i-button>
                                            </td>
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


    <Modal  :title="modal.title" width="600" v-model="modal.show" :loading="modal.loading"
            @on-ok="modal_ok()" :mask-closable="false">
        <i-form v-model="updateCourse" :label-width="80" v-if="modal.type==0">
            <form-item label="编号">
                <i-input v-model="updateCourse.id" ></i-input>
            </form-item>

            <form-item label="课程名">
                <i-input v-model="updateCourse.courseName" ></i-input>
            </form-item>

            <form-item label="教学内容">
                <i-input v-model="updateCourse.teachingContent" text="textarea" :rows="4"></i-input>
            </form-item>

            <form-item label="考核内容">
                <i-input v-model="updateCourse.assessmentContent" text="textarea" :rows="4"></i-input>
            </form-item>
        </i-form>

        <i-form :label-width="80" v-else v-model="updateCourse">

            <form-item label="编号">
                <i-span>{{updateCourse.id}}</i-span>
            </form-item>
            <form-item label="课程名">
                <i-span>{{updateCourse.courseName}}</i-span>
            </form-item>
            <form-item label="教学内容">
                <i-input v-model="updateCourse.teachingContent" text="textarea" :rows="4" ></i-input>
            </form-item>
            <form-item label="考核内容">
                <i-input v-model="updateCourse.assessmentContent" text="textarea" :rows="4" ></i-input>
            </form-item>
        </i-form>
    </Modal>

</div>


<script>
    var app = new Vue({
        el:"#app",
        data:{
            indexPointId:'', //id
            indexPoint:'', //指标点
            indexPointDescription:'', //指标点描述
            year0:'', //年份
            indexPointList:[], //指标点选择列表
            list:[],//关联表
            modal:{
                title:'',
                loading: true,
                show: false,
            },
            updateCourse:{
                id:'',
                courseName:'',
                teachingContent:'',
                assessmentContent:''
            }
        },
        methods:{
            //所有的点击按钮
            allCourse(){
                window.location.href='/system/professor/allCourse';
            },
            addCourse(){
                window.location.href='/system/professor/addCourse';
            },

            refreshList() {
                //console.log(this.year0);
                ajaxGet("/system/professor/getIndexPointCourse1?indexPointId=" + this.indexPointId +"&year="+this.year0, function (d) {
                    app.list = d.data.list;
                    console.log(app.list);
                }, null, true, false);
            },

            refreshIndexPoint(){
                ajaxGet("/system/professor/getIndexPointList?year="+this.year0,function (d) {
                    app.indexPointList = d.data.indexPointList;
                    //console.log(app.indexPointList);
                },null,true,false);
            },

            refreshListByYear()
            {
                //年份改变，更新列表
                console.log(this.year0)
                ajaxGet("/system/professor/getIndexPointCourseByYear?year="+this.year0,function (d) {
                    app.list = d.data.list;
                    console.log(app.list);
                },null,true,false);
            },

            yearChange(year){
                this.year0 = year;
                //获取指标点列表
                this.refreshIndexPoint();
            },

            indexPointChange(){
                for(var i=0;i<this.indexPointList.length;i++){
                    if(this.indexPointList[i].point == this.indexPoint){//选择指标点之后，把id和描述记住
                        app.indexPointDescription = this.indexPointList[i].description;
                        app.indexPointId = this.indexPointList[i].id;
                        break;
                    }
                }
                console.log("指标点改变"+this.year0+" "+this.indexPointId);
                this.refreshList();
            },

            updateCourseFunc(value){
                console.log(value);
                this.modal.title="编辑课程";
                for(var i=0;i<this.list.length;i++)
                {
                    if (value==this.list[i].id){
                        this.updateCourse.id = value;
                        this.updateCourse.courseName = this.list[i].courseId;
                        this.updateCourse.teachingContent=this.list[i].teachingContent;
                        this.updateCourse.assessmentContent=this.list[i].assessmentContent;
                        break;
                    }
                }
                this.modal.show = true;
            },

            modal_ok(){
                ajaxPostJSON("/system/professor/updateCourse1",{updateCourse:app.updateCourse},function (d) {
                    app.refreshList();
                    app.$Modal.success({
                        title: "修改成功",
                    });
                },function (d) {
                    app.$Modal.error({
                        title: "修改失败",
                    });
                },false,false)

                this.modal.show=false;

            }
        },
        mounted(){
            this.year0="2009";
            this.refreshIndexPoint();
            this.refreshListByYear();
        }
    })

</script>

</body>
</html>
