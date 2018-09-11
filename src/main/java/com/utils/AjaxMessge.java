package com.utils;

public class AjaxMessge {
    private String code;
    private String message;
    private Object data;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public AjaxMessge()
    {
        Set(MsgType.Success, "");
    }

    public AjaxMessge Set(MsgType msgtype, String msg, Object obj)
    {
        code = msgtype.toString().toLowerCase();
        message = msg;
        data = obj;

        return this;
    }

    public AjaxMessge Set(MsgType msgtype, Object obj)
    {
        code = msgtype.toString().toLowerCase();
        message = "";
        data = obj;

        return this;
    }

    public AjaxMessge Set(String txtcode, String msg, Object obj)
    {
        code = txtcode;
        message = msg;
        data = obj;

        return this;
    }


}