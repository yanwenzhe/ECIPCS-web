var test = new Vue({
    el:"#test",
    data:{
        tag1:"大学物理",
        tag2:"2015-2016",
        tableData3: [{
            number: '2016-05-03',
            demand: '王小虎',
            indicatorPoint: '上海',
            tcontent: '普陀区',
            acontent:'21'
        }, {
            number: '2016-05-03',
            demand: '王小虎',
            indicatorPoint: '上海',
            tcontent: '普陀区',
            acontent:'21'
        }],
        form: {
            desc1: '1',
            desc2: '2',
            desc3: '3',
            desc4: '4',
            desc5: '5'
        }
    },
    methods: {
        onSubmit() {
            console.log('submit!');
        }
    }
})