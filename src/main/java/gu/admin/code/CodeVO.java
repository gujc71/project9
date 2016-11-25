package gu.admin.code;

public class CodeVO {

    private String   classno		// 대분류
    				, codecd		// 코드
    				, codenm;		// 코드명

	public String getClassno() {
		return classno;
	}

	public void setClassno(String classno) {
		this.classno = classno;
	}

	public String getCodecd() {
		return codecd;
	}

	public void setCodecd(String codecd) {
		this.codecd = codecd;
	}

	public String getCodenm() {
		return codenm;
	}

	public void setCodenm(String codenm) {
		this.codenm = codenm;
	}
    
}
