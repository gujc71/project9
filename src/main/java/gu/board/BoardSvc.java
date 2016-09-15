package gu.board;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import gu.admin.board.BoardGroupVO;
import gu.common.Field3VO;
import gu.common.FileVO;

@Service
public class BoardSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;

    static final Logger LOGGER = LoggerFactory.getLogger(BoardSvc.class);
    
    /** 
     * 게시판 정보 (그룹).
     */
    public BoardGroupVO selectBoardGroupOne4Used(String param) {
        return sqlSession.selectOne("selectBoardGroupOne4Used", param);
    }
    
    /** ------------------------------------------
     * 게시판.
     */
    public Integer selectBoardCount(BoardSearchVO param) {
        return sqlSession.selectOne("selectBoardCount", param);
    }
    
    public List<?> selectBoardList(BoardSearchVO param) {
        return sqlSession.selectList("selectBoardList", param);
    }
    
    public List<?> selectNoticeList(BoardSearchVO param) {
        return sqlSession.selectList("selectNoticeList", param);
    }
    
    /**
     * 글 저장.
     */
    public void insertBoard(BoardVO param, List<FileVO> filelist, String[] fileno) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getBrdno() == null || "".equals(param.getBrdno())) {
                 sqlSession.insert("insertBoard", param);
            } else {
                sqlSession.update("updateBoard", param);
            }
            
            if (fileno != null) {
                HashMap<String, String[]> fparam = new HashMap<String, String[]>();
                fparam.put("fileno", fileno);
                sqlSession.insert("deleteBoardFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                sqlSession.insert("insertBoardFile", f);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertBoard");
        }            
    }
 
    public BoardVO selectBoardOne(Field3VO param) {
        return sqlSession.selectOne("selectBoardOne", param);
    }

    /**
     * 게시판 수정/삭제 권한 확인. 
     */
    public String selectBoardAuthChk(BoardVO param) {
        return sqlSession.selectOne("selectBoardAuthChk", param);
    }
    
    public void updateBoardRead(Field3VO param) {
        sqlSession.insert("updateBoardRead", param);
    }
    
    public void deleteBoardOne(String param) {
        sqlSession.delete("deleteBoardOne", param);
    }

    /**
     * 좋아요저장.     
     */
    public void insertBoardLike(Field3VO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            sqlSession.insert("insertBoardLike", param);
            sqlSession.update("updateBoard4Like", param);
            
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertBoardLike");
        }            
    }

    public List<?> selectBoardFileList(String param) {
        return sqlSession.selectList("selectBoardFileList", param);
    }
    
    /* =============================================================== */
    public List<?> selectBoardReplyList(String param) {
        return sqlSession.selectList("selectBoardReplyList", param);
    }
    
    /**
     * 댓글 저장. 
     */
    public BoardReplyVO insertBoardReply(BoardReplyVO param) {
        if (param.getReno() == null || "".equals(param.getReno())) {
            if (param.getReparent() != null) {
                BoardReplyVO replyInfo = sqlSession.selectOne("selectBoardReplyParent", param.getReparent());
                param.setRedepth(replyInfo.getRedepth());
                param.setReorder(replyInfo.getReorder() + 1);
                sqlSession.selectOne("updateBoardReplyOrder", replyInfo);
            } else {
                Integer reorder = sqlSession.selectOne("selectBoardReplyMaxOrder", param.getBrdno());
                param.setReorder(reorder);
            }
            
            sqlSession.insert("insertBoardReply", param);
        } else {
            sqlSession.insert("updateBoardReply", param);
        }
        return sqlSession.selectOne("selectBoardReplyOne", param.getReno());
    }   
    
    /**
     * 댓글 수정/삭제 권한 확인. 
     */
    public String selectBoardReplyAuthChk(BoardReplyVO param) {
        return sqlSession.selectOne("selectBoardReplyAuthChk", param);
    }
    
    /**
     * 댓글 삭제.
     * 자식 댓글이 있으면 삭제 안됨. 
     */
    public boolean deleteBoardReply(String param) {
        Integer cnt = sqlSession.selectOne("selectBoardReplyChild", param);
        
        if ( cnt > 0) {
            return false;
        }
        
        sqlSession.update("updateBoardReplyOrder4Delete", param);
        
        sqlSession.delete("deleteBoardReply", param);
        
        return true;
    }    
}
