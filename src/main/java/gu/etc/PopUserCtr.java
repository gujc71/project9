package gu.etc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.admin.organ.DeptSvc;
import gu.admin.organ.UserSvc;
import gu.common.SearchVO;
import gu.common.TreeMaker;

@Controller
public class PopUserCtr {

    @Autowired
    private DeptSvc deptSvc;
    
    @Autowired
    private UserSvc userSvc;
    
    /**
     * 부서리스트.
     */
    @RequestMapping(value = "/popupDept")
       public String popupDept(ModelMap modelMap) {
        List<?> listview   = deptSvc.selectDepartment();

        TreeMaker tm = new TreeMaker();
        String treeStr = tm.makeTreeByHierarchy(listview);
        
        modelMap.addAttribute("treeStr", treeStr);
        
        return "etc/popupDept";
    }

    /**
     *  부서리스트 for 사용자.
     */
    @RequestMapping(value = "/popupUser")
    public String popupUser(ModelMap modelMap) {
        List<?> listview   = deptSvc.selectDepartment();

        TreeMaker tm = new TreeMaker();
        String treeStr = tm.makeTreeByHierarchy(listview);
        
        modelMap.addAttribute("treeStr", treeStr);
        
        return "etc/popupUser";
    }
    
    /**
     * 선택된 부서의 User 리스트.
     */
    @RequestMapping(value = "/popupUsersByDept")
    public String popupUsersByDept(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        String deptno = request.getParameter("deptno");
        searchVO.setSearchExt1(deptno);
        
        List<?> listview  = userSvc.selectUserListWithDept(searchVO);
        
        modelMap.addAttribute("listview", listview);
        
        return "etc/popupUsersByDept";
    }
    
    /**
     *  부서리스트 for 사용자들.
     */
    @RequestMapping(value = "/popupUsers")
    public String popupUsers(ModelMap modelMap) {
        popupUser(modelMap);
        
        return "etc/popupUsers";
    }

    /**
     * User 리스트  for 사용자들.
     */
    @RequestMapping(value = "/popupUsers4Users")
    public String popupUsers4Users(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        popupUsersByDept(request, searchVO, modelMap);
        
        return "etc/popupUsers4Users";
    }    
}
