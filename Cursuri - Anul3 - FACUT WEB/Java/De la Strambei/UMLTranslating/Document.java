/*
 * Document.java
 *
 * Created on 19 mai 2003, 11:08
 */

package UMLTranslating;

/**
 *
 * @author  strimbeic
 */
public abstract class Document {
    public ArticolDoc[] detalii;
    private int docID;
    private static String destinatar = "myComp";
    public java.sql.Date data;
    public Client emitent;
    /** Creates a new instance of Document */
    public Document() {
    }
    private int genereazaDocID(){
        return 0;
    }
    public Client getEmitent(){
        return null;
    }
    public final void setDataDoc(java.sql.Date dataDoc){
    }
}
class Client{
    public Adresa sediu;
    public Client(){}
}
class Adresa {
    public Client rezident;
    public Adresa(){}
}
class ArticolDoc{
    public ArticolDoc(){}
}