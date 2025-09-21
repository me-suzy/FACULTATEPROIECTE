/*
 * TestJComboBox.java
 *
 * Created on 21 aprilie 2003, 12:58
 */

package javaGUI;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
/**
 *
 * @author  strimbeic
 */
public class TestJComboBox extends JFrame{
    
    /** Creates a new instance of TestJComboBox */
    public TestJComboBox() {
        JComboBox cbo = new JComboBox();
        cbo.setModel(new ModelExtins());
        cbo.setRenderer(new RenderExtins());
        getContentPane().setLayout(new FlowLayout());
        getContentPane().add(cbo);
        setSize(400, 400);
        setVisible(true);
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        new TestJComboBox();
    }
    
}
class ModelExtins extends DefaultComboBoxModel{
  public ModelExtins(){
    // in modelul de date adaugam imagini folosind metoda addElement
    // mostenita bineninteles din clasa DefaultListModel
    // fiecare element al listei nu va fi altceva decat un vector
    // ce contine doua elemente: un String si un ImageIcon
    this.addElement(new Object[] {"1", new ImageIcon("D:/Working/Professional/POO/ProCurs/1.ico")});
    this.addElement(new Object[] {"2", new ImageIcon("D:/Working/Professional/POO/ProCurs/2.ico")});
    this.addElement(new Object[] {"3", new ImageIcon("D:/Working/Professional/POO/ProCurs/3.ico")});
  }
}
class RenderExtins extends JLabel implements ListCellRenderer{
  public RenderExtins(){
    this.setOpaque(true);
  }
  public Component getListCellRendererComponent(JList jlist, Object obj,
    int index, boolean isSelected, boolean focus){
      setText((String)((Object[])obj)[0]);
      setIcon((Icon)((Object[])obj)[1]);
      if (!isSelected){
        setBackground(jlist.getBackground());
        setForeground(jlist.getForeground());
      }
      else {
        setBackground(jlist.getSelectionBackground());
        setForeground(jlist.getSelectionForeground());
      }
      return this;
  }
}
