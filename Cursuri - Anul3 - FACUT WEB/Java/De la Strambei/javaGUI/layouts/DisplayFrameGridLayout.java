/*
 * DisplayFrameGridLayout.java
 *
 * Created on May 13, 2004, 9:13 AM
 */

package javaGUI.layouts;
import javax.swing.*;
import java.awt.*;

/**
 *
 * @author  strimbeic
 */
public class DisplayFrameGridLayout {
  public static void main(String[] args) {
    JFrame f = new JFrame("Dispunere cu GridLayout");
    Container cp = f.getContentPane();
    cp.setLayout(new GridLayout(3, 2));
    cp.add(new JButton("1"));
    cp.add(new JButton("2"));
    cp.add(new JButton("3"));
    cp.add(new JButton("4"));
    cp.add(new JButton("5"));
    cp.add(new JButton("6"));
    f.setSize(300, 200);
    f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    f.setVisible(true);
    
    /* completare
    // adaugam inca doua butoane ceea ce va determina invalidarea containerului
    // si necesitatea reafisarii lui
    cp.add(new JButton("7"));
    cp.add(new JButton("8"));
    if (!cp.isValid())
     //reafisam explicit containerul prin re-validarea lui
      cp.validate();
     sf. completare*/
  }
}
