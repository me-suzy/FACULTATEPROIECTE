/*
 * DisplayFrameBorderLayout.java
 *
 * Created on May 13, 2004, 9:12 AM
 */

package javaGUI.layouts;
import javax.swing.*;
import java.awt.*;

/**
 *
 * @author  strimbeic
 */
public class DisplayFrameBorderLayout {
  public static void main(String[] args) {
    JFrame f = new JFrame("Dispunere cu BorderLayout");
    Container cp = f.getContentPane();
    cp.setLayout(new BorderLayout());
    cp.add(new JButton("Nord"), BorderLayout.NORTH);
    cp.add(new JButton("Sud"), BorderLayout.SOUTH);
    cp.add(new JButton("Est"), BorderLayout.EAST);
    cp.add(new JButton("Vest"), BorderLayout.WEST);
    cp.add(new JButton("Centru"), BorderLayout.CENTER);
    f.setSize(300, 200);
    f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    f.setVisible(true);
  }
}

