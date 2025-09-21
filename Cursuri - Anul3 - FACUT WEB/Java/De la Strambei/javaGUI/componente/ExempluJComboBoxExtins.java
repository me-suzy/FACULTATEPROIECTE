/*
 * ExempluJComboBox.java
 *
 * Created on May 18, 2004, 5:56 PM
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
public class ExempluJComboBoxExtins extends JFrame{
    JComboBox jcombo = new JComboBox();
    JLabel status = new JLabel("Stare");
    /** Creates a new instance of ExempluJComboBox */
    public ExempluJComboBoxExtins() {
        Container contentPane = getContentPane();

        jcombo.addItem("Elementul 1");
        jcombo.addItem("Elementul 2");
        jcombo.addItem("Elementul 3");
        jcombo.addItem("Elementul 4");
        jcombo.addItem("Elementul 5");

        // pentru tratarea evenimentelor
        jcombo.addItemListener(new ItemListener(){
          public void itemStateChanged(ItemEvent e){
            schimbareElementCombo(e);
          }
        });
        
        //contentPane.setLayout(new FlowLayout());

        JPanel mainPane = new JPanel(new FlowLayout());
        mainPane.add(jcombo);
        contentPane.add(mainPane, BorderLayout.CENTER);
        JPanel statusBar = new JPanel();
        statusBar.setBorder(BorderFactory.createBevelBorder(
            javax.swing.border.BevelBorder.LOWERED));
        statusBar.setLayout(new FlowLayout());
        statusBar.add(status);
        contentPane.add(statusBar, BorderLayout.SOUTH);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 300);   
    }
    public void schimbareElementCombo(ItemEvent e){
        if (e.getStateChange() == ItemEvent.DESELECTED){
            status.setText(" Deselectat " + (String)e.getItem());
        }
        if (e.getStateChange() == ItemEvent.SELECTED){
            status.setText(status.getText() + " Selectat " + (String)e.getItem());
        }
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJComboBoxExtins().show();
    }      
}
