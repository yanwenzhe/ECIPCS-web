<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/3
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>
    <%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>


    <title>教师管理</title>
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
                                教师管理
                            </template>
                            <menu-item name="1-1"><a href="/system/management/manageTeacher">教师用户</a></menu-item>
                        </Submenu>
                    </i-menu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>管理</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>教师用户</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>

                            <div class="centerContent">
                                <div class="backGroundWidth">
                                    <div style="margin-top: 12px;margin-bottom: 12px;margin-right: 30px">
                                        <i-button type="success" style="margin-left: 30px;" @click="addTeacherFunc()">添加教师</i-button>

                                        <date-picker type="year" v-model="year0"
                                                     style="width: 200px;float:right ;"
                                                     clearable="false"
                                                     @on-change="yearChange">
                                        </date-picker>
                                        <i-span style="float:right;margin-top: 12px;" >选择年份&nbsp;&nbsp;</i-span>
                                    </div>
                                </div>
                            </div>
                            <br>

                            <div class="centerContent">
                                <div class="backgroundWidth" >

                                    <div style="margin-top: 20px;margin-bottom: 12px;margin-left:30px;margin-right: 30px">
                                        <table class="table  table-bordered table-hover" style="background-color: #ffffff">
                                            <thead>
                                            <tr>
                                                <th>编号</th>
                                                <th>用户名</th>
                                                <th>名字</th>
                                                <th>电话</th>
                                                <th>年份</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr v-for="item in teacherList">
                                                <td>{{item.id}}</td>
                                                <td>{{item.username}}</td>
                                                <td>{{item.name}}</td>
                                                <td>{{item.phone}}</td>
                                                <td>{{item.year}}</td>
                                                <td><i-button type="primary" @click="editTeacher(item)">编辑</i-button></td>
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
        <i-form v-model="addTeacher" :label-width="80" v-if="modal.type==0">
            <form-item label="姓名">
                <i-input v-model="addTeacher.name" ></i-input>
            </form-item>
            <form-item label="年份">
                <date-picker type="year" v-model="addTeacher.year"
                             :ediltable="false"
                             style="width:150px;"
                             @on-change="addYear">
                </date-picker>
            </form-item>
            <form-item label="联系方式">
                <i-input v-model="addTeacher.phone" placeholder="请输入11位的数字..."></i-input>
            </form-item>
        </i-form>
        <i-form :label-width="80" v-else >

            <form-item label="姓名">
                <i-span>{{name}}</i-span>
            </form-item>
            <form-item label="用户名">
                <i-span>{{username}}</i-span>
            </form-item>
            <form-item label="year">
                <i-span>{{year}}</i-span>
            </form-item>
            <form-item label="联系方式">
                <i-input v-model="phone" ></i-input>
            </form-item>
            <form-item label="新密码">
                <i-input v-model="password" type="password" :rows="4"></i-input>
            </form-item>
        </i-form>
    </Modal>
</div>


<script>
    var app = new Vue({
        el:"#app",
        data:{
            year0:'',
            teacherList:[],
            modal:{
                title:'',
                type:0,
                show:false,
                loading:true
            },
            addTeacher:{
                name:"",
                phone:'',
                year:''
            },
            id:'',
            name:'',
            username:"",
            password:'',
            phone:'',
            year:''
        },
        methods:{
            refreshList(){
                ajaxGet("/system/management/getTeacherList?year="+this.year0,function (d) {
                    app.teacherList=d.data.list;
                },null,false,false);
            },
            yearChange(year){
                this.year0=year;
                this.refreshList();
            },
            addTeacherFunc(){
                this.modal.title="添加教师用户";
                this.modal.show=true;
                this.modal.type=0;
            },
            editTeacher(item){
                this.id=item.id;
                this.name=item.name;
                this.password=item.password;
                this.year=item.year;
                this.phone=item.phone;
                this.username=item.username;
                this.modal.title="编辑教师用户密码";
                this.modal.show=true;
                this.modal.type=1;
            },
            modal_ok(type){
                if(type==0){
                    ajaxPostJSON("/system/management/addTeacher",{addTeacher:app.addTeacher},function (d) {
                        app.refreshList();
                        app.$Modal.success({
                            title: "添加成功",

                        });
                    },function (d) {
                        app.$Modal.error({
                            title: "添加失败",
                        });
                    },false,false)
                }
                else {
                    ajaxPostJSON("/system/management/updateTeacher",{updateTeacher:{id:app.id,password:this.password,phone:this.phone}},function (d) {
                        app.refreshList();
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

            },
            addYear(year){
                this.addTeacher.year=year;
            }
        },
        mounted(){

            this.refreshList();
        }
    })

</script>

</body>
</html>

