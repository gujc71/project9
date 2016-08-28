package gu.common;

public class DateVO {
    private int year;
    private int month;
    private int day;
    private String week;
    private boolean istoday = false;
    
    public int getYear() {
        return year;
    }
    
    public void setYear(int year) {
        this.year = year;
    }
    
    public int getMonth() {
        return month;
    }
    
    public void setMonth(int month) {
        this.month = month;
    }
    
    public int getDay() {
        return day;
    }
    
    public void setDay(int day) {
        this.day = day;
    }
    
    public String getWeek() {
        return week;
    }
    
    public void setWeek(String week) {
        this.week = week;
    }
    
    public boolean isIstoday() {
        return istoday;
    }
    
    public void setIstoday(boolean istoday) {
        this.istoday = istoday;
    }
   
   
}