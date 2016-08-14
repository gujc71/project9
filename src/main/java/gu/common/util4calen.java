package gu.common;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

//@SuppressWarnings("static-access")

public class util4calen{
	private static SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
	private static Calendar calendar = Calendar.getInstance();
	final private static String[] DayArr = {"일", "월", "화", "수", "목", "금", "토"};
	
	//public util4calen(){}
	
	public static void setToday(){
		calendar.setTime( new Date() );
	}
	public static void setToday(String date) {
		calendar.setTime( Str2Date( date ) );
	}
	public static Date getToday() {
		setToday();
		return calendar.getTime();
	}	
	
	/**
     *  날짜를 문자열로 변환.
     */
    public static String Date2Str(Date date){
        return ft.format( date.getTime() );    
    }
    /**
     *  문자열을 날짜로 변환.
     */
    public static Date Str2Date(String date) {
        Date ret = null;
        try {
            ret = ft.parse( date ) ;
        } catch (ParseException e) {
            System.out.println("date parse error ");
        }
        return ret ;
    }
    /**
     *  날짜를 년월일로 구분하여 저장.
     */
    public static DateVO Date2VO(Date date){
        calendar.setTime( date );
        DateVO dvo = new DateVO();
        dvo.setYear( calendar.get(Calendar.YEAR) );
        dvo.setMonth(calendar.get(Calendar.MONTH)+1 );
        dvo.setDay(  calendar.get(Calendar.DAY_OF_MONTH) );
        dvo.setWeek( DayArr[ calendar.get(Calendar.DAY_OF_WEEK)-1] );
        return dvo;    
    }
    
	public static String getYear() {
		setToday();
		return Integer.toString(calendar.get(Calendar.YEAR));
	}
   public static Integer getMonth(String date){
        setToday(date);
        return calendar.get(Calendar.MONTH)+1;    
    }

    public static Integer getMonth(){
        return calendar.get(Calendar.MONTH)+1;    
    }
    
	public static String getFirstOfYear(){
		return calendar.get(Calendar.YEAR)+"-01-01";    
	}
	
	public static Integer getDayOfWeek(String date) {
		setToday(date);
		return calendar.get(Calendar.DAY_OF_WEEK)-1;    
	}
	
	public static Integer getWeekOfMonth(String date){
		setToday(date);
		return calendar.get(Calendar.WEEK_OF_MONTH);    
	}
	
    public static Integer getWeekOfMonth(){
        return calendar.get(Calendar.WEEK_OF_MONTH);    
    }
	
	public static String getWeekString(Integer idx){
		return DayArr[idx];    
	}
	
	/**
	 *  getFirstOfWeek + getLastOfWeek 한 세트
	 *  한주의 시작일: 일요일 0 ~
	 */
	/*public static String getFirstOfWeek(){
		Integer dw = calendar.get(Calendar.DAY_OF_WEEK)-1;
		calendar.add(Calendar.DATE, dw * -1);
		return ft.format( calendar.getTime() );    
	}*/
	
    public static Date getFirstOfWeek(){
        Integer dw = calendar.get(Calendar.DAY_OF_WEEK)-1;
        calendar.add(Calendar.DATE, dw * -1);
        return calendar.getTime();    
    }
    /**
     *  getFirstOfWeek + getLastOfWeek 한 세트
     *  한주의 종료일: ~ 토요일 6
     * @param init : 오늘 날짜 지정 여부
     */
	/*public static String getLastOfWeek(boolean init){				
		if (init) setToday();
		
		calendar.add(Calendar.DATE, 6);
		return ft.format( calendar.getTime());		
	}*/
    public static Date getLastOfWeek(){               
        calendar.add(Calendar.DATE, 6);
        return calendar.getTime();      
    }

    /**
     *  월의 시작일
     */
	public static String getFirstOfMonth(){
		String str = ft.format( calendar.getTime() );
		
		return str.substring(0, 8)+"01";    
	}

	/**
	 *  월의 마지막일
	 * @param init : 오늘 날짜 지정 여부
	 */
	public static String getLastOfMonth(boolean init){	 
		if (init) setToday();

		calendar.setTime( Str2Date( calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH)+2) + "-01" ) );

		calendar.add(Calendar.DATE, -1);
		return ft.format( calendar.getTime() );
		 
	}	

	/**  
	 * 두 날짜(date1,date2)의 일수: 1~7의 일수는 7이기때문에 +1
	 */
	public static Integer DateDiff(String date1, String date2) throws ParseException{ 
		Date dt1 = ft.parse( date1 );
		Date dt2 = ft.parse( date2 );
		
		return  (int) ( (dt1.getTime()-dt2.getTime()) / (24 * 60 * 60 * 1000) ) + 1;
	}	

	/** 
	 * 날자 계산: -1은 감소
	 */
	public static Date DateAdd(Date date, Integer calDay){ 
	    calendar.setTime(date);
		calendar.add(Calendar.DATE, calDay);  
		
		return  calendar.getTime();
	}	
	
    /** 
     * 달 계산: -1은 감소
     */
	public static Date MonthAdd(Date date, Integer month){ 
        calendar.setTime(date);
		calendar.add(Calendar.MONTH, month); 
		
		return calendar.getTime();
	}	
	
}
