/*
 * TestSort.java
 *
 * Created on 21 aprilie 2003, 11:03
 */

package egalitati;

/**
 *
 * @author  strimbeic
 */
public class TestSort{
    /** Creates a new instance of TestSort */
    public TestSort() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        java.util.Comparator comparatorCNP = new ComparatorCNP();
        java.util.Comparator comparatorNumePren = new ComparatorNumePren();        
        Comparable[] lista = new Persoana[]{
          new Persoana("CNP2", "Popescu", "Marin"),
          new Persoana("CNP4", "Ion", "Viorel"),
          new Persoana("CNP5", "Cimpeanu", "Gheorghe"),
          new Persoana("CNP3", "Stoica", "Viorel"),
          new Persoana("CNP1", "Ion", "Vasile"),
          new Persoana("CNP2", "Popescu", "Marin")
        };
        sort(lista, comparatorNumePren);
        //sort(lista, comparatorCNP);
    }
    public static void sort(Comparable[] lst, java.util.Comparator comparator){
        // aplic algoritmul Select-Sort
        int idx;
        Comparable temp;
        for(int i=0; i<lst.length; i++){
            idx = i;
            for(int j=i+1; j<lst.length; j++){
                if (lst[j].compareTo(lst[idx])<0){
                //if (comparator.compare(lst[j],lst[idx])<0){
                    idx = j;
                }
            }
            temp = lst[i];
            lst[i] = lst[idx];
            lst[idx] = temp;
            System.out.println("P" + i);
            printList(lst);
        }
        // afisez lista sortat
        System.out.println(comparator);
        printList(lst);
    }
    public static void printList(Object[] lst){
        for(int i=0; i < lst.length; i++)
            System.out.println(lst[i]);        
    }    
}
class Persoana implements Comparable{
    public String cnp;
    public String nume;
    public String prenume;
    public Persoana(String pCnp, String pNume, String pPrenume){
        cnp = pCnp;
        nume = pNume;
        prenume = pPrenume;
    }
    public boolean equals(Object obj){
        if (obj instanceof Persoana)
            return (cnp == ((Persoana)obj).cnp);
        else
            return false;
    }    
    
    public int compareTo(Object o) {
        Persoana c = (Persoana) o;
        if (nume.equals(c.nume))
            return prenume.compareTo(c.prenume);
        else
            return nume.compareTo(c.nume);
    }
    public String toString(){
        return cnp + " " + nume + " " + prenume;
    }
}
class Student extends Persoana{
    public String matricol;
    public String specializare;
    
    public Student(String pCnp, String pMatricol, String pNume, 
    String pPrenume, String pSpecializare){
        super(pCnp, pNume, pPrenume);
        matricol = pMatricol;
        specializare = pSpecializare;
    }
    public boolean equals(Student stud){
        return (matricol == stud.matricol);
   }
}
class ComparatorCNP implements java.util.Comparator{
    
    public int compare(Object o1, Object o2) {
        Persoana p1 = (Persoana) o1;
        Persoana p2 = (Persoana) o2;
        return p1.cnp.compareTo(p2.cnp);
    }
    public String toString(){
        return "dupa CNP";
    }
}
class ComparatorNumePren implements java.util.Comparator{
    
    public int compare(Object o1, Object o2) {
        Persoana p1 = (Persoana) o1;
        Persoana p2 = (Persoana) o2;
        if (p1.nume.equals(p2.nume))
            return p1.prenume.compareTo(p2.prenume);
        else
            return p1.nume.compareTo(p2.nume);
    }    
    public String toString(){
        return "dupa nume si prenume";
    }
}