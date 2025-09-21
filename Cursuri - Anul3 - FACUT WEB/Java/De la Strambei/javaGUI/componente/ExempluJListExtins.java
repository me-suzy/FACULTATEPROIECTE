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
public class ExempluJListExtins extends JFrame{
  JList jlist;
  JLabel status = new JLabel("Stare");
    public ExempluJListExtins() {
        Container contentPane = getContentPane();
        modelExtins model = new modelExtins();
        renderExtins render = new renderExtins();
        jlist = new JList(model);
        jlist.setCellRenderer(render);
        jlist.setVisibleRowCount(3);
        JScrollPane jspane = new JScrollPane(jlist);
        jlist.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        contentPane.setLayout(new FlowLayout());
        contentPane.add(jspane);       
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 300);            
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJListExtins().show();
    }  
}
class modelExtins extends DefaultListModel{
  public modelExtins(){
    this.addElement(new Object[] {"help", new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\5.jpg")});
    this.addElement(new Object[] {"find", new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\3.jpg")});
    this.addElement(new Object[] {"exit", new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\4.jpg")});
    this.addElement(new Object[] {"save", new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\7.jpg")});
    this.addElement(new Object[] {"delete", new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\2.jpg")});
  }
}
class renderExtins extends JLabel implements ListCellRenderer{
  public renderExtins(){
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