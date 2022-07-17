package com.codegym.sessioncookie;


import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = "/*")
public class MyFilterCookie implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        System.out.println("MyFilterCookie---------------");
        System.out.println("My session servlet in request : " + request.getRequestedSessionId());
        System.out.println("My session servlet in server getSession(): " + request.getSession().getId());
        Cookie[] cookies = null;

        cookies = request.getCookies();
        if(cookies!=null){
            for (Cookie c: cookies) {
                System.out.println("Cookie Name: " + c.getName());
                System.out.println("Cookie Value " + c.getValue());
            }
        }
        chain.doFilter(req, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
