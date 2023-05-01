package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		
//		fetch all data
		String userEmail= request.getParameter("user_email");
		String userName= request.getParameter("user_name");
		String userPassword= request.getParameter("user_password");
		String userAbout= request.getParameter("user_about");
		Part  part = request.getPart("img"); //it will iamge
		String imageName = part.getSubmittedFileName(); // it will fetch image with extension
		
//	 get the user from the session
		HttpSession s= request.getSession();
		User user= (User)s.getAttribute("currentUser");
		user.setEmail(userEmail);
		user.setName(userName);
		user.setAbout(userAbout);
		String oldFile=user.getProfile();
		user.setProfile(imageName);
		
//		update database.database..
		UserDao userDao =new UserDao (ConnectionProvider.getConnection());
		
		boolean ans= userDao.updateUser(user);
		if(ans) {
			
			
			String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();
			
//			delete code
			String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldFile;
			
			if(!oldFile.equals("default.png")) {
			Helper.deleteFile(pathOldFile);
			}
			
				if(Helper.saveFile(part.getInputStream(), path))
				{
					out.println("Profile updated...");
					Message msg = new Message("Profile details updated...","success","alert-success");
					s.setAttribute("msg", msg);
					
				}else {
					//// file not save successfully
					Message msg = new Message("Something wnet Wrong...","error","alert-danger");
					s.setAttribute("msg", msg);
				}
			
			
		}else {
			out.println("not updated");
			Message msg = new Message("Something wnet Wrong...","error","alert-danger");
			s.setAttribute("msg", msg);
		}
		response.sendRedirect("profile.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
