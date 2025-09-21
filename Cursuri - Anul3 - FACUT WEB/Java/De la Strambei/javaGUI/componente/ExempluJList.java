/*
 * ExempluJList.java
 *
 * Created on May 18, 2004, 3:46 PM
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
public class ExempluJList extends JFrame{
  JList jlist;
  JLabel status = new JLabel("Stare");
    public ExempluJList() {
        Container contentPane = getContentPane();
        String[] elemente = new String[12];

        for (int i = 0; i< elemente.length; i++){
          elemente[i] = "Elementul "+ i;
        }
        jlist = new JList(elemente);
        JScrollPane jspane = new JScrollPane(jlist);
        jlist.setVisibleRowCount(5);
        jlist.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        jlist.addListSelectionListener(new ListSelectionListener(){
          public void valueChanged(ListSelectionEvent e){
            //schimbareValoare(e);
              selectieElemente(e);
          }
        });
        //contentPane.setLayout(new FlowLayout());
        contentPane.add(jspane, BorderLayout.CENTER);
        JPanel statusBar = new JPanel();
        statusBar.setBorder(BorderFactory.createBevelBorder(
            javax.swing.border.BevelBorder.LOWERED));        
        statusBar.setLayout(new FlowLayout());
        statusBar.add(status);
        contentPane.add(statusBar, BorderLayout.SOUTH);        
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(200, 200);            
    }
    public void schimbareValoare(ListSelectionEvent e){
    }
    public void selectieElemente(ListSelectionEvent e){
        int [] indecsi = jlist.getSelectedIndices();
        String text_ = "ai selectat ";
        for (int i = 0; i< indecsi.length; i++){
          text_ += " elementul " + indecsi[i];
        }
        //showStatus(text_);
        status.setText(text_);
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJList().show();
    }  
}
