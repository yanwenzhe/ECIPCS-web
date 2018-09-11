package com.entity;


public class Teacher {

  private String id; //编号
  private String username; //用户名
  private String name;//名字
  private String password; //密码
  private String phone; //手机号
  private String year; //年份


  public Teacher() {
  }

  public Teacher(String id, String username, String name,String password, String phone, String year) {
    this.id = id;
    this.username = username;
    this.name=name;
    this.password = password;
    this.phone = phone;
    this.year = year;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }


  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }


  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }


  public String getYear() {
    return year;
  }

  public void setYear(String year) {
    this.year = year;
  }

}
