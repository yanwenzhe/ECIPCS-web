var date = new Date();

var year = date.getFullYear();



var test = new Vue({
    el:"#test",
    data:{
        formInline: {
            number: '',
            name: '',
            value: year.valueOf().toString(),
            options: []
        },
        header2:[],
        data_list2:[
        ],
        header:[],
        data_list:[]
    },
    methods: {
        onSubmit(formInline) {
            $.ajax({
                type:"get",
                url:"/teacher/check",
                contentType : 'application/json; charset=utf-8',
                dataType : 'json',
                data:{"year":this.formInline.value,"id":this.formInline.value1,"name":encodeURIComponent(this.formInline.name.toString()),"number":this.formInline.number},
                success: function (result) {
                    console.log(result)
                    test.data_list = []
                    var data1 = [];
                    var data2 = [];
                    var data3 = [];
                    var now = 0;
                    test.data_list2 = []
                    for (let i = 0; i < result.length; i++) {

                        if(result[i].form == null){
                            now = i;
                            console.log(now);
                            break;
                        }

                        var obj = {}
                        data1[i] = result[i].form;
                        data2[i] = result[i].score;
                        data3[i] = result[i].point;
                    }
                    test.header = data1;
                    test.data_list.push(data2);
                    test.data_list.push(data3);

                    test.header2=result[now][0];
                    for (let i = 1; i < result[now].length; i++) {

                        test.data_list2.push(result[now][i])

                    }

                },
                error:function (d) {
                    alert(d)
                }
            })
        },
        change(formInline){
            var subject = new Array();
            console.log(this.formInline.value)
            $.ajax({
                type:"get",
                url:"/teacher/change",
                contentType : 'application/json; charset=utf-8',
                dataType : 'json',
                data:{"year":this.formInline.value},
                success: function (result) {
                    var data = [];
                    for (let i = 0; i < result.length; i++) {

                        var obj = {}
                        obj.value = result[i].id;
                        obj.label = result[i].name;
                        data[i] = obj
                    }
                    test.formInline.options = data;
                },
                error:function (d) {
                    alert(d)
                }
            })
        },
        start(){
            var subject = new Array();
            $.ajax({
                type: 'POST',
                url: "/teacher/initialization",
                contentType : 'application/json; charset=utf-8',
                dataType : 'json',
                success: function (result) {
                    var data = [];
                    for (let i = 0; i < result.length; i++) {

                        var obj = {}
                        obj.value = result[i].id;
                        obj.label = result[i].name;
                        data[i] = obj
                    }
                   test.formInline.options = data;
                },
                error:function (d) {
                    alert(d)
                }
            });
        }
    },
    mounted(){
        this.start()
    }

})

