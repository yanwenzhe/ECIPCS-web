package com.entity;

public class AllCourse {
    private int id;
    private String name;
    private String points;
    private String desc;
    private String teachers;

    public AllCourse(int id, String name, String points, String desc, String teachers) {
        this.id = id;
        this.name = name;
        this.points = points;
        this.desc = desc;
        this.teachers = teachers;
    }

    public AllCourse() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPoints() {
        return points;
    }

    public void setPoints(String points) {
        this.points = points;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getTeachers() {
        return teachers;
    }

    public void setTeachers(String teachers) {
        this.teachers = teachers;
    }
}
