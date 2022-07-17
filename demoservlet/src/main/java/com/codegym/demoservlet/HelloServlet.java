package com.codegym.demoservlet;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "helloServlet", urlPatterns = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

//        System.out.println("My session servlet in request : " + request.getRequestedSessionId());
//        System.out.println("My session servlet in server getSession(): " + request.getSession().getId());
        // Hello
        System.out.println("Hello servlet: doGET");
        String username = "";
        String password = "";
        if(request.getParameter("user")!=null){
            username = request.getParameter("user");
            Cookie user = new Cookie("user",
                    request.getParameter("user"));
            user.setMaxAge(60*60*24);
            response.addCookie(user);
        }
        if(request.getParameter("pass")!=null){
            password = request.getParameter("pass");
            Cookie pass = new Cookie("pass",
                    request.getParameter("pass"));
            pass.setMaxAge(60 * 60 * 24);
            response.addCookie(pass);
        }




        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1> Username: " + username + " password: " + password+ "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}