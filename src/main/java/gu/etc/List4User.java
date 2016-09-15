package gu.etc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.board.BoardSearchVO;

@Controller
public class List4User {

    @Autowired
    private EtcSvc etcSvc;
    
    /**
     * alert 리스트 전체.
     */
    @RequestMapping(value = "/list4User")
    public String list4User(HttpServletRequest request, BoardSearchVO searchVO, ModelMap modelMap) {
        String userno = request.getParameter("userno");
        searchVO.setSearchExt1(userno);
        
        searchVO.pageCalculate( etcSvc.selectList4UserCount(searchVO) ); // startRow, endRow
        
        List<?> listview   = etcSvc.selectList4User(searchVO);

        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "etc/list4User";
    }

    
}
