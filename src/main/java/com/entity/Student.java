package com.entity;


public class Student {

  private String id; //编号
  private String schoolNumber; //学号
  private String name; //姓名
  private String classId; //班号

  public Student() {
  }

  public Student(String id, String schoolNumber, String name, String classId) {
    this.id = id;
    this.schoolNumber = schoolNumber;
    this.name = name;
    this.classId = classId;
  }


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }


  public String getSchoolNumber() {
    return schoolNumber;
  }

  public void setSchoolNumber(String schoolNumber) {
    this.schoolNumber = schoolNumber;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getClassId() {
    return classId;
  }

  public void setClassId(String classId) {
    this.classId = classId;
  }

}
