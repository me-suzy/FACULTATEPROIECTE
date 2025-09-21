/*
 * ExempluJTabbedPane.java
 *
 * Created on May 18, 2004, 3:11 PM
 */

package javaGUI.zOrder;

/**
 *
 * @author  strimbeic
 */
import java.awt.*;
import javax.swing.*;
import javax.swing.JApplet;

public class ExempluJTabbedPane extends JFrame {
  public ExempluJTabbedPane() {
    Container contentPane = getContentPane();
    JTabbedPane jtab = new JTabbedPane();
    JPanel jpanel1 = new JPanel();
    JPanel jpanel2 = new JPanel();
    JPanel jpanel3 = new JPanel();
    jpanel1.add(new JLabel(" Prima pagina "));
    jpanel2.add(new JLabel(" A doua pagina "));
    jpanel3.add(new JLabel(" A treia pagina "));
    jtab.addTab("Tab 1", jpanel1);
    jtab.addTab("Tab 2", jpanel2);
    jtab.addTab("Tab 3", jpanel3);
    contentPane.setLayout(new BorderLayout());
    contentPane.add(jtab);
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setSize(300, 300);
  }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJTabbedPane().show();
    }
}
