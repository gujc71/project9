package gu.etc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AlertMsgCtr {

    @Autowired
    private EtcSvc etcSvc;
    
    /**
     * alert 리스트 전체.
     */
    @RequestMapping(value = "/alertList")
       public String alertList(HttpServletRequest request, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        
        List<?> listview   = etcSvc.selectAlertList(userno);

        modelMap.addAttribute("listview", listview);
        
        return "etc/alertList";
    }

    /**
     * alert 리스트 Top 5.
     */
    @RequestMapping(value = "/alertList4Ajax")
    public String alertList4Ajax(HttpServletRequest request, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        
        List<?> listview   = etcSvc.selectAlertList4Ajax(userno);

        modelMap.addAttribute("listview", listview);
        
        return "etc/alertList4Ajax";
    }
    
}
