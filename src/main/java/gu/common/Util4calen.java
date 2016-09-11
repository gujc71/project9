package gu.common;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Util4calen {
    static final Logger LOGGER = LoggerFactory.getLogger(AdminInterceptor.class);
    static final String[] dayArr = {"일", "월", "화", "수", "목", "금", "토"};
    
    /**
     * 시스템의 오늘 일자 반. 
     */
    public static Date getToday() {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( new Date() );
        return cal.getTime();
    }    

    /**
     * 문자열을 날짜형으로 변환.
     */
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
     *  문자열을 날짜(yyyy-MM-dd)로 변환.
     */
    public static Date str2Date(String date) {
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
        Date ret = null;
        try {
            ret = ft.parse( date ) ;
        } catch (ParseException ex) {
            LOGGER.error("date parse error ");
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
    
    /**
     * 년도 추출.
     */
    public static Integer getYear(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );

        return cal.get(Calendar.YEAR);
    }
    
    /**
     * 월 추출.
     */
    public static Integer getMonth(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );

        return cal.get(Calendar.MONTH) + 1;
    }

    /**
     * 한 주의 순서 (요일).
     * 예: 일요일 = 0
     */
    public static Integer getDayOfWeek(Date date) {
        Calendar cal = Calendar.getInstance(); 
        cal.setTime( date );
        return cal.get(Calendar.DAY_OF_WEEK) - 1;    
    }
    
    /**
     * 월의 몇 번째 주 인지 추출.
     * 예: 반환값이 4이면 (7월) 4번째 주
     */
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
