package com.codegym.demoservlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="servletLifeCycle", urlPatterns = "/servletlifecycle")
public class ServletLifeCycle extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Chay vao ham doGet");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Chay vao ham doPost");
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.service(req, resp);
        System.out.println("Chay vao ham service với method: " + req.getMethod());
    }

    @Override
    public void init() throws ServletException {
        System.out.println("Chay vao ham khoi tao");
    }

    @Override
    public void destroy() {
        System.out.println("Servlet bi huy roi");
    }
}
