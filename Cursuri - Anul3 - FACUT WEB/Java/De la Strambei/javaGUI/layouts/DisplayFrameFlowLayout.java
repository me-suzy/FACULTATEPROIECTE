/*
 * DisplayFrameFlowLayout.java
 *
 * Created on May 13, 2004, 9:11 AM
 */

package javaGUI.layouts;
import javax.swing.*;
import java.awt.*;
/**
 *
 * @author  strimbeic
 */
public class DisplayFrameFlowLayout {
  public static void main(String[] args) {
    JFrame f = new JFrame("Dispunere cu FlowLayout");
    JButton b1 = new JButton("1");
    JButton b2 = new JButton("2");
    JButton b3 = new JButton("3");
    JButton b4 = new JButton("4");
    JButton b5 = new JButton("5");
    Container cp = f.getContentPane();
    cp.setLayout(new FlowLayout());
    cp.add(b1);
    cp.add(b2);
    cp.add(b3);
    cp.add(b4);
    cp.add(b5);
    f.setSize(200, 100);
    f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    f.setVisible(true);
  }
}

