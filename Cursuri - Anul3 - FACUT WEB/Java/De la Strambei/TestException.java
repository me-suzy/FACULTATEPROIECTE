/*
 * TestException.java
 *
 * Created on May 15, 2004, 9:16 AM
 */

/**
 *
 * @author  strimbeic
 */
public class TestException {
    
    /** Creates a new instance of TestException */
    public TestException() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception{
        // TODO code application logic here
        throw new MyException("Arunc ... ");
    }
    
}

class MyException extends Exception {
    public MyException(String mesaj){
        super(mesaj);
    }
    public String toString(){
        return getMessage() + " " + " din propria eroare";
    }
}