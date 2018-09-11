package com.dao;

import com.entity.Teacher;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeacherDao {

    /**
     *添加
     * @param teacher
     */
    public void addTeacher(Teacher teacher);

    /**
     *修改username,password,phone
     * @param teacher
     */
    public void updateTeacher(Teacher teacher);

    /**
     * 查询
     * @param teacher
     * @return
     */
    public List<Teacher> getTeacher(Teacher teacher);

    public List<String> getTeacherId(@Param("id")String id,@Param("year")String year);
}
