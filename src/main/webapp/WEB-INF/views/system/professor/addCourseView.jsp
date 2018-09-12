<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/7
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>
    <%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>


    <title>添加课程</title>
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
                        <breacrum-item>课程管理</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>添加课程</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>

                        <div class="centerContent">
                            <div class="backGroundWidth">
                                <div style="margin-top: 12px;margin-bottom: 12px">
                                    <i-button type="success" style="margin-left: 30px;">返回</i-button>


                                    <date-picker type="year" v-model="formCourse.year"
                                                 style="float:right;width:100px;margin-right: 30px;"
                                                 clearable="false"
                                                 @on-change="yearChange">
                                    </date-picker>
                                    <p style="margin-right:5px;float: right; font-size:15px;margin-top: 4px">年份</p>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="centerContent">
                            <div class="backgroundWidth" >
                                <div style="margin-top: 20px;margin-bottom: 12px;margin-left:30px;margin-right: 30px">
                                    <i-form :model="formCourse" :label-width="80">
                                        <form-item label="课程名">
                                            <i-input v-model="formCourse.name"></i-input>
                                        </form-item>
                                        <form-item label="课程描述">
                                            <i-input v-model="formCourse.desc" type="textarea" :rows="4"></i-input>
                                        </form-item>
                                        <form-item label="指标点">
                                            <i-button type="warning" @click="modalStart">
                                                添加指标点
                                            </i-button>
                                            <%--显示添加的指标点支撑系数--%>
                                        </form-item>
                                        <form-item>
                                            <table class="table  table-bordered table-hover">
                                                <tbody>
                                                <tr v-for="item in formCourse.selectIndexPointList">
                                                    <td>{{item.indexPointId}}</td>
                                                    <td>{{item.point}}</td>
                                                    <td v-if="item.supportDegree=='H'">
                                                        {{item.supportDegree}}/{{item.supportFactor}}
                                                    </td>
                                                    <td v-else>
                                                        {{item.supportDegree}}
                                                    </td>
                                                    <td>
                                                        <i-button type="warning" @click="delete_item(item.indexPointId)">删除</i-button>
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </form-item>
                                        <form-item label="教师">
                                            <i-select  v-model="selectTeacherList"
                                                       style="width:150px;"
                                                       multiple>
                                                <i-option v-for="item in teacherList " :value="item.id" :key="item.name">
                                                    {{item.name}}
                                                </i-option>
                                            </i-select>
                                        </form-item>
                                        <form-item>
                                            <i-button type="primary" @click="submit()">
                                                确认添加
                                            </i-button>
                                        </form-item>
                                    </i-form>

                                </div>
                            </div>
                        </div>

                    </i-content>

                </Layout>
            </Layout>
        </Layout>

    </div>
<Modal :title="modal.title" width="600" v-model="modal.show" :loading="modal.loading"
    @on-ok="modal_ok()" :mask-closable="false">
    <i-form  :label-width="150" >
        <form-item label="毕业要求选择">
            <i-select  v-model="requirementId"
                       style="width:150px;margin-right: 30px;"
                       @on-change="requirementIdChange()">
                <i-option v-for="item in requirementList " :value="item.id" :key="item.name">
                    {{item.name}}
                </i-option>
            </i-select>
        </form-item>
        <form-item label="指标点选择">
            <i-select  v-model="indexPointId"
                       style="width:150px;margin-right: 30px;"
                       @on-change="indexPointIdChange()">
                <i-option v-for="item in indexPointList " :value="item.id" :key="item.point">
                    {{item.point}}
                </i-option>
            </i-select>
        </form-item>
        <form-item label="该指标点支撑的课程">
            <table class="table-border table">
                <tbody>
                <tr v-for="item in courseList">
                    <td>{{item.teachingContent}}</td>
                    <td>
                        <i-input v-model="item.supportFactor" >{{item.supportFactor}}</i-input>
                    </td>
                </tr>
                </tbody>
            </table>
        </form-item>
        <form-item label="支撑程度">
            <i-input v-model="selectIndexPoint.supportDegree" ></i-input>
        </form-item>
        <form-item label="系数">
            <i-input v-model="selectIndexPoint.supportFactor" ></i-input>
        </form-item>
    </i-form>
</Modal>
</div>


