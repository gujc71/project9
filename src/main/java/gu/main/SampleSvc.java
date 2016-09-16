package gu.main;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SampleSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
        
    public List<?> selectBoardGroupCount4Statistic() {
        return sqlSession.selectList("selectBoardGroupCount4Statistic");
    }  
}
