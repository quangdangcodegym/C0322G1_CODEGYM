//package com.codegym.save;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//public class MySession extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println("Session id of server: " + req.getSession().getId());
//        System.out.println("Session id of request: " + req.getRequestedSessionId());
//
//        Cookie cookieUser = new Cookie("user", req.getParameter("user"));
//        Cookie cookiePassword = new Cookie("password", req.getParameter("password"));
//
//
//
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);
//    }
//}
