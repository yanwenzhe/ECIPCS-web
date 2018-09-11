package com.entity;

public class IndexPoint {

  private String id; //编号
  private String indexRequirementId; //指标要求id
  private String point; //指标点
  private String yearStart; //开始学年
  private String yearEnd; //结束学年
  private String description; //描述


  public IndexPoint(String id, String indexRequirementId, String point, String yearStart, String yearEnd, String description) {
    this.id = id;
    this.indexRequirementId = indexRequirementId;
    this.point = point;
    this.yearStart = yearStart;
    this.yearEnd = yearEnd;
    this.description = description;
  }

  public IndexPoint() {
  }


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }


  public String getIndexRequirementId() {
    return indexRequirementId;
  }

  public void setIndexRequirementId(String indexRequirementId) {
    this.indexRequirementId = indexRequirementId;
  }


  public String getPoint() {
    return point;
  }

  public void setPoint(String point) {
    this.point = point;
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


  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

}
