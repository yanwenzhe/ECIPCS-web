package com.dao;

import com.entity.StudentScore;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentScoreDao {

    /**
     * 添加
     * @param studentScore
     */
    public void addStudentScore(StudentScore studentScore);

    /**
     * 修改score,fullScore
     * @param studentScore
     */
    public void updateStudentScore(StudentScore studentScore);

    /**
     * 查询
     * @param studentScore
     * @return
     */
    public List<StudentScore> getStudentScore(StudentScore studentScore);

    /**
     * 列名查询
     */
    public List<String> getColumName(@Param(value="course")String course);

    /**
     * 分配分数查询
     */
    public List<Double> getScore(@Param(value="course")String course,@Param(value="colum")String colum);
    public List<String> getPointid(@Param(value="course")String course,@Param(value="colum")String colum,@Param(value="score")Double score);
    public List<String> getPoint(@Param(value="pointid")String pointid);

    /**
     * 成绩查询
     */
    public List<String>getStudentId(@Param(value="course")String course);
    public List<Double>getStuScore(@Param(value="course")String course,@Param(value="colum")String colum,@Param(value="stuId")String stuId);

    public List<Double>getFullScore(@Param(value="course")String course,@Param(value="colum")String colum,@Param(value="pointId")String pointId);
    public List<Double>getAverageScore(@Param(value="course")String course,@Param(value="colum")String colum,@Param(value="pointId")String pointId);
}
