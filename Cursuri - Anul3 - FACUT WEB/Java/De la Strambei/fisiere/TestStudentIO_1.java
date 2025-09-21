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
public class TestStudentIO_1 {
    
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
        DataOutputStream oStream = new DataOutputStream(outStream);
        oStream.writeUTF(matricol);
        oStream.writeUTF(nume);
        oStream.writeUTF(prenume);
    }
    public void readFromFile(FileInputStream inStream) throws IOException, ClassNotFoundException{
        DataInputStream oStream = new DataInputStream(inStream);
        this.matricol = oStream.readUTF();
        this.nume = oStream.readUTF();
        this.prenume = oStream.readUTF();
    }
    public static ArrayList getObjects(FileInputStream inStream) throws ClassNotFoundException{
        ArrayList studenti = new ArrayList();
        Student o;
        try{
            DataInputStream oStream = new DataInputStream(inStream);
            while(true){
                o = new Student();
                o.matricol = oStream.readUTF();
                o.nume = oStream.readUTF();
                o.prenume = oStream.readUTF();
                studenti.add(o);
            }
        }
        catch(EOFException e){}
        catch(IOException e){e.printStackTrace();}
        return studenti;
    }    
}