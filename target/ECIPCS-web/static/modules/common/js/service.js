(function (window, document) {

    'use strict';


    angular.module('service', [])

        // .run(function (toaster) {
        //     if ($("toaster-container").length <= 0)
        //         $("div[ng-app]").append("<toaster-container toaster-options=\"{'time-out': 2000 ,'position-class': 'toast-top-center'}\"></toaster-container>");
        //
        // })


        .factory('Loading', function () {

            return {
                show: function () {
                    //$ionicLoading.show({
                    //    template: '<ion-spinner icon="bubbles" class="spinner-balanced"></ion-spinner>',
                    //    noBackdrop: true,
                    //    duration: 10000,

                    //});
                },
                hide: function () {
                    //$ionicLoading.hide();
                }
            }
        })


    .factory('WebApi', function ($http, $q, Loading) {

        /**
         * 通用GET方法
         * @param apiUrl 接口地址
         * @param successCallback 成功回调函数（可选）
         * @param errorCallback 失败回调函数（可选）
         * @param showMsg 是否显示返回消息（可选）
         * @return promise
         */
        function get(apiUrl, successCallback, errorCallback, showMsg) {
            showMsg = showMsg || true;
            Loading.show();
            var deferred = $q.defer();

            $http({
                method: 'GET',
                url: apiUrl,
                //headers: { 'token': Config.getToken() }
            }).success(
                function (d, status) {
                    //调用成功

                    Loading.hide();


                    //有返回消息
                    if (showMsg && d.message && d.message != "") {
                        if (d.code == 'success') {
                            //window.top.layer.msg(d.message, { offset: '100px' });
                            toastr.success("", d.message);
                            //toastr.pop('success', "", d.message, 2000);
                        } else {
                            //window.top.layer.msg(d.message, { offset: '100px' });
                            toastr.error("", d.message);
                            //toaster.pop('error', "", d.message, 2000);

                        }
                    }


                    if (typeof (successCallback) == 'function') successCallback(d);
                    deferred.resolve(d, status);
                })
            .error(
                function (d, status) {
                    Loading.hide();

                    //webapi调用失败
                    if (d && typeof(d)!='object' && d != "") {
                        //window.top.layer.msg(d, { offset: '100px' });
                        toastr.error("", d);
                        //toaster.pop('error', "", d, 2000);
                    }
                        

                    if (typeof (errorCallback) == 'function') errorCallback(d);
                    deferred.reject(d, status);
                });

            return deferred.promise;
        }


        /**
         * 通用POST方法
         * @param apiUrl 接口地址
         * @param data 参数请求体
         * @param successCallback 成功回调函数（可选）
         * @param errorCallback 失败回调函数（可选）
         * @param showMsg 是否显示返回消息（可选）
         * @return promise
         */
        function post(apiUrl, data, successCallback, errorCallback, showMsg) {
            showMsg = showMsg || true;
            Loading.show();
            var deferred = $q.defer();

            $http({
                method: 'POST',
                url: apiUrl,
                // headers: { 'token': Config.getToken() },
                data: data
            }).success(
                function (d, status) {
                    Loading.hide();

                    //有返回消息
                    if (showMsg && d.message && d.message != "") {
                        if (d.code == 'success') {
                            //window.top.layer.msg(d.message, { offset: '100px' });
                            toastr.success("", d.message);
                            //toaster.pop('success', "", d.message, 2000);
                        } else {
                            //window.top.layer.msg(d.message, { offset: '100px' });
                            toastr.error("", d.message);
                            //toaster.pop('error', "", d.message, 2000);

                        }
                    }


                    if (typeof (successCallback) == 'function') successCallback(d);
                    deferred.resolve(d, status);
                })
            .error(
                function (d, status) {
                    Loading.hide();

                    //webapi调用失败
                    if (d && typeof (d) != 'object' && d != "") {
                        
                        //window.top.layer.msg(d, { offset: '100px' });

                        toastr.error("", d);
                        //toaster.pop('error', "", d, 2000);
                    }

                    if (typeof (errorCallback) == 'function') errorCallback(d);
                    deferred.reject(d, status);
                });

            return deferred.promise;
        }


        return {

            get: function (apiUrl, successCallback, errorCallback) {
                get(apiUrl, successCallback, errorCallback);
            },

            post: function (apiUrl, data, successCallback, errorCallback) {
                post(apiUrl, data, successCallback, errorCallback);
            },

        }
    })



    .factory("Tools", function () {

        return {
            showFlowChart: function (flowName, flowNo, WorkId, fId) {

                var width = ($(window)).width() * 0.8;
                var height = ($(window)).height() - 30;
                width = width > 1100 ? 1100 : width;
                height = height > 750 ? 750 : height;

                layer.open({
                    type: 2,
                    title: flowName + '流程图',
                    maxmin: false,
                    scrollbar: false,
                    resize: false,
                    shadeClose: true, //点击遮罩关闭层
                    area: [width + 'px', +height + 'px'],
                    content: '/content/pages/flowchart/flowChart.html?flowNo=' + flowNo + '&workId=' + WorkId + '&fId=' + fId
                    
                });

            },


            
            fillForm: function (action, flowNo, fkNode, workId,fId, endCallback) {

                action = action || "";
                flowNo = flowNo || "";
                fkNode = fkNode || "";
                workId = workId || "";
                fId = fId || "";
                endCallback = endCallback || null;


                layer.open({
                    type: 2,
                    title: '填写表单',
                    maxmin: false,
                    scrollbar: false,
                    resize: false,
                    shadeClose: false, //点击遮罩关闭层
                    area: [$(window).width() * 0.8 + 'px', +$(window).height() * 0.8 + 'px'],
                    content: '/wf/fillForm?action=' + action + "&flowNo=" + flowNo + "&fkNode=" + fkNode + "&workId=" + workId + "&fId=" + fId,
                    end: function () {
                        if (typeof (endCallback) == 'function') endCallback();
                    }

                });

            },



            showTaskInfo: function (OID, contentinfo) {

                var width = ($(window)).width() * 0.8;
                var height = ($(window)).height() - 30;
                width = width > 1100 ? 1100 : width;
                height = height > 750 ? 750 : height;

                layer.open({
                    type: 2,
                    title: '出访信息查看',
                    maxmin: false,
                    scrollbar: false,
                    resize: false,
                    shadeClose: true, //点击遮罩关闭层
                    area: [width + 'px', +height + 'px'],
                    content: contentinfo,

                });
            }



        }
    })



})(window, document);