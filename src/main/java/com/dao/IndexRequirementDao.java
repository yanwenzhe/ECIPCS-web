package com.dao;

import com.entity.IndexPoint;
import com.entity.IndexRequirement;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Repository
public interface IndexRequirementDao {


    /**
     * 查询
     * @param indexRequirement
     * @return
     */
    public List<IndexRequirement> getIndexRequirement(IndexRequirement indexRequirement);


    /**
     * 更新描述
     * @param indexRequirement
     */
    public void updateIndexRequirement(IndexRequirement indexRequirement);

}
