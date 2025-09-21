/*
 * ExempluJLabel.java
 *
 * Created on May 18, 2004, 3:16 PM
 */

package javaGUI.componente;
import java.awt.*;
import javax.swing.*;

public class ExempluJLabel extends JFrame{    
  public ExempluJLabel(){
    Container cp = getContentPane();
    JLabel jlabel = new JLabel("Am aparut din Swing");
    cp.setLayout(new FlowLayout());
    cp.add(jlabel);
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setSize(300, 300);
  }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJLabel().show();
    } 
}