<script>
    var app = new Vue({
        el:"#app",
        data:{
            formCourse:{
                name:'',
                desc:'',
                year:'',
                selectIndexPointList:[],
                selectTeacherList:[]
            },
            selectTeacherList:[],
            //year0:'',
            indexPointDesc:'',
            indexPointId:'',
            indexPoint:'',
            indexPointList:[],
            courseList:[],
            requirementId:"",
            requirementName:'',
            requirementDesc:'',
            requirementList:[],
            teacherList:[],
            modal:{
                title:'添加指标点',
                show:false,
                loading:true
            },
            selectIndexPoint:{
                indexPointId:'',
                point:'',
                name:'',
                supportFactor:0.0,
                supportDegree:'H'
            }
        },
        methods:{
            modalStart(){
                this.modal.show=true;
            },
            refreshRequirementList(){
                //先获取指标要求的List
                ajaxGet("/system/professor/getList",function (d) {

                    app.requirementList=d.data.list;
                },null,false,false);

            },
            refreshIndexPointList(){
                //根据年份和毕业要求id获取指标点的List
                ajaxGet("/system/professor/getIndexPointByIndexRequirement?indexRequirementId="+this.requirementId
                    +"&year="+this.formCourse.year,function (d) {
                    app.indexPointList=d.data.list;
                },null,false,false);

            },
            refreshTeacherList(){
                //根据年份获取教师的list
                ajaxGet("/system/management/getTeacherList?year="+this.formCourse.year,function (d) {
                    app.teacherList=d.data.list;
                },null,false,false);

            },
            refreshCourseList(){
                //根据指标点id和年份获取课程的List
                ajaxGet("/system/professor/getCourseListByIndexPointId?year="+this.formCourse.year+"&indexPointId="+this.indexPointId,function (d) {
                    app.courseList=d.data.list;
                },null,false,false);

            },
            //指标点改变的时候
            indexPointIdChange(key){
                //this.indexPointId=id;
                this.selectIndexPoint.point=key;
                this.refreshCourseList();
            },
            //毕业要求的改变的时候
            requirementIdChange(){
                //this.requirementId=id;
                this.refreshIndexPointList();
            },
            //年份的改变
            yearChange(year){

                this.formCourse.year=year;
                this.refreshTeacherList();
            },
            submit(){

                for(var i=0;i<this.selectTeacherList.length;i++)
                {
                    this.formCourse.selectTeacherList.push({id:this.selectTeacherList[i]});
                }

                console.log(this.courseList);
                console.log(this.formCourse);
                ajaxPostJSON("/system/professor/addCourseTable",{formCourse:this.formCourse},function (d) {
                    app.$Modal.success({
                        title: d.data.success,
                    });
                },function (d) {
                    app.$Modal.error({
                        title: "保存失败",
                    });
                },false,false);

                //保存当前修改的课程的指标点
                ajaxPostJSON("/system/professor/updateCourseIndexPointRelated",{courseList:this.courseList},function (d) {
                    console.log("success");
                    app.$Modal.success({
                        title: "修改课程指标点成功",
                    });
                },function (d) {
                    app.$Modal.error({
                        title: "保存失败",
                    });
                },false,false);

            },
            modal_ok(){
                this.selectIndexPoint.indexPointId=this.indexPointId;
                for(var i=0;i<this.indexPointList.length;i++){
                    if(this.indexPointId==this.indexPointList[i].id){
                        this.selectIndexPoint.point=this.indexPointList[i].point;
                        break;
                    }
                }
                //将选择的指标点接上去
                this.formCourse.selectIndexPointList.push({
                    indexPointId:this.selectIndexPoint.indexPointId,
                    point:this.selectIndexPoint.point,
                    name:'',
                    supportFactor:this.selectIndexPoint.supportFactor,
                    supportDegree:this.selectIndexPoint.supportDegree
                });

                this.modal.show=false;
            },
            delete_item(id){
                console.log(id);
                for(var i=0;i<this.formCourse.selectIndexPointList.length;i++){
                    if(id==this.formCourse.selectIndexPointList[i].indexPointId){
                        this.formCourse.selectIndexPointList.splice(i,1);
                    }
                }
            },

            allCourse(){
                window.location.href='/system/professor/allCourse';
            }
        },
        mounted(){
            this.refreshRequirementList();
        }
    })

</script>

</body>
</html>

