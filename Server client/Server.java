import java.io.*;
import java.net.*;

public class Server {

    public static void main(String[] args) {

        try {
            ServerSocket serverSocket = new ServerSocket(5000);

            System.out.println("Server Started...");
            System.out.println("Waiting for client...");

            Socket socket = serverSocket.accept();

            System.out.println("Client Connected!");

            BufferedReader input = new BufferedReader(
                    new InputStreamReader(socket.getInputStream()));

            PrintWriter output = new PrintWriter(
                    socket.getOutputStream(), true);

            // Receive message from Client
            String message = input.readLine();

            System.out.println("Client says: " + message);

            // Send reply to Client
            output.println("Hello Client, message received!");

            socket.close();
            serverSocket.close();

            System.out.println("Connection Closed.");

        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}