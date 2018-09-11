package com.dao;

import com.entity.RelatedIndexPointCourseTeacher;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RelatedIndexPointCourseTeacherDao {

    /**
     * 添加
     * @param relatedIndexPointCourseTeacher
     */
    public void addRelatedIndexPointCourseTeacher(RelatedIndexPointCourseTeacher relatedIndexPointCourseTeacher);

    /**
     * 修改hasChosen
     * @param relatedIndexPointCourseTeacher
     */
    public void updateRelatedIndexPointCourseTeacher(RelatedIndexPointCourseTeacher relatedIndexPointCourseTeacher);

    /**
     *查询
     * @param relatedIndexPointCourseTeacher
     * @return
     */
    public List<RelatedIndexPointCourseTeacher> getRelatedIndexPointCourseTeacher(RelatedIndexPointCourseTeacher relatedIndexPointCourseTeacher);
}
