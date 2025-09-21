/*
 * TestStudentIO.java
 *
 * Created on 26 mai 2003, 12:58
 */

package fisiere;
import java.io.*;
import javax.swing.JFileChooser;
import java.util.ArrayList;
/**
 *
 * @author  strimbeic
 */
public class TestStudentIO {
    
    public static void main(String[] args) {
        // Creez si salvez doua obiecte
        Student s1 = new Student("M001", "Primul", "Student");
        Student s2 = new Student("M002", "Al doilea", "Student");
        JFileChooser dialog = new JFileChooser();
        int result = dialog.showDialog(null, "New fisier");
        File fisier = dialog.getSelectedFile();
        /*
        try{
            fisier.createNewFile();
            FileOutputStream outStream = new FileOutputStream(fisier);
            s1.writeToFile(outStream);
            s2.writeToFile(outStream);
            // Reconstitui obiectele
            FileInputStream inStream = new FileInputStream(fisier);
            s1.readFromFile(inStream);
            s2.readFromFile(inStream);
            System.out.println(s1.nume + " " + s1.prenume + " " + s1.matricol);
            System.out.println(s2.nume + " " + s2.prenume + " " + s2.matricol);
        }catch(Exception e){e.printStackTrace();}
        */
        
        try{
            fisier.createNewFile();
            FileOutputStream outStream = new FileOutputStream(fisier);
            s1.writeToFile(outStream);
            s2.writeToFile(outStream);
            // Reconstitui obiectele
            FileInputStream inStream = new FileInputStream(fisier);
            ArrayList studenti = Student.getObjects(inStream);
            Student s;
            for(int i=0; i<studenti.size(); i++){
                s = (Student)studenti.get(i);
                System.out.println(s.nume + " " + s.prenume + " " + s.matricol);
            }
        }catch(Exception e){e.printStackTrace();}   
    }
    
}
class Student implements Serializable{
    public String matricol;
    public String nume;
    public String prenume;
    public Student(){}
    public Student(String pMatricol, String pNume, String pPrenume){
        matricol = pMatricol;
        nume = pNume;
        prenume = pPrenume;
    }
    
    public void writeToFile(FileOutputStream outStream) throws IOException{
        ObjectOutputStream oStream = new ObjectOutputStream(outStream);
        oStream.writeObject(this);
        oStream.flush();
    }
    public void readFromFile(FileInputStream inStream) throws IOException, ClassNotFoundException{
        ObjectInputStream oStream = new ObjectInputStream(inStream);
        Student s = (Student)oStream.readObject();
        this.matricol = s.matricol;
        this.nume = s.nume;
        this.prenume = s.prenume;
    }
    public static ArrayList getObjects(FileInputStream inStream) throws ClassNotFoundException{
        ArrayList studenti = new ArrayList();
        try{
            ObjectInputStream oStream;
            Object o;
            while(true){  
                oStream = new ObjectInputStream(inStream);
                o = oStream.readObject();
                studenti.add(o);
            }
        }catch(IOException e){e.printStackTrace();}
        return studenti;
    }
}