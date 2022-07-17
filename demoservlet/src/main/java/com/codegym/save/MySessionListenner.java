//package com.codegym.save;
//
//import javax.servlet.ServletContext;
//import javax.servlet.annotation.WebListener;
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpSessionEvent;
//import javax.servlet.http.HttpSessionListener;
//
//@WebListener
//public class MySessionListenner implements HttpSessionListener{
//    ServletContext ctx=null;
//    static int total=0,current=0;
//
//    public void sessionCreated(HttpSessionEvent e) {
//
//        System.out.println("session created: ..............." + e.getSession().getId());
//        total++;
//        current++;
//
//        ctx=e.getSession().getServletContext();
//        ctx.setAttribute("totalusers", total);
//        ctx.setAttribute("currentusers", current);
//
//        System.out.println("Read cookie");
//        Cookie cookie = null;
//        Cookie[] cookies = null;
//
//        // Get an array of Cookies associated with this domain
//
//
//
//    }
//
//    public void sessionDestroyed(HttpSessionEvent e) {
//        current--;
//        ctx.setAttribute("currentusers",current);
//    }
//
//}