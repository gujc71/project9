package gu.etc;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EtcSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
        
    public List<?> selectAlertList4Ajax(String param) {
        return sqlSession.selectList("selectAlertList4Ajax", param);
    }

    public List<?> selectAlertList(String param) {
        return sqlSession.selectList("selectAlertList", param);
    }

}
