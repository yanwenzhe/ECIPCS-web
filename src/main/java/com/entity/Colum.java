package com.entity;

public class Colum {

    String form;
    String score;
    String point;

    public Colum(String form, String score, String point) {
        this.form = form;
        this.score = score;
        this.point = point;
    }

    public Colum(){

    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getPoint() {
        return point;
    }

    public void setPoint(String point) {
        this.point = point;
    }
}
