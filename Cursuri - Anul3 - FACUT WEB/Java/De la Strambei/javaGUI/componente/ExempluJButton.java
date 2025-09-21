/*
 * ExempluJButton.java
 *
 * Created on May 18, 2004, 3:23 PM
 */

package javaGUI.componente;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/**
 *
 * @author  strimbeic
 */
public class ExempluJButton extends JFrame{
  JButton button = new JButton("Apasa", 
    new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\5.jpg"));
  JTextField text = new JTextField(30);    
    public ExempluJButton() {
        Container cp = getContentPane();
        cp.setLayout(new FlowLayout());
        cp.add(button);
        cp.add(text);

        button.addActionListener(new ActionListener(){
          public void actionPerformed(ActionEvent e){
            text.setText("Apasare reusita");
          }
        });
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 300);        
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJButton().show();
    }    
}