package com.phuxuan.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.phuxuan.dao.CountryDAO;
import com.phuxuan.dao.ICountryDAO;
import com.phuxuan.dao.UserDAO;
import com.phuxuan.model.Country;
import com.phuxuan.model.User;

@WebServlet(name = "UserServlet", urlPatterns = "/users")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private ICountryDAO iCountryDAO;
    
    public void init() {
        userDAO = new UserDAO();
        iCountryDAO = new CountryDAO();
        
        if(this.getServletContext().getAttribute("listCountry")==null) {
        	this.getServletContext().setAttribute("listCountry", iCountryDAO.selectAllCountry());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "create":
                    insertUser(request, response);
                    break;
                case "edit":
                    updateUser(request, response);
                    break;
                case "createupload":
                    insertUserUpload(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }



    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        System.out.println("Server real path: " + this.getServletContext().getRealPath("/"));
        try {
            switch (action) {
                case "create":
                    showNewForm(request, response);
                    break;
                case "createupload":
                    showNewFormUpload(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                default:
                    //listUser(request, response);
                    listUserPagging(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }



    private void listUserPagging(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 3;
        String q = "";
        int idcountry = -1;

        if(request.getParameter("q")!=null){
            System.out.println("aaaaaaaaaa");
            q = request.getParameter("q");
        }
        if(request.getParameter("idcountry")!=null){
            idcountry = Integer.parseInt(request.getParameter("idcountry"));
        }



        if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page"));

        List<User> listUser = userDAO.selectUsersPagging((page-1)*recordsPerPage, recordsPerPage, q, idcountry);
        int noOfRecords = userDAO.getNoOfRecords();

        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        request.setAttribute("listUser", listUser);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);

        request.setAttribute("q", q);
        request.setAttribute("idcountry", idcountry);
        RequestDispatcher view = request.getRequestDispatcher("user/list_paging.jsp");
        view.forward(request, response);
    }

    private void listUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<User> listUser = userDAO.selectAllUsers();
        request.setAttribute("listUser", listUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/list.jsp");
        dispatcher.forward(request, response);
    }


    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	List<Country> listCountry = iCountryDAO.selectAllCountry();
    	
    	request.setAttribute("listCountry", listCountry);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/create.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewFormUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("Server path: " + this.getServletContext().getRealPath("/"));
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/create_upload.jsp");
        dispatcher.forward(request, response);


    }
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User existingUser = userDAO.selectUser(id);
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/edit.jsp");
        request.setAttribute("user", existingUser);
        dispatcher.forward(request, response);

    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int idcountry = Integer.parseInt(request.getParameter("idcountry"));
        
        
        User newUser = new User(name, email, idcountry);
        userDAO.insertUser(newUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/create.jsp");
        dispatcher.forward(request, response);
    }
    private void insertUserUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int idcountry = Integer.parseInt(request.getParameter("idcountry"));
        User newUser = new User(name, email, idcountry);



        for (Part part : request.getParts()) {
            System.out.println("Content type of Part" + part.getContentType());
            System.out.println("Name of Part" + part.getName());
            if(part.getName().equals("file")){
                String fileName = extractFileName(part);
                // refines the fileName in case it is an absolute path
                fileName = new File(fileName).getName();


                //part.write(this.getFolderUpload().getAbsolutePath() + File.separator + fileName);

                part.write("D:\\CODEGYM\\C0322G1\\c3_paggingfilter\\src\\main\\webapp\\images\\" + fileName);
                String servletRealPath = this.getServletContext().getRealPath("/") + "\\images\\" + fileName;
                System.out.println("servletRealPath: " + servletRealPath);
                part.write(servletRealPath);
                newUser.setUrlImage("images\\" + fileName);

            }

        }

        userDAO.insertUser(newUser);

        //request.setAttribute("message", "Upload File Success!");
        //getServletContext().getRequestDispatcher("user/create_upload.jsp").forward(request, response);

        RequestDispatcher dispatcher = request.getRequestDispatcher("user/create_upload.jsp");
        dispatcher.forward(request, response);
    }
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
    public File getFolderUpload() {
        File folderUpload = new File(System.getProperty("user.home") + "/Uploads");
        System.out.println(System.getProperty("user.home") + "/Uploads");
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int idcountry = Integer.parseInt(request.getParameter("idcountry"));

        User book = new User(id, name, email, idcountry);
        userDAO.updateUser(book);
		/*
		 * RequestDispatcher dispatcher = request.getRequestDispatcher("user/edit.jsp");
		 * dispatcher.forward(request, response);
		 */
        response.sendRedirect("/users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);

        List<User> listUser = userDAO.selectAllUsers();
        request.setAttribute("listUser", listUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/list.jsp");
        dispatcher.forward(request, response);
    }
}
