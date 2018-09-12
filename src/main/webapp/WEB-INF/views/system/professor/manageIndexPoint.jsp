<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/6
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>
    <%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>


    <title>指标点管理</title>
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
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>管理</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>指标点管理</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>

                        <div class="centerContent">
                            <div class="backGroundWidth">
                                <div style="margin-top: 12px;margin-bottom: 12px">
                                    <i-button type="success" style="margin-left: 30px;" @click="addIndexPointFunc('0')">添加指标点</i-button>
                                    <i-button type="success" style="margin-left: 20px;" @click="allRequirement()">查看所有毕业要求</i-button>

                                    <i-select  v-model="requirementId"
                                               style="float:right;width:150px;margin-right: 30px;"
                                               @on-change="requirementIdChange()">
                                        <i-option v-for="item in requirementList " :value="item.id" :key="item.name">
                                            {{item.id+"."+item.name}}
                                        </i-option>
                                    </i-select>
                                    <p style="margin-right:5px;float: right; font-size:15px;margin-top: 4px">指标要求</p>

                                    <date-picker type="year" v-model="year0"
                                                 :ediltable="false"
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
                                            <td style="background-color: #ffffff;width:20%;">{{requirementId+"."+requirementName}}</td>
                                            <td style="background-color: #ffffff">{{requirementDesc}}</td>

                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div style="margin-top: 20px;margin-bottom: 12px;margin-left:30px;margin-right: 30px">

                                    <table class="table  table-bordered table-hover" style="background-color: #ffffff">
                                        <thead>
                                        <tr>
                                            <th>编号</th>
                                            <th>指标名</th>
                                            <th>年限范围</th>
                                            <th>指标描述</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="item in indexPointList">
                                            <td>{{item.id}}</td>
                                            <td>{{item.point}}</td>
                                            <td>{{item.yearStart}}-{{item.yearEnd}}</td>
                                            <td>{{item.description}}</td>

                                            <td>
                                                <i-button type="primary" size="small" @click="addIndexPointFunc(item.id)">编辑</i-button>&nbsp;&nbsp;
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
            @on-ok="modal_ok(modal.type)" :mask-closable="false">
        <i-form v-model="addIndexPoint" :label-width="80" v-if="modal.type==0">
            <form-item label="指标名">
                <i-input v-model="addIndexPoint.point" ></i-input>
            </form-item>
            <form-item>
                <i-select  v-model="addIndexPoint.requirementId"
                           style="width:150px;"
                >
                    <i-option v-for="item in requirementList " :value="item.id" :key="item.name">
                        {{item.id+"."+item.name}}
                    </i-option>
                </i-select>
            </form-item>
            <form-item label="起始年份">
                <date-picker type="year" v-model="addIndexPoint.startYear"
                             :ediltable="false"
                             style="width:150px;"
                             @on-change="addStartYearChange">
                </date-picker>
            </form-item>
            <form-item label="结束年份">
                <date-picker type="year" v-model="addIndexPoint.endYear"
                             :ediltable="false"
                             style="width:150px;"
                             @on-change="addEndYearChange">
                </date-picker>
            </form-item>
            <form-item label="指标描述">
                <i-input v-model="addIndexPoint.description" text="textarea" :rows="4"></i-input>
            </form-item>
        </i-form>
        <i-form :label-width="80" v-else v-model="updateIndexPoint">

            <form-item label="指标点">
                <i-span>{{updateIndexPoint.point}}</i-span>
            </form-item>
            <form-item label="开始年份">
                <i-span>{{updateIndexPoint.yearStart}}</i-span>
            </form-item>
            <form-item label="结束年份">
                <i-span>{{updateIndexPoint.yearEnd}}</i-span>
            </form-item>
            <form-item label="指标描述">
                <i-input v-model="updateIndexPoint.description" text="textarea" :rows="4" ></i-input>
            </form-item>
        </i-form>
    </Modal>
</div>



<script>
    var app = new Vue({
        el:"#app",
        data:{
            requirementId:"",
            requirementName:'',
            requirementDesc:'',
            requirementList:[],
            indexPointId:"",
            indexPointDescription:'',
            indexPointList:[],
            year0:"",
            modal:{
                title:'',
                loading: true,
                show: false,
                type:0
            },
            addIndexPoint:{
                requirementId:'',
                point:'',
                startYear:'',
                endYear:'',
                description:''
            },
            updateIndexPoint:{
                id:'',
                point:'',
                startYear:'',
                endYear:'',
                description:''
            }
        },
        methods:{
            requirementIdChange(){
                for(var i=0;i<this.requirementList.length;i++){
                    if(this.requirementList[i].id==this.requirementId){
                        this.requirementName=this.requirementList[i].name;
                        this.requirementDesc=this.requirementList[i].description;
                    }
                }
                ajaxGet("/system/professor/getIndexPointByIndexRequirement?indexRequirementId="+this.requirementId+"&year="+this.year0,function (d) {
                    app.indexPointList = d.data.list;
                },null,true,false);
            },
            refreshList() {
                ajaxGet("/system/professor/getList",function (d) {
                    app.requirementList = d.data.list;
                },null,true,false);
                ajaxGet("/system/professor/getIndexPointByIndexRequirement?indexRequirementId="+this.requirementId+"&year="+this.year0,function (d) {
                    app.indexPointList = d.data.list;
                },null,true,false);
            },
            yearChange(year){
                this.year0 = year;
                ajaxGet("/system/professor/getIndexPointByIndexRequirement?indexRequirementId="+this.requirementId+"&year="+this.year0,function (d) {
                    app.indexPointList = d.data.list;
                },null,true,false);
            },
            allRequirement(){
                window.location.href='/system/professor/allRequirement';
            },
            addIndexPointFunc(value){
                console.log(value);
                if(value==='0')
                {
                    this.modal.title="添加指标点";this.modal.type=0;
                    console.log(this.modal.title);
                }
                else{
                    this.modal.title="编辑指标点";this.modal.type=1;
                    for(var i=0;i<this.indexPointList.length;i++)
                    {
                        if (value==this.indexPointList[i].id){
                            this.updateIndexPoint.id = value;
                            this.updateIndexPoint.point=this.indexPointList[i].point;
                            this.updateIndexPoint.yearStart=this.indexPointList[i].yearStart;
                            this.updateIndexPoint.yearEnd=this.indexPointList[i].yearEnd;
                            this.updateIndexPoint.description=this.indexPointList[i].description;
                            break;
                        }
                    }
                }
                this.modal.show = true;
                console.log(this.modal.show);
            },
            modal_ok(type){
                if(type==0){
                    ajaxPostJSON("/system/professor/addIndexPoint",{addIndexPoint:app.addIndexPoint},function (d) {
                        app.$Modal.success({
                            title: "保存成功",
                        });
                    },function (d) {
                        app.$Modal.error({
                            title: "保存失败",
                        });
                    },false,false);
                }
                else{
                    ajaxPostJSON("/system/professor/updateIndexPoint",{udpateIndexPoint:app.updateIndexPoint},function (d) {
                        app.$Modal.success({
                            title: "修改成功",
                        });
                    },function (d) {
                        app.$Modal.error({
                            title: "修改失败",
                        });
                    },false,false)
                }
                this.modal.show=false;
                this.refreshList();

            },
            addStartYearChange(year){
                this.addIndexPoint.startYear=year;
            },
            addEndYearChange(year){
                this.addIndexPoint.endYear=year;
            }
        },
        mounted(){
            this.refreshList();
        }
    })
</script>

</body>
</html>