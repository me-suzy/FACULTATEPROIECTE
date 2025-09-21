package persistenta;

import java.util.ArrayList;
import java.math.BigDecimal;
import java.sql.*;

public class Pontaje {
   public final static  int NOU=1;
   public final static  int MODIFICAT=2;
   public final static  int STERS=3;
   public final static  int SINCRONIZAT=4;


protected java.math.BigDecimal   marca;
protected java.sql.Timestamp   data;
protected java.math.BigDecimal   orelucrate;
protected java.math.BigDecimal   oreco;
protected java.math.BigDecimal   orenoapte;
protected java.math.BigDecimal   oreabsnem;

protected oracle.sql.ROWID idLinieBD;
protected int stare;

public Pontaje(){this.stare=NOU;}
public Pontaje(oracle.sql.ROWID id, BigDecimal   pMarca,Timestamp pData, BigDecimal   pOrelucrate, BigDecimal   pOreco,BigDecimal   pOrenoapte, BigDecimal   pOreabsnem )
{
 this.idLinieBD=id;
 this.marca=pMarca;
 this.data=pData;
 this.orelucrate=pOrelucrate;
 this.oreco=pOreco;
 this.orenoapte=pOrenoapte;
 this.oreabsnem=pOreabsnem;
 this.stare=NOU;
}
public int   getStare(){return this.stare;}
  public void  setStare(int stareNoua){
       if (this.stare==NOU && stareNoua==MODIFICAT)
          return;
       else
          this.stare=stareNoua;
   }
  
  public void salveaza(Connection conn) throws Exception{
      if (this.stare==SINCRONIZAT)
         return;
      boolean conexiuneNula=false;
      if (conn==null)
         {conn=Utilitati.getConexiune();
          conexiuneNula=true;
         }
        
        PreparedStatement stmt=null;
        PreparedStatement stmtRowid=null;
      try{
        
      if (this.stare==NOU){
            stmt= conn.prepareStatement("insert into pontaje" +
                                          "(marca,data,orelucrate,oreco,orenoapte,oreabsnem) values (?,?,?,?,?,?)");
            stmt.setBigDecimal(1,this.marca);
            stmt.setTimestamp(2,this.data);
            stmt.setBigDecimal(3,this.orelucrate);
            stmt.setBigDecimal(4,this.oreco);
            stmt.setBigDecimal(5,this.orenoapte);
            stmt.setBigDecimal(6,this.oreabsnem);
            stmt.execute();
            // trebuie sa obtinem rowid-ul noii inregistrari
            stmtRowid=conn.prepareStatement("select rowid from pontaje where marca=? and data=?");
            stmtRowid.setBigDecimal(1, this.marca);
            stmtRowid.setTimestamp(2,this.data);
            oracle.jdbc.OracleResultSet rs=(oracle.jdbc.OracleResultSet)stmtRowid.executeQuery();
            rs.next();
            this.idLinieBD=rs.getROWID(1);
            //System.out.print(this.idLinieBD);
            rs.close();
            stmtRowid.close();
            this.stare=SINCRONIZAT;
      }
      else if (this.stare==MODIFICAT){
            stmt=conn.prepareStatement("update pontaje set "+
                                            "marca=?,data=?,orelucrate=?,oreco=?,orenoapte=?,oreabsnem=? where rowid=?");
                                                    
            stmt.setBigDecimal(1,this.marca);
            stmt.setTimestamp(2,this.data);
            stmt.setBigDecimal(3,this.orelucrate);
            stmt.setBigDecimal(4,this.oreco);
            stmt.setBigDecimal(5,this.orenoapte);
            stmt.setBigDecimal(6,this.oreabsnem);
           // pentru setROWID trebuie downcasting 
            ((oracle.jdbc.OraclePreparedStatement)stmt).setROWID(7,this.idLinieBD);
            stmt.execute();
            this.stare=SINCRONIZAT;
      }
      else if (this.stare==STERS){
            stmt=conn.prepareStatement("delete from pontaje where rowid=?");
            ((oracle.jdbc.OraclePreparedStatement)stmt).setROWID(1,this.idLinieBD);
            stmt.execute();
            this.stare=SINCRONIZAT;
      }
      }// sf. try
      catch(Exception e){e.printStackTrace(); throw e;}
      finally{ 
            if (stmt!=null) stmt.close();
            if (stmtRowid!=null) stmtRowid.close();
            if (conexiuneNula) // daca nu am primit conexiunea o inchid
                 conn.close();
            
      }   
      
      
  }
  public void refresh(Connection conn) throws Exception{
       if (conn==null)
            conn=Utilitati.getConexiune();
       PreparedStatement stmt=null;
   try{    
       stmt=conn.prepareStatement("select * from pontaje where rowid=?");
       ((oracle.jdbc.OraclePreparedStatement)stmt).setROWID(1,this.idLinieBD);
       ResultSet rs=stmt.executeQuery();
       if (rs.next())
         { this.marca=rs.getBigDecimal("marca");
           this.data=rs.getTimestamp("data");
           this.orelucrate=rs.getBigDecimal("orelucrate");
           this.oreco=rs.getBigDecimal("oreco");
           this.orenoapte=rs.getBigDecimal("orenoapte");
           this.oreabsnem=rs.getBigDecimal("oreabsnem");
       }
       this.stare=SINCRONIZAT;
       }
   catch(Exception e){throw e;}
   finally{ stmt.close();}
  }
  public static ArrayList getObjects(Connection conn,String whereFiltru) throws Exception{
       if (conn==null)
            conn=Utilitati.getConexiune();
       String frazaSelect="Select rowid,pontaje.* from pontaje";
       if (whereFiltru!=null)
           frazaSelect +=" "+whereFiltru; 
       
      Statement stmt=null;
        ArrayList listaObiecte=new ArrayList();
  try{ 
      stmt=conn.createStatement();
      ResultSet rs=stmt.executeQuery(frazaSelect);
     
      Pontaje p;
      while (rs.next())
      {   p=new Pontaje(
                   ((oracle.jdbc.OracleResultSet)rs).getROWID("rowid"),
                   rs.getBigDecimal("marca"),
                   rs.getTimestamp("data"),
                   rs.getBigDecimal("orelucrate"),
                   rs.getBigDecimal("oreco"),rs.getBigDecimal("orenoapte"),rs.getBigDecimal("oreabsnem"));
          p.stare=SINCRONIZAT;
          listaObiecte.add(p);
      }
      
     }
  catch(Exception e){throw e;}
  finally{ 
      stmt.close();
      }
  return listaObiecte; 
  }

