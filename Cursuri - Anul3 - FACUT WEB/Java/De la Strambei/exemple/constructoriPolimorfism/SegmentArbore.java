/*
 * SegmentArbore.java
 *
 * Created on 24 martie 2003, 11:40
 */

package exemple.constructoriPolimorfism;

/**
 *
 * @author  strimbeic
 */
public abstract class SegmentArbore {
  public abstract SegmentArbore aflaNodSuperior();
}

class Radacina extends SegmentArbore{
  private String Nume;
  public SegmentArbore aflaNodSuperior(){
    return null;
  }
}

class Ramura extends SegmentArbore{
  private String Nume;
  private Ramura nodSuperior ;
  public SegmentArbore aflaNodSuperior(){
    return this.nodSuperior;
  }
}

class Frunza extends SegmentArbore{
  private String Nume;
  private Ramura ramuraSuperioara ;
  public SegmentArbore aflaNodSuperior(){
    return this.ramuraSuperioara;
  }
}
