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
public class ExempluJComboBoxEditabil extends JFrame{
    JComboBox jcombo = new JComboBox();
    JLabel status = new JLabel("Stare");
    /** Creates a new instance of ExempluJComboBox */
    public ExempluJComboBoxEditabil() {
        Container contentPane = getContentPane();
        jcombo.addItem("Elementul 1");
        jcombo.addItem("Elementul 2");
        jcombo.addItem("Elementul 3");
        jcombo.addItem("Elementul 4");
        jcombo.addItem("Elementul 5");
        // pentru declararea editabila a combo-box-ului
        jcombo.setEditable(true);
        // pentru tratarea evenimentelor
        jcombo.getEditor().addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                editareCombo(e);
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

    public void editareCombo(ActionEvent event){
        status.setText((String)jcombo.getSelectedItem() +
          " a fost modificat in " + jcombo.getEditor().getItem());
        Object elementModificat = jcombo.getEditor().getItem();
        Object elementEliminat = jcombo.getSelectedItem();

        jcombo.insertItemAt(elementModificat, jcombo.getSelectedIndex());
        // sau (mai complicat) inlocuim linia de mai sus cu
        // urmatoarele doua linii

        // jcombo.addItem(elementModificat);
        // jcombo.setSelectedItem(elementModificat);
        jcombo.removeItem(elementEliminat);
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJComboBoxEditabil().show();
    }      
}
