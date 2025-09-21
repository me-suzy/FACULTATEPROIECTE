/*
 * DisplayFrameBoxLayout.java
 *
 * Created on May 13, 2004, 9:16 AM
 */

package javaGUI.layouts;
import java.awt.*;
import javax.swing.*;

/**
 *
 * @author  strimbeic
 */
public class DisplayFrameBoxLayout {
    
  public static void main(String[] args) {
        JFrame f = new JFrame("Dispunere cu GridLayout");
        Container cp = f.getContentPane();
        //cp.setLayout(new BoxLayout(cp, BoxLayout.X_AXIS));
        cp.setLayout(new BoxLayout(cp, BoxLayout.Y_AXIS));
        cp.add(new JButton("1"));
        cp.add(new JButton("2"));
        cp.add(new JButton("3"));
        cp.add(new JButton("4"));
        cp.add(new JButton("5"));
        cp.add(new JButton("6"));
        
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.pack();
        f.show();
    }
    
}
