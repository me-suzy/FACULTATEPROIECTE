/*
 * AngajatAcord.java
 *
 * Created on 10 martie 2003, 17:10
 */

package salariati;

/**
 *
 * @author  strimbeic
 */
public class AngajatAcord extends Angajat{
    private float procRealizat =1;
    /** Creates a new instance of AngajatAcord */
    public AngajatAcord(String pNume, String pPrenume) {
        super(pNume, pPrenume);
    }
    public double afiseaza_salarii(){
        return super.afiseaza_salarii() * procRealizat;
    }
    public void setProcRealizat(int procente){
        procRealizat = ((float)procente)/100;
    }
    // testez un polimorfism
    public double calculSalarii(){
        double salariuTotal = super.calculSalarii() * procRealizat;
        System.out.println("Calculez din AngajatAcord");
        return salariuTotal;
    }
}
