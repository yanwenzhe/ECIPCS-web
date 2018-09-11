var date = new Date();

var year = date.getFullYear();

var test = new Vue({
    el:"#test",
    data:{
        value: year.valueOf().toString(),
        tableData3: [],
        modal:{
            title:'成绩录入',
            show:false,
            loading:true
        }
    },
    methods: {
        handleEdit(index, row) {
            this.modal.show=true;
            console.log(index, row);
        },
        modal_ok(){
            this.modal.show=false;
        },
        handleOpen(key, keyPath) {
            console.log(key, keyPath);
        },
        handleClose(key, keyPath) {
            console.log(key, keyPath);
        },
        change(formInline) {
            var subject = new Array();
            console.log(this.value)
            $.ajax({
                type: "get",
                url: "/teacher/course",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: {"year": this.value},
                success: function (result) {
                    test.tableData3 = [];
                    for(var i = 0;i<result.length;i++){
                        var data = [];
                        data.number = result[i][0];
                        data.subject = result[i][1];
                        test.tableData3.push(data)
                    }
                },
                error: function (d) {
                    alert(d)
                }
            })
        }
    }
})



