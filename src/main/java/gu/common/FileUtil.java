package gu.common;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileUtil {
    static final Logger LOGGER = LoggerFactory.getLogger(AdminInterceptor.class);
    static final Integer IMG_WIDTH = 100;
    static final Integer IMG_HEIGHT = 100;
    
    /**
     * 파일 업로드.
     */
    public FileVO saveFile(MultipartFile uploadfile) {
        if (uploadfile == null || uploadfile.getSize()  ==  0) {
           return null;
        }
            
        String filePath = LocaleMessage.getMessage("info.filePath");
        String newName = getNewName();
        filePath = getRealPath(filePath, newName);

        saveFileOne(uploadfile, filePath, newName);
            
        FileVO filedo = new FileVO();
        filedo.setFilename(uploadfile.getOriginalFilename());
        filedo.setRealname(newName);
        filedo.setFilesize(uploadfile.getSize());

        return filedo;
    }    
    
    /**
     * 멀티 파일 업로드.
     */
    public List<FileVO> saveAllFiles(List<MultipartFile> upfiles) {
        List<FileVO> filelist = new ArrayList<FileVO>();
        String filePath = LocaleMessage.getMessage("info.filePath");

        for (MultipartFile uploadfile : upfiles ) {
            if (uploadfile.getSize() == 0) {
                continue;
            }
            
            String newName = getNewName();
            
            saveFileOne(uploadfile, getRealPath(filePath, newName), newName);
            
            FileVO filedo = new FileVO();
            filedo.setFilename(uploadfile.getOriginalFilename());
            filedo.setRealname(newName);
            filedo.setFilesize(uploadfile.getSize());
            filelist.add(filedo);
        }
        return filelist;
    }     

    /**
     * 실제 파일 저장.
     */
    public static String saveFileOne(MultipartFile file, String basePath, String fileName) {
        if (file  ==  null || file.getName().equals("") || file.getSize() < 1) {
            return null;
        }
     
        makeBasePath(basePath);
        String serverFullPath = basePath + fileName;
  
        File file1 = new File(serverFullPath);
        try {
            file.transferTo(file1);
        } catch (IOException ex) {
            LOGGER.error("IOException");
        }
        
        return serverFullPath;
    }
    
    /**
     * 이미지 파일 업로드 및 resize.
     */
    public FileVO saveImage(MultipartFile file) {
        if (file  ==  null || file.getName().equals("") || file.getSize() < 1) {
            return null;
        }
    
        String filePath = LocaleMessage.getMessage("info.filePath");
        String newName = getNewName();
        String basePath = getRealPath(filePath, newName);
        String serverFullPath = basePath + newName;
        String ext = getFileExtension(file.getOriginalFilename());
        makeBasePath(basePath);

        File file1 = new File(serverFullPath);
        try {
            file.transferTo(file1);
            BufferedImage srcImage = ImageIO.read(file1);
            int type = srcImage.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : srcImage.getType();
            if (srcImage.getWidth() > IMG_WIDTH && srcImage.getHeight() > IMG_HEIGHT ) {
                BufferedImage resizeImageJpg = resizeImage(srcImage, type);
                ImageIO.write(resizeImageJpg, ext, new File(serverFullPath + "1"));
                newName += "1";
                file1.delete();
            }
        } catch (IOException ex) {
            LOGGER.error("IOException:saveImage");
        }
       
        FileVO filedo = new FileVO();
        filedo.setFilename(file.getOriginalFilename());
        filedo.setRealname(newName);
        filedo.setFilesize(file.getSize());

        return filedo;
    }   
   
    private static BufferedImage resizeImage(BufferedImage srcImage, int type) {
        BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
        Graphics2D g2 = resizedImage.createGraphics();
        g2.drawImage(srcImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
        g2.dispose();

        return resizedImage;
    }

    /**
     * 파일 저장 경로 생성.
     */
    public static void makeBasePath(String path) {
        File dir = new File(path); 
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }
    
    /**
     * 날짜로 새로운 파일명 부여.
     */
    public static String getNewName() {
        SimpleDateFormat ft = new SimpleDateFormat("yyyyMMddhhmmssSSS");
        return ft.format(new Date()) + (int) (Math.random() * 10);
    }
    
    public String getFileExtension(String filename) {
          Integer mid = filename.lastIndexOf(".");
          return filename.substring(mid + 1, filename.length());
    }

    public String getRealPath(String path, String filename) {
        return path + filename.substring(0,4) + "/";
    }
}
