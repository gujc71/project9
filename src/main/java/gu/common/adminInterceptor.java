package gu.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class adminInterceptor implements HandlerInterceptor {
	
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) {
        HttpSession session = req.getSession();
        
        try {
            if(session==null || session.getAttribute("userno") == null){
                res.sendRedirect("memberLogin"); 
                return false;
            }
            if(!"A".equals(session.getAttribute("userrole"))){
                res.sendRedirect("noAuthMessage"); 
                return false;
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        return true;
	}
	
	public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView mv) {
	}
	
	public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex) {
	}

}
