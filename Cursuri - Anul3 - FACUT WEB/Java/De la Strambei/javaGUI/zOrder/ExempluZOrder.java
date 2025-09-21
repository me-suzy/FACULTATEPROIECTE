/*
 * ExempluZOrder.java
 *
 * Created on May 13, 2004, 9:56 AM
 */

package javaGUI.zOrder;
import java.awt.*;
import javax.swing.*;

public class ExempluZOrder extends JFrame {
  JLabel label1 = new JLabel("Prima");
  JLabel label2 = new JLabel("A doua");
  JLabel label3 = new JLabel("A treia");
  public ExempluZOrder() {
    label1.setOpaque(false);
    label2.setOpaque(false);
    label3.setOpaque(false);

    Container contentPane = getContentPane();
    contentPane.setLayout(null);
    contentPane.add(label1);
    contentPane.add(label2);
    contentPane.add(label3);

    label1.setBounds(20, 40, 100, 60);
    label1.setBorder(BorderFactory.createEtchedBorder());
    label1.setOpaque(true);
    label2.setBounds(60, 80, 100, 60);
    label2.setBorder(BorderFactory.createEtchedBorder());
    label2.setOpaque(true);
    label3.setBounds(100, 120, 100, 60);
    label3.setBorder(BorderFactory.createEtchedBorder());
    label3.setOpaque(true);
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setSize(300, 300);
  }
  public static void main(String[] args) throws Exception{
      UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
      new ExempluZOrder().show();
  }
}

