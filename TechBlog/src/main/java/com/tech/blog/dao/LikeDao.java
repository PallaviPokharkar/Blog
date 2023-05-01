package com.tech.blog.dao;
import java.sql.*;
public class LikeDao {
	Connection con;
	
	

	public LikeDao(Connection con) {

		this.con = con;
	}



	public boolean insertLike(int pid, int uid)
	{
		boolean f = false;
		try {
			String q ="insert into liked (pid, uid) values(?,?)";
			PreparedStatement p = this.con.prepareStatement(q);
			//value set...
			p.setInt(1, pid);
			p.setInt(2, uid);
			
			p.executeUpdate(); //this query doesnt give anything so we user executeUpdate
			f=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	public int countLikeOnPost(int pid)
	{
		int count=0;
		
		try {
			
			String q = "select count(*) from liked where pid=?"; // * means row it will fetch rows
			PreparedStatement p=this.con.prepareStatement(q);
			p.setInt(1, pid);
			
			ResultSet set=p.executeQuery();
			if(set.next())
			{
				count = set.getInt("count(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	//check if someone has like or not
	public boolean isLikedByUser(int pid, int uid)
	{
		boolean f = false;
		
		try {
			
			PreparedStatement p = this.con.prepareStatement("select * from liked where pid=? and uid=?");
			p.setInt(1, pid);
			p.setInt(2, uid);
			
			ResultSet set=p.executeQuery();
			if(set.next())
			{
				f=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	//for dislike
	public boolean deleteLike(int pid, int uid)
	{
		boolean f=false;
		
		try {
			PreparedStatement p =con.prepareStatement("delete from liked where pid=? and uid=?");
			p.setInt(1, pid);
			p.setInt(2, uid);
			p.executeUpdate();
			f=true;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
}
