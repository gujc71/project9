package gu.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {
    
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) {
        //Controller 실행 요청전 
        HttpSession session = req.getSession();
        /*
        session.setAttribute("userid", "admin");
        session.setAttribute("userrole", "A");        
        session.setAttribute("userno",   "1");        
        session.setAttribute("usernm", "관리자");
        */
        try {
            if (session == null || session.getAttribute("userno") == null) {
                res.sendRedirect("memberLogin"); 
                return false;
            }
        } catch (Exception ex) {
            System.out.println("LoginInterceptor");
        }
        
        return true;
    }
    
    public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView mv) {
    }
    
    public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex) {
    }

}
