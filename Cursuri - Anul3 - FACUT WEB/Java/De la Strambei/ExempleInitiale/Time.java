/*
 * Time.java
 *
 * Created on 17 martie 2003, 10:37
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
public class Time {
    private int ora;     // 0 - 23
    private int minutul;   // 0 - 59
    private int secunda;   // 0 - 59

    // Constructorii
    public Time() { setTime( 0, 0, 0 ); }
    public Time( int h ) { setTime( h, 0, 0 ); }
    public Time( int h, int m ) { setTime( h, m, 0 ); }
    public Time( int h, int m, int s ) { setTime( h, m, s ); }
    public Time( Time timp )
    {
       setTime( timp.getOra(),
                timp.getMinutul(),
                timp.getSecunda() );
    }

    // Metodele Set
    // Stabileste noua valoare pentru timp. Efectueaza
    // verificari de validitate asupra datelor
    public void setTime( int h, int m, int s )
    {
       setOra( h );    // set the Ora
       setMinutul( m );  // set the Minutul
       setSecunda( s );  // set the Secunda
    }
    // set pentru ora
    public void setOra( int h )
       { ora = ( ( h >= 0 && h < 24 ) ? h : 0 ); }
    // set pentru minut
    public void setMinutul( int m )
       { minutul = ( ( m >= 0 && m < 60 ) ? m : 0 ); }
    // set pentru secunda
    public void setSecunda( int s )
       { secunda = ( ( s >= 0 && s < 60 ) ? s : 0 ); }

    // Metode get
    // get pentru ora
    public int getOra() { return ora; }
    // get pentru minut
    public int getMinutul() { return minutul; }
    // get pentru secunda
    public int getSecunda() { return secunda; }
 }

