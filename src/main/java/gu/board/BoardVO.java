package gu.board;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

public class BoardVO {

    private String bgno;
    private String bgname;
    private String brdno;
    private String brdtitle; 
    private String brdwriter; 
    private String brdmemo; 
    private String brddate; 
    private String brdhit;  
    private String brddeleteflag; 
    private String filecnt;
    private String replycnt;
    private String userno;
    private String brdnotice;
    private String brdlike;
    private String brdlikechk;          // like button click check
    private String extfield1;           // etc
    
    /* 첨부파일 */
    private List<MultipartFile> uploadfile;

    public String getBgno() { 
        return bgno;
    }

    public void setBgno(String bgno) {
        this.bgno = bgno;
    }

    public String getBgname() {
        return bgname;
    }

    public void setBgname(String bgname) {
        this.bgname = bgname;
    }

    public String getBrdno() {
        return brdno;
    }

    public void setBrdno(String brdno) {
        this.brdno = brdno;
    }

    public String getBrdtitle() {
        return brdtitle; 
    }

    public void setBrdtitle(String brdtitle) {
        this.brdtitle = brdtitle;
    }

    public String getBrdwriter() {
        return brdwriter;
    }

    public void setBrdwriter(String brdwriter) {
        this.brdwriter = brdwriter;
    }

    public String getBrdmemo() {
        return brdmemo.replaceAll("(?i)<script", "&lt;script");
    }

    public void setBrdmemo(String brdmemo) {
        this.brdmemo = brdmemo;
    }

    public String getBrddate() {
        return brddate;
    }

    public void setBrddate(String brddate) {
        this.brddate = brddate;
    }

    public String getBrdhit() {
        return brdhit;
    }

    public void setBrdhit(String brdhit) {
        this.brdhit = brdhit;
    }

    public String getBrddeleteflag() {
        return brddeleteflag;
    }

    public void setBrddeleteflag(String brddeleteflag) {
        this.brddeleteflag = brddeleteflag;
    }

    public List<MultipartFile> getUploadfile() {
        return uploadfile;
    }

    public void setUploadfile(List<MultipartFile> uploadfile) {
        this.uploadfile = uploadfile;
    }

    public String getFilecnt() {
        return filecnt;
    }

    public void setFilecnt(String filecnt) {
        this.filecnt = filecnt;
    }

    public String getReplycnt() {
        return replycnt;
    }

    public void setReplycnt(String replycnt) {
        this.replycnt = replycnt;
    }

    public String getUserno() {
        return userno;
    }

    public void setUserno(String userno) {
        this.userno = userno;
    }

    public String getBrdnotice() {
        return brdnotice;
    }

    public void setBrdnotice(String brdnotice) {
        this.brdnotice = brdnotice;
    }

    public String getBrdlike() {
        return brdlike;
    }

    public void setBrdlike(String brdlike) {
        this.brdlike = brdlike;
    }

    public String getBrdlikechk() {
        return brdlikechk;
    }

    public void setBrdlikechk(String brdlikechk) {
        this.brdlikechk = brdlikechk;
    }

    public String getExtfield1() {
        return extfield1;
    }

    public void setExtfield1(String extfield1) {
        this.extfield1 = extfield1;
    }
    
}
