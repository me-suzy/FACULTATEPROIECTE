/*
 * ExempluJToggleButton.java
 *
 * Created on May 18, 2004, 3:35 PM
 */

package javaGUI.componente;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/**
 *
 * @author  strimbeic
 */
public class ExempluJToggleButton extends JFrame{
  public ExempluJToggleButton(){
    Container contentPane = getContentPane();
    ButtonGroup grup = new ButtonGroup();
    JToggleButton [] butoane = new JToggleButton[]{
      new JToggleButton(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\1.jpg")),
      new JToggleButton(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\2.jpg")),
      new JToggleButton(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\3.jpg")),
      new JToggleButton(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\4.jpg")),
      new JToggleButton(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\5.jpg"))
    };
    contentPane.setLayout(new FlowLayout());
    for (int i = 0; i < butoane.length; ++i){
      grup.add(butoane[i]);
      contentPane.add(butoane[i]);
    }
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setSize(300, 300);        
  }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJToggleButton().show();
    }        
}