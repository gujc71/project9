package gu.main;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IndexSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
        
    public Integer selectAlertCount(String param) {
        return sqlSession.selectOne("selectAlertCount", param);
    }
    
    public List<?> selectRecentNews() {
        return sqlSession.selectList("selectRecentNews");
    }
    
    public List<?> selectTimeLine() {
        return sqlSession.selectList("selectTimeLine");
    }
    
    public List<?> selectNoticeListTop5() {
        return sqlSession.selectList("selectNoticeListTop5");
    }
    
    public List<?> selectBoardGroupCount4Statistic() {
        return sqlSession.selectList("selectBoardGroupCount4Statistic");
    }  
}
