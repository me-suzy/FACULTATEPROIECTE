package javaGUI.zOrder;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.JApplet;

public class ExempluJLayeredPane extends JFrame {
  JLayeredPane jlpane = new JLayeredPane();
  JLabel label1 = new JLabel(" L1 - Stratul Content");
  JLabel label2 = new JLabel(" L2 - Stratul Default");
  JLabel label3 = new JLabel(" L3 - Stratul Palette");
  JLabel label4 = new JLabel(" L4 - Stratul Modal");
  JLabel label5 = new JLabel(" L5 - Stratul Popup");
  JLabel label6 = new JLabel(" L6 - Stratul Drag");

  public ExempluJLayeredPane() {
    setContentPane(jlpane);

    label1.setBounds(20, 0, 120, 60);
    label2.setBounds(30, 40, 120, 60);
    label3.setBounds(40, 80, 120, 60);
    label4.setBounds(50, 120, 120, 60);
    label5.setBounds(60, 160, 120, 60);
    label6.setBounds(70, 200, 120, 60);

    label1.setBorder(BorderFactory.createEtchedBorder());
    label2.setBorder(BorderFactory.createEtchedBorder());
    label3.setBorder(BorderFactory.createEtchedBorder());
    label4.setBorder(BorderFactory.createEtchedBorder());
    label5.setBorder(BorderFactory.createEtchedBorder());
    label6.setBorder(BorderFactory.createEtchedBorder());

    jlpane.setLayer(label1,JLayeredPane.FRAME_CONTENT_LAYER.intValue());
    jlpane.setLayer(label2,JLayeredPane.DEFAULT_LAYER.intValue());
    jlpane.setLayer(label3,JLayeredPane.PALETTE_LAYER.intValue());
    jlpane.setLayer(label4,JLayeredPane.MODAL_LAYER.intValue());
    jlpane.setLayer(label5,JLayeredPane.POPUP_LAYER.intValue());
    jlpane.setLayer(label6,JLayeredPane.DRAG_LAYER.intValue());

    jlpane.add(label1);
    jlpane.add(label2);
    jlpane.add(label3);
    jlpane.add(label4);
    jlpane.add(label5);
    jlpane.add(label6);

    label1.setOpaque(true);
    label2.setOpaque(true);
    label3.setOpaque(true);
    label4.setOpaque(true);
    label5.setOpaque(true);
    label6.setOpaque(true);
    
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setSize(300, 300);

  }
  
  public static void main(String[] args) throws Exception{
      UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
      new ExempluJLayeredPane().show();
  }
} 