package parametrizare;
public class TestPozitionare {
    static void calculSalarii(String pMarca, int pAn, int pLuna){
        System.out.println("Calculez salariu pentru anagajatul " + pMarca +
        " pe luna " + pLuna + ", anul " + pAn);
    } // sf. calculSalarii
    public static void main(String[] args) {
        String marca = "0001";
        int an = 2004;
        int luna = 4;
        calculSalarii(marca, an, luna);
    } // sf. main
}