<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/7
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
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


    <title>达成度计算</title>
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
                    <i-menu active-name="2-1" theme="blue" width="auto" :open-names="['2']" :style="{background:'#CCCCFF'}">
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
                        </Submenu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>达成度计算</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>毕业达成度计算</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>

                        <div class="centerContent">
                            <div class="backGroundWidth">
                                <div style="margin-top: 12px;margin-bottom: 12px">

                                    <i-label  style="margin-left: 30px;"  >指标点年限范围：2009-2016</i-label>
                                    <i-label  style="margin-left: 30px;"  >计算年限范围:2009-2011</i-label>

                                    <i-select  v-model="indexPointId"
                                               style="float:right;width:150px;margin-right: 30px;"
                                               @on-change="indexPointIdChange()">
                                        <i-option v-for="item in indexPointList " :value="item.id" :key="item.point">
                                            {{item.point}}
                                        </i-option>
                                    </i-select>
                                    <p style="margin-right:5px;float: right; font-size:15px;margin-top: 4px">请选择指标点</p>
                                    <br>
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
                                            <td style="background-color: #ffffff">{{indexPointDesc}}</td>

                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div style="margin-top: 20px;margin-bottom: 12px;margin-left:30px;margin-right: 30px">

                                    <table class="table  table-bordered table-hover" style="background-color: #ffffff">
                                        <thead>
                                        <tr>

                                            <th>课程名</th>
                                            <th>支撑系数（目标值）</th>
                                            <th>2009-2010学年</th>
                                            <th>2010-2011学年</th>
                                            <th>最终结果</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="item in relatedList">

                                            <td>{{item.name}}</td>
                                            <td >
                                                {{item.supportFactor}}
                                            </td>
                                            <td>{{item.supportValue1}}</td>
                                            <td>{{item.supportValue2}}</td>
                                            <td>{{item.supportValueMin}}</td>
                                            <td>
                                                <i-button type="primary" size="small">评价值选择</i-button>&nbsp;&nbsp;
                                                <i-button type="primary" size="small">进入查看</i-button>&nbsp;&nbsp;
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

</div>


<script>
    var app = new Vue({
        el:"#app",
        data:{
            indexPointDesc:'',
            indexPointId:'',
            indexPoint:'',
            indexPointList:[],
            courseList:[],
            courseList2:[],
            relatedList:[],
            year:'2009'

        },
        methods:{
            refreshIndexPointList(){
                //获取指标点的list
                ajaxGet("/system/professor/getIndexPointByIndexRequirement?year="+this.year+"&indexRequirementId=",function (d) {
                    app.indexPointList=d.data.list;
                },null ,true,false);
            },
            indexPointIdChange(){
                this.relatedList.splice(0,this.relatedList.length);
                for(var i=0;i<this.indexPointList.length;i++){
                    if(this.indexPointId==this.indexPointList[i].id)
                        this.idnexPointDesc=this.indexPointList[i].description;
                }
                this.refreshCourseList();
            },
            refreshCourseList(){
                //更据年份和indexPointId获取课程
                ajaxGet("/system/professor/getCourseListByIndexPointId?year="+this.year+"&indexPointId="+this.indexPointId,function(d){
                    app.courseList=d.data.list;
                });
                ajaxGet("/system/professor/getCourseListByIndexPointId?year="+'2010'+"&indexPointId="+this.indexPointId,function(d){
                    app.courseList2=d.data.list;
                });
                for(var i=0;i<this.courseList.length;i++)
                {
                    for(var j=0;j<this.courseList2.length;j++){
                        if(this.courseList[i].name==this.courseList2[j].name&&this.courseList[i].supportDegree=='H'){

                            this.relatedList.push({
                                name:this.courseList[i].teachingContent,
                                supportDegree:this.courseList[i].supportDegree,
                                supportFactor:this.courseList[i].supportFactor,
                                supportValue1:this.courseList[i].evaluateValue,
                                supportValue2:this.courseList2[j].evaluateValue,
                                supportValueMin:this.courseList[i].evaluateValue>this.courseList2[j].evaluateValue?this.courseList2[j].evaluateValue:this.courseList[i].evaluateValue,
                            })
                            break;
                        }
                    }
                }
                console.log(this.courseList);
                console.log(this.relatedList);
            },


        },
        mounted(){
            this.refreshIndexPointList();
        }
    })

</script>

</body>
</html>
