/*
 * TestFisiere.java
 *
 * Created on 24 mai 2003, 13:39
 */

package fisiere;
import java.io.*;
import javax.swing.JFileChooser;
/**
 *
 * @author  strimbeic
 */
public class TestFisiere {    
    private static boolean isWritableFile(String fileName){
        try{
            File fisier = new File(fileName);
            if (!fisier.exists())
                throw (new FileNotFoundException("Nu gasesc fisierul cu numele " + fileName));
            if (!fisier.canWrite())
                throw (new IOException("Fisier " + fileName + " neaccesibil la citire"));
            return true;
        }
        catch(FileNotFoundException e){
            System.out.println("ERORARE fisier inexistent: " + e.getMessage());
            return false;
        }
        catch(IOException e){
            System.out.println("ERORARE de acces: " + e.getMessage());
            return false;
        }
    }
    private static void createNewFile(String fileName){
        try{
            File fisier = new File(fileName);
            System.out.println("Creez fisier " + fisier.getPath());
            fisier.createNewFile();
        }catch(IOException e){
            System.out.println("Esec creare fisier !");
        }
    }
    private static void salveazaDateBinar(String date, File fisierSalvare){
        try{
            DataOutputStream outStream = 
                new DataOutputStream(new FileOutputStream(fisierSalvare));
            outStream.writeUTF(date);
            //outStream.flush();
            outStream.close();
        }catch(Exception e){
            System.out.println("Eroare de scriere: " + e.getMessage());
        }
    }
    private static String citesteDateBinar(File fisierSursa){
        String sirCitit = null;
        try{
            DataInputStream inStream = 
                new DataInputStream(new FileInputStream(fisierSursa));            
            sirCitit = inStream.readUTF();
            System.out.println("sirCitit " + sirCitit);
            inStream.close();
        }
        catch(EOFException e){}
        catch(Exception e){System.out.println("Eroare de citire " + e.getMessage());}
        return sirCitit;
    }
    private static void salveazaText(String date, File fisierSalvare){
        try{
            FileWriter outStream = 
                new FileWriter(fisierSalvare);
            outStream.write(date);
            outStream.close();
        }catch(Exception e){
            System.out.println("Eroare de scriere: " + e.getMessage());
        }        
    }
    public static String citesteText(File fisierSursa){
        StringBuffer textCitit = new StringBuffer();
        try{
            BufferedReader inStream = 
                new BufferedReader(new FileReader(fisierSursa));            
            String linie = inStream.readLine();
            while (linie!=null){
                textCitit.append(linie);
                linie = inStream.readLine();
            }
            inStream.close();
        }
        catch(EOFException e){}
        catch(Exception e){System.out.println("Eroare de citire " + e.getMessage());}
        
        return textCitit.toString();        
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        JFileChooser dialog = new JFileChooser();

        // pentru fisiere binare
        int result = dialog.showDialog(null, "New fisier binar");
        File fisierSelectat = dialog.getSelectedFile();
        String numeCompletFisier = fisierSelectat.getParent() + "\\" + fisierSelectat.getName();
        createNewFile(numeCompletFisier);
        if (isWritableFile(numeCompletFisier))
            System.out.println("OK creare fisier");
        System.out.println("Scrie in fisier binar: date salvate");
        salveazaDateBinar("date salvate", fisierSelectat);
        System.out.println("Citesc din fisier binar:" + citesteDateBinar(fisierSelectat));
       
        // pentru fisier text
        result = dialog.showDialog(null, "New fisier text");
        fisierSelectat = dialog.getSelectedFile();
        numeCompletFisier = fisierSelectat.getParent() + "\\" + fisierSelectat.getName();
        createNewFile(numeCompletFisier);
        if (isWritableFile(numeCompletFisier))
            System.out.println("OK creare fisier");
        System.out.println("Scrie in fisier text: date salvate");
        salveazaText("date salvate", fisierSelectat);
        System.out.println("Citesc din fisier binar:" + citesteText(fisierSelectat));      
    }
}
