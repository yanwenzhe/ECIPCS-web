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
                    <i-menu active-name="2-2" theme="blue" width="auto" :open-names="['2']" :style="{background:'#CCCCFF'}">
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
                        <breacrum-item>毕业达成度图形化</breacrum-item>
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

                                        <div id="nightChart" style="width:100%;height:500px;"></div>

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
            yearsList:[{id:'001',label:'2009-2011'}],
            list:[]

        },
        methods:{

        },
        mounted(){


        }
    });
    $(function () {

        ajaxGet("/system/professor/getChartData", function (d) {
            app.list = d.data.list;
            nightChart();
        }, null, true, false);

        function nightChart() {
            var myChart = echarts.init(document.getElementById('nightChart'));

            //要先得到json格式数据
            var x_data = ['1.1', '1.2', '1.3', '1.4',
                '2.1', '2.2', '2.3', '2.4', '2.5',
                '3.1', '3.2', '3.3', '3.4',
                '4.1', '4.2', '4.3', '4.4',
                '5.1', '5.2', '5.3', '5.4', '5.5',
                '6.1', '6.2', '6.3', '6.4',
                '7.1', '7.2', '7.3',
                '8.1', '8.2', '8.3',
                '9.1', '9.2', '9.3',
                '10.1', '10.2', '10.3',
                '11.1', '11.2', '11.3', '11.4',
                '12.1', '12.2', '12.3',
            ];

            var y_data_left = app.list;
            console.log(y_data_left);


            var option = {
                title: {
                    text: '毕业达成度柱状图'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        label: {
                            backgroundColor: 'rgba(255,255,255,0.8)',
                            extraCssText: 'box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);',
                            textStyle: {
                                color: '#666',
                            },
                        },
                    },
                    backgroundColor: 'rgba(255,255,255,0.8)',
                    extraCssText: 'box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);',
                    textStyle: {
                        color: '#666',
                    }
                },
                legend: {
                    data: ['达成度']
                },
                grid: {
                    top: '100',
                    left: '3%',
                    right: '4%',
                    bottom: '50',
                    containLabel: true
                },
                xAxis: {
                    name: "指标点",
                    data: x_data,
                    axisLabel: { //坐标轴刻度标签的相关设置。
                        interval: 0, //设置为 1，表示『隔一个标签显示一个标签』
                        //rotate:-30,
                        textStyle: {
                            color: '#666',
                            fontStyle: 'normal',
                        }
                    },
                    axisLine: { //坐标轴轴线相关设置
                        lineStyle: {
                            color: '#666',
                            opacity: 1
                        }
                    },
                    splitLine: { //坐标轴在 grid 区域中的分隔线。
                        show: false,
                    }
                },
                yAxis: [{
                    name: '达成度',
                    type: 'value',
                    axisLabel: {
                        textStyle: {
                            color: '#666',
                        }
                    },
                    axisLine: { //坐标轴轴线相关设置
                        lineStyle: {
                            color: '#666',
                            opacity: 1
                        }
                    },
                    axisTick: {
                        show: false
                    },
                    splitLine: {
                        show: false,
                    }
                }],
                series: [{
                    name: '达成度',
                    type: 'bar',
                    markLine: {
                        color: '#FFFFFf',
                        data: [[
                            {name: '标线1起点', value: 0.5, xAxis: -1, yAxis: 0.7},      // 当xAxis为类目轴时，数值1会被理解为类目轴的index，通过xAxis:-1|MAXNUMBER可以让线到达grid边缘
                            {name: '标线1终点', xAxis: '12.3', yAxis: 0.7},             // 当xAxis为类目轴时，字符串'周三'会被理解为与类目轴的文本进行匹配
                        ]]
                    },
                    data: y_data_left,
                    itemStyle: {
                        normal: {
                            //barBorderRadius: 15,
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1, [{
                                    offset: 0,
                                    color: '#229aff'
                                },
                                    {
                                        offset: 1,
                                        color: '#13bfe8'
                                    }
                                ]
                            )
                        }
                    }
                }]
                ,
                dataZoom: [
                    {
                        type: 'slider',
                        show: true,
                        start: 50,
                        end: 100,
                        handleSize: 8,
                        height: 25,
                    },
                    {
                        type: 'inside',
                        start: 50,
                        end: 100
                    },

                ]

            };
            myChart.setOption(option);
        }

    })

</script>

</body>
</html>
