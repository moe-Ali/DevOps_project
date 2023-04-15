import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class MyServletTest {

    @Test
    public void testDoGet() throws ServletException, IOException {
        HttpServletRequest request = Mockito.mock(HttpServletRequest.class);
        HttpServletResponse response = Mockito.mock(HttpServletResponse.class);
        StringWriter stringWriter = new StringWriter();
        PrintWriter writer = new PrintWriter(stringWriter);
        Mockito.when(response.getWriter()).thenReturn(writer);

        new MyServlet().doGet(request, response);

        writer.flush();
        String result = stringWriter.toString();
        assertEquals("<html><body><h1>Hello, From Mohamed Ali! DevOps Porject!</h1></body></html>", result.trim());
        Mockito.verify(response).setContentType("text/html");
    }
}