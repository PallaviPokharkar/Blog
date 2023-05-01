package com.tech.blog.helper;
import java.sql.*;

public class ConnectionProvider 
{
	private static Connection con;
	public static Connection getConnection()
	{
		try {
		
			if(con==null) //when someone call getConnection() if con dont have value then it will create connectin if have then it will return connection
			{
				//driver class load
				Class.forName("com.mysql.jdbc.Driver");
				
				//create a connection... 
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/TechBlog","root","root");
				
				
			}
			
		}catch(Exception e) 
		{
			e.printStackTrace();
		}
		return con;
	}
	
	
}
