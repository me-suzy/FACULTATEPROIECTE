import javax.swing.table.AbstractTableModel;
import java.util.ArrayList;
import java.sql.*;
import java.math.BigDecimal;

public class ModelJTablePontaje extends AbstractTableModel {
    public ArrayList listaPontaj=new ArrayList();
    public Connection conexiune;
    
    /** Creates a new instance of ModelGridStudenti */
    public ModelJTablePontaje(Connection conn){
       this.conexiune=conn;
    }
     public String getColumnName(int column) {
     if (column==0)
         return "Marca";
     else if(column==1)
         return "Data";
     else if(column==2)
         return "Ore Lucrate";
     else if(column==3)
        return "Ore CO";
     else if(column==4)
        return "Ore Noapte";   
     else 
        return "Ore Abs. Nem";
       
     }
    public int getColumnCount() {
        return 6;
    }
    
    public int getRowCount() {
        return this.listaPontaj.size();
    }
    public Class getColumnClass(int col) {
        if (col==1)
            return Timestamp.class;
        else      
            return BigDecimal.class;
      }
 public Object getValueAt(int rowIndex, int columnIndex) {
        Pontaje objPont=(Pontaje)this.listaPontaj.get(rowIndex);
     if (columnIndex==0)
         return objPont.getMarca();
     else if(columnIndex==1)
         return objPont.getData();
     else if(columnIndex==2)
         return objPont.getOrelucrate();
     else if(columnIndex==3)
        return objPont.getOreco();
     else if(columnIndex==4)
        return objPont.getOrenoapte();
     else
        return objPont.getOreabsnem(); 
     
    }
 public void setValueAt(Object valNoua, int rowIndex, int columnIndex) {
    Pontaje objPont=(Pontaje)this.listaPontaj.get(rowIndex);
        
     if (columnIndex==0)
         objPont.setMarca((BigDecimal)valNoua);
     else if(columnIndex==1)
         objPont.setData((Timestamp)valNoua);
     else if(columnIndex==2)
        objPont.setOrelucrate((BigDecimal)valNoua);
     else if(columnIndex==3)
        objPont.setOreco((BigDecimal)valNoua);
     else if(columnIndex==4)
        objPont.setOrenoapte((BigDecimal)valNoua);
     else 
        objPont.setOreabsnem((BigDecimal)valNoua); 
        
     }
     public boolean isCellEditable(int rowIndex, int columnIndex) {
         if (columnIndex==0)
            return false;
         else
            return true;
    }
     
 // zona tranzactionala specfica     
 public void comiteModificari(){
     Pontaje objPont=null;
     for (int i=0;i<this.listaPontaj.size();i++)
         try{    // incercam salvarea obiectului curent
            objPont=(Pontaje)this.listaPontaj.get(i);
            int stare=objPont.getStare();
            System.out.println(stare);
            if (stare!=Pontaje.SINCRONIZAT)
                objPont.salveaza(this.conexiune);
            // daca nu a dat eroare si era STERS tre' sa-l elimin din colectie
            if (stare==Pontaje.STERS)
                this.listaPontaj.remove(i);
         }
         catch(Exception e){Utilitati.tratareErori(e);} 
     }
     
 public void anulezModificari(){
     Pontaje objPont=null;
     for (int i=0;i<this.listaPontaj.size();i++)
         try{    
            objPont=(Pontaje)this.listaPontaj.get(i);
            int stare=objPont.getStare();
            if (stare==Pontaje.NOU)
                this.listaPontaj.remove(i);
            else if (stare!=Pontaje.SINCRONIZAT)
                objPont.refresh(this.conexiune);
             }
         catch(Exception e){Utilitati.tratareErori(e);} 
     }
 public void requeryModel(BigDecimal pMarca, BigDecimal an, BigDecimal luna){
     try{
        this.listaPontaj=Pontaje.getObjects(this.conexiune, "where marca="+pMarca
                                           +"  and Extract(MONTH from data)="+luna
                                           +"  and Extract(YEAR from data)="+an);
    }
    catch(Exception e){Utilitati.tratareErori(e);} 
    
    }
  public void addLinieNoua(BigDecimal marca){
        
        Pontaje obiectNou=new Pontaje(null,marca,new Timestamp(1),BigDecimal.valueOf(0), BigDecimal.valueOf(0),BigDecimal.valueOf(0), BigDecimal.valueOf(0));
        this.listaPontaj.add(obiectNou);
        
        
    }
    public void stergLinie(int rowIndex){
       Pontaje objPont=(Pontaje)this.listaPontaj.get(rowIndex);
       objPont.setStare(Pontaje.STERS);
      }   
}