/*
 * ExempluJScrollPane.java
 *
 * Created on May 19, 2004, 4:13 PM
 */

package javaGUI.componente;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

/**
 *
 * @author  strimbeic
 */
public class ExempluJScrollPane extends JFrame{
    public ExempluJScrollPane() {
        Container contentPane = getContentPane();
        JPanel jpanel = new JPanel();
        jpanel.setLayout(new GridLayout(20, 16));
        for (int i = 0; i<=150; i++)
          jpanel.add(new JTextField("Text " + i));

        JScrollPane jspane = new JScrollPane(jpanel,
            ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS,
            ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);

        contentPane.add(jspane);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 300);           
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJScrollPane().show();
    }     
}
