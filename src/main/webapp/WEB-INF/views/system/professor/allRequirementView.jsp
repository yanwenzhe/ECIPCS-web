<%--
  Created by IntelliJ IDEA.
  User: Yan
  Date: 2018/9/6
  Time: 21:12
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <%@include file="/WEB-INF/views/include/adminlteBlankHead.jsp" %>



    <title>查看所有毕业要求</title>
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
                        </Submenu>
                    </i-menu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">

                    <Breadcrumb :style="{margin:'24px 0'}">
                        <breacrum-item>管理</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>指标点管理</breacrum-item>&nbsp;/&nbsp;
                        <breacrum-item>查看所有毕业要求</breacrum-item>
                    </Breadcrumb>
                    <i-content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">

                        <%--这里面写内容，侧边栏要改的东西有active-name和<a>标签条跳转--%>

                        <div class="centerContent">
                            <div class="backGroundWidth">
                                <div style="margin-top: 12px;margin-bottom: 12px;float:left ;margin-left: 30px">

                                    <i-button shape="circle" type="success">返回</i-button>
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
                                            <th>毕业要求名</th>
                                            <th>毕业要求描述</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="item in requirementList">
                                            <td>{{item.id}}</td>
                                            <td>{{item.name}}</td>
                                            <td>{{item.description}}</td>
                                            <td><i-button type="primary" size="small" @click="edit(item)">编辑</i-button></td>
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
        <i-form :label-width="80" >

            <form-item label="编号">
                <i-span>{{id}}</i-span>
            </form-item>
            <form-item label="名称">
                <i-span>{{name}}</i-span>
            </form-item>
            <form-item label="指标描述">
                <i-input v-model="description" text="textarea" :rows="4" ></i-input>
            </form-item>
        </i-form>
    </Modal>
</div>

<%@include file="/WEB-INF/views/include/adminlteBlankScript.jsp" %>
<script type="text/javascript">
    var app = new Vue({
        el:"#app",
        data:{
            requirementList:[{id:2,name:'asdas',description:'asdas'}],
            modal:{
                title:'编辑毕业要求',
                show:false,
                loading:true
            },
            id:'',
            name:"",
            description:''
        },
        methods:{

            refreshList(){
                ajaxGet("/system/professor/getList",function(data){
                    app.requirementList=data.data.list;
                    console.log(app.requirementList[1].name);
                },null,true,false);
            },
            edit(item){
                this.modal.show = true;
                this.id=item.id;
                this.name=item.name;
                this.description=item.description;
            },
            modal_ok(){
                ajaxPostJSON("/system/professor/updateList",{updateList:{id:app.id,description:app.description}},function () {
                    app.$Modal.success({
                        title: "修改成功",
                    });
                },function () {
                    app.$Modal.error({
                        title: "修改失败",
                    });
                },false,false)
                this.modal.show=false;
                this.refreshList();
            }
        },
        mounted(){
           this.refreshList();
        }

    });

</script>

</body>
</html>


