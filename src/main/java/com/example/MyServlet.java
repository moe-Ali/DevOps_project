package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;

public class MyServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String message = StringUtils.defaultIfBlank(System.getProperty("my-message"), "Hello, From Mohamed Ali! DevOps Porject!!");
    response.setContentType("text/html");
    response.getWriter().println("<html><body><h1>" + message + "</h1></body></html>");
  }
}