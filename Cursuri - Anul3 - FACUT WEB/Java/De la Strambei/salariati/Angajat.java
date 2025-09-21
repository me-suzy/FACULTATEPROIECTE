/*
 * Persoana.java
 *
 * Created on 03 martie 2003, 12:36
 */

package salariati;

/**
 *
 * @author  strimbeic
 */
public class Angajat{
   private String nume;
   private String prenume;
   
   private int zile_lucrate[] = new int[12];
   private float salariu_zilnic_lunar[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
   
   // testez un polimorfism
   private float salariuZilnic = 100000;
   private int zileLucrate = 12;
   
   private float salariu_lunar = 0;
   private double salariu_total = 0;
   
    /** Creates a new instance of Persoana */
   //public Angajat(){}
    public Angajat(String pNume, String pPrenume) {
        nume = pNume;
        prenume = pPrenume;
    }
    public void stabZileLucrate(int[] pZileLucrate){
        System.arraycopy(pZileLucrate, 0, zile_lucrate, 0, 12);
        
    }
    public void stabSalariuZilnic(float[] pSalariuZilnic){
        System.arraycopy(pSalariuZilnic, 0, salariu_zilnic_lunar, 0, 12);
    }
    public double afiseaza_salarii(){
        for (int i=0; i < zile_lucrate.length -1; i++){
            salariu_lunar = salariu_zilnic_lunar[i] * zile_lucrate[i];
            salariu_total += salariu_lunar;
            int luna = i + 1;
            System.out.println("Salariu luna " + i + " " + salariu_lunar);
        }
        System.out.println("Salariu total " + (long) salariu_total);
        return salariu_total;
    }
    
    public static void main(String[] args){
        Angajat o_persoana = new Angajat("Prima", "Persoana");
        Angajat alta_persoana = new Angajat("A Doua", "Persoana");
        int zile[] = {10, 12, 15, 20, 14, 16, 12, 10, 12, 15, 20, 14};
        float sal_ln [] = new float[12];
        for (int i=0; i < 12; i++){
            sal_ln[i] = 100000;
        }
        o_persoana.stabZileLucrate(zile);
        o_persoana.stabSalariuZilnic(sal_ln);
        o_persoana.afiseaza_salarii();
        alta_persoana.stabZileLucrate(zile);
        
        System.out.println("Pentru " + o_persoana.nume +": " + zile);
        System.out.println("Pentru " + alta_persoana.nume +": " + zile);
    }
    
    // testez un polimorfism
    public double calculSalarii(){
        System.out.println("Calculez in Angajat");
        return salariuZilnic * zileLucrate;
    }
}