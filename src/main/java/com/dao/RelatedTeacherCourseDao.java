package com.dao;


import com.entity.RelatedTeacherCourse;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RelatedTeacherCourseDao {

    /**
     * 添加
     * @param relatedTeacherCourse
     */
    public void addRelatedTeacherCourse(RelatedTeacherCourse relatedTeacherCourse);

    /**
     * 修改oldProblem,oldSuggestion,result,newProblem
     * @param relatedTeacherCourse
     */
    public void updateRelatedTeacherCourse(RelatedTeacherCourse relatedTeacherCourse);

    /**
     * 查询
     * @param relatedTeacherCourse
     * @return
     */
    public List<RelatedTeacherCourse> getRelatedTeacherCourse(RelatedTeacherCourse relatedTeacherCourse);

    public List<String>getCourseId(@Param("id")String id);
}


