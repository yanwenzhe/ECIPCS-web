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

                                    <i-label  style="margin-left: 30px;"  >指标点年限范围：2015-2019</i-label>
                                    <i-label  style="margin-left: 30px;"  >计算年限范围:2017-2019</i-label>

                                    <i-select  v-model="indexPointId"
                                               style="float:right;width:150px;margin-right: 30px;"
                                               :on-change="indexPointIdChange()">
                                        <i-option v-for="item in indexPointList " :value="item.id" :key="item.name">
                                            {{item.name}}
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
                                            <th>XX学年</th>
                                            <th>XX学年</th>
                                            <th>最终结果</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="item in courseList">

                                            <td>{{item.name}}</td>
                                            <td >
                                                {{item.supportDegree}}
                                            </td>
                                            <td>0.32</td>
                                            <td>0.24</td>
                                            <td>0.24</td>
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
    var vue = new Vue({
        el:"#app",
        data:{
            indexPointDesc:'',
            indexPointId:'001',
            indexPoint:'',
            indexPointList:[{
                id:'001',
                indexPoint:'1.1',
                yearStart:'2018',
                yearEnd:'2020',
                description:"这个指标1.1描述只这样的"
            },{
                id:'002',
                indexPoint:'1.2',
                yearStart:'2018',
                yearEnd:'2020',
                description:"这个指标1.2描述只这样的"
            }],
            courseList:[{
                id:'2018001',
                name:'《工科数学分析》',
                supportDegree:'H',
                supportFactor:0.3,
                teachingContent:"这个教学内容我也不知道",
                assessmentContent:"这个考核内容我也不知道",
            },{
                id:'2018002',
                name:'《线性代数》',
                supportDegree:'H',
                supportFactor:0.3,
                teachingContent:"这个教学内容我也不知道",
                assessmentContent:"这个考核内容我也不知道",
            },{
                id:'2018003',
                name:'《大学物理》',
                supportDegree:'H',
                supportFactor:0.4,
                teachingContent:"这个教学内容我也不知道",
                assessmentContent:"这个考核内容我也不知道",
            },{
                id:'2018004',
                name:'《物理实验》',
                supportDegree:'M',
                supportFactor:0,
                teachingContent:"这个教学内容我也不知道",
                assessmentContent:"这个考核内容我也不知道",
            }]

        },
        methods:{
            indexPointIdChange(){
                for(var i=0;i<this.indexPointList.length;i++){
                    if(this.indexPointList[i].id==this.indexPointId){
                        this.indexPoint=this.indexPointList[i].indexPoint;
                        this.indexPointDesc=this.indexPointList[i].description;
                    }
                }
            },

        },
    })

</script>

</body>
</html>
