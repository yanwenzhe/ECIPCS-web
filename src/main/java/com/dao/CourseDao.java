package com.dao;

import com.entity.Course;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseDao {
    /**
     * 添加课程
     * @param course
     */
    public void addCourse(Course course);


    /**
     * 更新课程,年份不能更改
     * @param course
     */
    public void updateCourse(Course course);

    /**
     * 根据course对象里有的字段进行查询
     * @param course
     * @return
     */
    public List<Course> getCourse(Course course);

    public List<String> getCourseName(@Param("id")String id);

    /**
     * 根据年份和输入的课程名模糊查询
     * @param course
     * @return
     */
    public List<Course> getCourseByName(Course course);
}
