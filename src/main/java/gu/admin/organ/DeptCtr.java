package gu.admin.organ;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.common.TreeMaker;
import gu.common.UtilEtc;
import gu.etc.EtcSvc;

@Controller
public class DeptCtr {

    @Autowired
    private DeptSvc deptSvc;
    
    @Autowired
    private EtcSvc etcSvc;
    
    /**
     * 리스트.
     */
    @RequestMapping(value = "/adDepartment")
       public String department(HttpServletRequest request, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        
        Integer alertcount = etcSvc.selectAlertCount(userno);
        modelMap.addAttribute("alertcount", alertcount);
        
        List<?> listview   = deptSvc.selectDepartment();

        TreeMaker tm = new TreeMaker();
        String treeStr = tm.makeTreeByHierarchy(listview);
        
        modelMap.addAttribute("treeStr", treeStr);
        
        return "admin/organ/Department";
    }
    
    /**
     * 부서 등록.
     */
    @RequestMapping(value = "/adDepartmentSave")
       public void departmentSave(HttpServletResponse response, DepartmentVO deptInfo) {
        
        deptSvc.insertDepartment(deptInfo);
        
        UtilEtc.responseJsonValue(response, deptInfo);
    }

    /**
     * 부서 정보(하나).
     */ 
    @RequestMapping(value = "/adDepartmentRead")
       public void departmentRead(HttpServletRequest request, HttpServletResponse response) {
        
        String deptno = request.getParameter("deptno");
        
        DepartmentVO deptInfo = deptSvc.selectDepartmentOne(deptno);
        
        UtilEtc.responseJsonValue(response, deptInfo);
    }
    
    /**
     * 부서 삭제.
     */
    @RequestMapping(value = "/adDepartmentDelete")
       public void departmentDelete(HttpServletRequest request, HttpServletResponse response) {
        
        String deptno = request.getParameter("deptno");
        
        deptSvc.deleteDepartment(deptno);
        
        UtilEtc.responseJsonValue(response, "OK");
    }

}
