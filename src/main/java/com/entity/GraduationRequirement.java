package com.entity;


public class GraduationRequirement {

  private String id; //编号
  private String indexPointId; //指标点id
  private String yearStart; //开始学年
  private String yearEnd; //结束学年
  private double value; //某个指标点的达成度


  public GraduationRequirement() {
  }

  public GraduationRequirement(String id, String indexPointId, String yearStart, String yearEnd, double value) {
    this.id = id;
    this.indexPointId = indexPointId;
    this.yearStart = yearStart;
    this.yearEnd = yearEnd;
    this.value = value;
  }


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }


  public String getIndexPointId() {
    return indexPointId;
  }

  public void setIndexPointId(String indexPointId) {
    this.indexPointId = indexPointId;
  }


  public String getYearStart() {
    return yearStart;
  }

  public void setYearStart(String yearStart) {
    this.yearStart = yearStart;
  }


  public String getYearEnd() {
    return yearEnd;
  }

  public void setYearEnd(String yearEnd) {
    this.yearEnd = yearEnd;
  }


  public double getValue() {
    return value;
  }

  public void setValue(double value) {
    this.value = value;
  }

}
