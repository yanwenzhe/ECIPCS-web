require.config({
    paths : {
        echarts : 'echarts/echarts',
        'ehcarts/chart/map' : 'chart/map'
    }
});

require(
    [
        '${ctxStatic}/echarts',
    ],
    function(ec){
        require('echarts/util/mapData/params').params.ship  = {
            getGeoJson : function(callback){
                $.ajax({
                    url:"${ctxStatic}/modules/images/huang.svg",//svg地图
                    dataType : "xml",
                    success : function(xml){
                        callback(xml);
                    }
                });
            }
        }
        var myChart2 = ec.init(document.getElementById('main'));
        var option2 = {
            title : {
                text : '测试'
            },
            tooltip : {
                trigger : 'item',
                formatter : '{b}'
            },
            series : [
                {
                    name: '嘿嘿',
                    type: 'map',
                    mapType: 'ship',
                    roam:true,
                    itemStyle:{
                        normal:{label:{show:true}},
                        emphasis:{label:{show:true}}
                    },
                    data: [],
                    geoCoord: {
                        '叮叮': [0, 0],
                        '小兑儿': [100, 45]
                    },
                    markPoint : {
                        symbolSize : 10,
                        effect : {
                            show : true
                        },
                        data : [
                            {name: '叮叮'},
                            {name: '小兑儿'}
                        ]
                    },
                    markLine : {
                        smooth:true,
                        effect : {
                            show: true,
                            scaleSize: 1,
                            period: 20,
                            color: '#fff',
                            shadowBlur: 5
                        },
                        symbol: ['none'],
                        itemStyle : {
                            normal: {
                                borderWidth:1,
                                lineStyle: {
                                    type: 'solid'
                                }
                            }
                        },
                        data : [
                            [
                                {name:'erik'},
                                {name:'胡瑶'}
                            ],
                            [
                                {name:'祖明'},
                                {name:'叮叮'}
                            ],
                            [
                                {name:'祖明'},
                                {name:'小兑儿'}
                            ]
                        ]
                    }
                },
                {
                    name : '信达泰',
                    type : 'map',
                    mapType : 'ship',
                    roam : true,
                    itemStyle:{
                        normal:{label:{show:true}},
                        emphasis:{label:{show:true}}
                    },
                    data: [],
                    geoCoord: {
                        '孙经理': [100, 245],
                        '小姜同学': [100, 345]
                    },
                    markPoint : {
                        symbolSize : 10,
                        symbol : 'image://img/icon.png',
                        data : [
                            {name : '孙经理'},
                            {name : '小姜同学'},

                        ]
                    }
                },
                {
                    name: '高经',
                    type: 'map',
                    mapType: 'ship',
                    roam:true,
                    symbol: ['none'],
                    itemStyle:{
                        normal:{label:{show:true}},
                        emphasis:{label:{show:true}}
                    },
                    data: [],
                    markLine : {
                        smooth:true,
                        effect : {
                            show: true,
                            scaleSize: 1,
                            period: 20,
                            color: '#fff',
                            shadowBlur: 5
                        },
                        itemStyle : {
                            normal: {
                                borderWidth:1,
                                lineStyle: {
                                    type: 'solid'
                                }
                            }
                        },
                        data : [
                            [
                                {name:'高经'},
                                {name:'洗手间', geoCoord:[440, 179]}
                            ],
                            [
                                {name:'高经'},
                                {name:'洗手间', geoCoord:[637, 53]}
                            ],
                            [
                                {name:'高经'},
                                {name:'洗手间', geoCoord:[637, 179]}
                            ],
                            [
                                {name:'高经'},
                                {name:'洗手间', geoCoord:[307, 179]}
                            ]
                        ]
                    }
                }
            ]
        };
        myChart2.setOption(option2);
    }
)