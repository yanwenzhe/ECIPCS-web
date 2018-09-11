package com.entity;


public class RelatedTeacherCourse {

  private String id; //编号
  private String teacherId; //教师id
  private String courseId; //课程id
  private String oldProblem; //上一届存在的问题
  private String oldSuggestion; //上一届的改进建议
  private String result; //结果
  private String newProblem; //新的问题


  public RelatedTeacherCourse() {
  }

  public RelatedTeacherCourse(String id, String teacherId, String courseId, String oldProblem, String oldSuggestion, String result, String newProblem) {
    this.id = id;
    this.teacherId = teacherId;
    this.courseId = courseId;
    this.oldProblem = oldProblem;
    this.oldSuggestion = oldSuggestion;
    this.result = result;
    this.newProblem = newProblem;
  }


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }


  public String getTeacherId() {
    return teacherId;
  }

  public void setTeacherId(String teacherId) {
    this.teacherId = teacherId;
  }


  public String getCourseId() {
    return courseId;
  }

  public void setCourseId(String courseId) {
    this.courseId = courseId;
  }


  public String getOldProblem() {
    return oldProblem;
  }

  public void setOldProblem(String oldProblem) {
    this.oldProblem = oldProblem;
  }


  public String getOldSuggestion() {
    return oldSuggestion;
  }

  public void setOldSuggestion(String oldSuggestion) {
    this.oldSuggestion = oldSuggestion;
  }


  public String getResult() {
    return result;
  }

  public void setResult(String result) {
    this.result = result;
  }


  public String getNewProblem() {
    return newProblem;
  }

  public void setNewProblem(String newProblem) {
    this.newProblem = newProblem;
  }

}
