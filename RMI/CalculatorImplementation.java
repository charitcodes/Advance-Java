import java.rmi.server.UnicastRemoteObject;
import java.rmi.RemoteException;

public class CalculatorImplementation 
        extends UnicastRemoteObject 
        implements Calculator {

        CalculatorImplementation() throws RemoteException {
        super();
    }

    
    public int add(int a, int b)  {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }
}
