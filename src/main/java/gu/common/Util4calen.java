package gu.common;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@SuppressWarnings("static-access")

public class Util4calen {
    final static String[] dayArr = {"일", "월", "화", "수", "목", "금", "토"};
    
    public static Date getToday() {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( new Date() );
        return cal.getTime();
    }    

    public static Date getToday(String date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( str2Date(date) );
        return cal.getTime();
    }   
    
    /**
     *  날짜를 문자열로 변환.
     */
    public static String date2Str(Date date) {
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
        return ft.format( date.getTime() );    
    }
    
    /**
     *  문자열을 날짜로 변환.
     */
    public static Date str2Date(String date) {
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
        Date ret = null;
        try {
            ret = ft.parse( date ) ;
        } catch (ParseException ex) {
            System.out.println("date parse error ");
        }
        return ret ;
    }
    
    /**
     *  날짜를 년월일로 구분하여 저장.
     */
    public static DateVO date2VO(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );
        
        DateVO dvo = new DateVO();
        dvo.setYear( cal.get(Calendar.YEAR) );
        dvo.setMonth(cal.get(Calendar.MONTH) + 1 );
        dvo.setDay(  cal.get(Calendar.DAY_OF_MONTH) );
        dvo.setWeek( dayArr[ cal.get(Calendar.DAY_OF_WEEK) - 1] );
        return dvo;    
    }
    
    public static Integer getYear(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );

        return cal.get(Calendar.YEAR);
    }
    
    public static Integer getMonth(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );

        return cal.get(Calendar.MONTH) + 1;
    }

    public static Integer getDayOfWeek(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );
        return cal.get(Calendar.DAY_OF_WEEK) - 1;    
    }
    
    public static Integer getWeekOfMonth(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );
        return cal.get(Calendar.WEEK_OF_MONTH);    
    }
    
    public static String getWeekString(Integer idx) {
        return dayArr[idx];    
    }
    
    /**
     *  한주의 시작일자.
     */
    
    public static Date getFirstOfWeek(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime( date );
        Integer dw = cal.get(Calendar.DAY_OF_WEEK) - 1;
        cal.add(Calendar.DATE, dw * -1);
        return cal.getTime();    
    }
    
    /**
     *  한주의 종료일자.
     */
    public static Date getLastOfWeek(Date date) {               
        Calendar cal = Calendar.getInstance();
        cal.setTime( date );
        Integer dw = cal.get(Calendar.DAY_OF_WEEK);
        cal.add(Calendar.DATE, 7 - dw);
        return cal.getTime();    
    }

    /**
     *  월의 시작일.
     */
    public static Date getFirstOfMonth() {
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
        
        String str = ft.format( Calendar.getInstance().getTime() );
        
        return str2Date(str.substring(0, 8) + "01");    
    }

    /**  
     * 두 날짜(date1,date2)의 일수: 시간 포함해서 계산하면 오류가 있어 날짜만 추출해서 계산.
     */
    public static Integer dateDiff(Date date1, Date date2) {
        String dt1 = date2Str(date1);
        String dt2 = date2Str(date2);

        Integer day = (int) ( (str2Date(dt1).getTime() - str2Date(dt2).getTime()) / (24 * 60 * 60 * 1000) );
        return day;
    }    

    /** 
     * 날자 계산: -1은 감소.
     */
    public static Date dateAdd(Date date, Integer calDay) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime(date);
        cal.add(Calendar.DATE, calDay);  
        
        return cal.getTime();
    }    
    
    /** 
     * 달 계산: -1은 감소.
     */
    public static Date monthAdd(Date date, Integer month) { 
        Calendar cal = Calendar.getInstance(); 
        cal.setTime(date);
        cal.add(Calendar.MONTH, month); 
        
        return cal.getTime();
    }    
    
}
