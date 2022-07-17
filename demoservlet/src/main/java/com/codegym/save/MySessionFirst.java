//package com.codegym.save;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//
//import javax.servlet.ServletContext;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//@WebServlet(name = "MySessionFirst", urlPatterns = "/sessionfirst")
//public class MySessionFirst extends HttpServlet {
//    public void doGet(HttpServletRequest request,
//                      HttpServletResponse response)
//            throws ServletException, IOException {
//
//        System.out.println("My session servlet in request : " + request.getRequestedSessionId());
//        System.out.println("My session servlet in server getSession(): " + request.getSession().getId());
//        response.setContentType("text/html");
//        PrintWriter out = response.getWriter();
//
//        Cookie firstName = new Cookie("first_name",
//                request.getParameter("first_name"));
//        Cookie lastName = new Cookie("last_name",
//                request.getParameter("last_name"));
//
//        // Set expiry date after 24 Hrs for both the cookies.
//        firstName.setMaxAge(60 * 60 * 24);
//        lastName.setMaxAge(60 * 60 * 24);
//
//        // Add both the cookies in the response header.
//        response.addCookie(firstName);
//        response.addCookie(lastName);
//
//        String n=request.getParameter("username");
//        out.print("Welcome "+n);
//
//        HttpSession session=request.getSession();
//        session.setAttribute("uname",n);
//
//        //retrieving data from ServletContext object
//        ServletContext ctx=getServletContext();
//        int t=(Integer)ctx.getAttribute("totalusers");
//        int c=(Integer)ctx.getAttribute("currentusers");
//        out.print("<br>total users= "+t);
//        out.print("<br>current users= "+c);
//
//        out.print("<br><a href='logout'>logout</a>");
//
//        out.close();
//    }
//
//}