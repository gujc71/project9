package gu.main;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.common.DateVO;
import gu.common.util4calen;


@Controller 
public class IndexCtr {
    @Autowired
    private IndexSvc indexSvc;
    
    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();

        Date today = util4calen.getToday(); 

        calCalen(today, modelMap);
        
        List<?> listview = indexSvc.selectRecentNews();
        List<?> listtime = indexSvc.selectTimeLine(userno);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("listtime", listtime);

        return "main/index";
    }
    
    @RequestMapping(value = "/moveDate")
    public String moveDate(HttpServletRequest request, ModelMap modelMap) {
        String date = request.getParameter("date");

        Date today = util4calen.getToday();
        util4calen.setToday(date);
        
        calCalen(today, modelMap);
        
        return "main/indexCalen";
    }
    
   private String calCalen(Date today, ModelMap modelMap) {
        List<DateVO> calenList = new ArrayList<DateVO>();
        int month = util4calen.getMonth();
        int week = util4calen.getWeekOfMonth();
        
        Date fweek = util4calen.getFirstOfWeek();
        Date lweek = util4calen.getLastOfWeek();
        Date preWeek = util4calen.DateAdd(fweek, -1);
        Date nextWeek = util4calen.DateAdd(lweek, 1);
        
        while (fweek.compareTo(lweek) <= 0) {
            DateVO dvo = util4calen.Date2VO(fweek);
            dvo.setIstoday(fweek.compareTo(today)==0);
            calenList.add(dvo);
            
            fweek = util4calen.DateAdd(fweek, 1);
        }
        
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("week", week);
        modelMap.addAttribute("calenList", calenList);
        modelMap.addAttribute("preWeek", util4calen.Date2Str(preWeek));
        modelMap.addAttribute("nextWeek", util4calen.Date2Str(nextWeek));

        return "main/index";
    }
    
    @RequestMapping(value = "/sample1")
    public String sample1() {
        
        return "main/sample1";
    }

}