  /** metodele get */ 
public java.math.BigDecimal getMarca(){ return this.marca;}
public java.sql.Timestamp getData(){ return this.data;}
public java.math.BigDecimal getOrelucrate(){ return this.orelucrate;}
public java.math.BigDecimal getOreco(){ return this.oreco;}
public java.math.BigDecimal getOrenoapte(){ return this.orenoapte;}
public java.math.BigDecimal getOreabsnem(){ return this.oreabsnem;}

/** metodele set */ 
public void setMarca(java.math.BigDecimal valNoua){ 
if (valNoua==null ? marca!=valNoua : valNoua!=null&&!valNoua.equals(marca))
{     this.marca=valNoua;
     this.setStare(MODIFICAT);
}}
public void setData(java.sql.Timestamp valNoua){ 
if (valNoua==null ? data!=valNoua : valNoua!=null&&!valNoua.equals(data))
{     this.data=valNoua;
     this.setStare(MODIFICAT);
}}
public void setOrelucrate(java.math.BigDecimal valNoua){ 
if (valNoua==null ? orelucrate!=valNoua : valNoua!=null&&!valNoua.equals(orelucrate))
{     this.orelucrate=valNoua;
     this.setStare(MODIFICAT);
}}
public void setOreco(java.math.BigDecimal valNoua){ 
if (valNoua==null ? oreco!=valNoua : valNoua!=null&&!valNoua.equals(oreco))
{     this.oreco=valNoua;
     this.setStare(MODIFICAT);
}}
public void setOrenoapte(java.math.BigDecimal valNoua){ 
if (valNoua==null ? orenoapte!=valNoua : valNoua!=null&&!valNoua.equals(orenoapte))
{     this.orenoapte=valNoua;
     this.setStare(MODIFICAT);
}}
public void setOreabsnem(java.math.BigDecimal valNoua){ 
if (valNoua==null ? oreabsnem!=valNoua : valNoua!=null&&!valNoua.equals(oreabsnem))
{     this.oreabsnem=valNoua;
     this.setStare(MODIFICAT);
}}

}