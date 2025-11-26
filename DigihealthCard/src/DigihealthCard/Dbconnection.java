package main_project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dbconnection {

		public static Connection con=null;
		public static Connection connect(){
			try{
				Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Driver loaded");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3308/healthcarddb","root","");
				System.out.println("Connection Established");
			}
			catch(ClassNotFoundException e){
				e.printStackTrace();
			}
			catch(SQLException e){
				e.printStackTrace();
			}
			return(con);
		}

	}
