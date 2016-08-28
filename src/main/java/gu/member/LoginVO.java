package gu.member;

public class LoginVO {
    private String userid;
    private String userpw;
    private String remember;
    
    public String getUserid() {
        return userid;
    }
    
    public void setUserid(String userid) {
        this.userid = userid;
    }
    
    public String getUserpw() {
        return userpw;
    }
    
    public void setUserpw(String userpw) {
        this.userpw = userpw;
    }
    
    public String getRemember() {
        return remember;
    }
    
    public void setRemember(String remember) {
        this.remember = remember;
    }

}
