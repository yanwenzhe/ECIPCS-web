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
        value1: '',
        header:[],
        data_list:[
            [1, 2, 3],
            [4,5,6]
        ]
    },
    methods: {
        handleEdit(index, row) {
            console.log(index, row);
        },
        handleOpen(key, keyPath) {
            console.log(key, keyPath);
        },
        handleClose(key, keyPath) {
            console.log(key, keyPath);
        },
        onSubmit(formInline) {
            $.ajax({
                type:"get",
                url:"/teacher/resultScore",
                contentType : 'application/json; charset=utf-8',
                dataType : 'json',
                data:{"year":this.formInline.value,"id":this.formInline.value1},
                success: function (result) {
                    console.log(result)
                    test.header = result[0][0]

                    test.data_list = [];
                    for (let i = 1; i < result.length; i++) {
                        test.data_list.push(result[i]);
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
        }
    }
})



