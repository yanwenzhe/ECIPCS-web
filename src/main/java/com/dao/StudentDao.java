package com.dao;

import com.entity.Student;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentDao {

    /**
     * 添加
     * @param student
     */
    public void addStudent(Student student);

    /**
     * 查询
     * @param student
     * @return
     */
    public List<Student> getStudent(Student student);
}
