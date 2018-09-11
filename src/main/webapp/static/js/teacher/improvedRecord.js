var date = new Date();

var year = date.getFullYear();

var test = new Vue({
    el:"#test",
    data:{
        value: year.valueOf().toString(),
        options: [{
            value: '选项1',
            label: '黄金糕'
        }, {
            value: '选项2',
            label: '双皮奶'
        }, {
            value: '选项3',
            label: '蚵仔煎'
        }, {
            value: '选项4',
            label: '龙须面'
        }, {
            value: '选项5',
            label: '北京烤鸭'
        }],
        value1: '',
        tableData3: [{
            number: '2016-05-03',
            subject: '王小虎',
            date: '上海',
            yesOrNo: '否'
        }, {
            number: '2016-05-03',
            subject: '王小虎',
            date: '上海',
            yesOrNo: '否'
        }]
    },
    methods: {
        handleEdit(index, row) {
            window.location.href="/teacher/improvedAnalysis";
            console.log(index, row);
        },
        handleDetails(index, row) {
            console.log(index, row);
        },
        handleOpen(key, keyPath) {
            console.log(key, keyPath);
        },
        handleClose(key, keyPath) {
            console.log(key, keyPath);
        }
    }
})



