/*
 * MainMenuBar.java
 *
 * Created on 10 mai 2003, 18:35
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
public class MainMenuBar extends JMenuBar{
    JFrame frmParent;
    /** Creates a new instance of MainMenuBar */
    public MainMenuBar() {
        JMenu fileMenu = new JMenu("File");
        JMenu editMenu = new JMenu("Edit");
        JMenu quitMenu = new JMenu("Quit");
        
        // Meniul File: Open, Save, Close
        JMenuItem openItem = new JMenuItem("Open");
        openItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                JInternalFrame form = new JInternalFrame();
                //JFrame form = new JFrame();
                //JDialog form = new JDialog();
                form.setContentPane(new FormPane());
                form.setSize(300, 300);
                frmParent.getContentPane().add(form);
                //form.setModal(true);
                form.setVisible(true);
            }
        });        
        JMenuItem saveItem = new JMenuItem("Save");
        JMenuItem closeItem = new JMenuItem("Close");
        
        //Meniul Edit: Cut, Copy, Paste, Find (Find, Replace)
        JMenuItem cutItem = new JMenuItem("Cut");
        JMenuItem copyItem = new JMenuItem("Copy");
        JMenuItem pasteItem = new JMenuItem("Paste");
        JSeparator separator1 = new JSeparator();
        JMenu findMenu = new JMenu("Find");
        JMenuItem findItem = new JMenuItem("Find");
        findItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                javax.swing.JOptionPane.showMessageDialog(((Component)(e.getSource())).getParent(), "Optiunea find");
            }
        });         
        JMenuItem replaceItem = new JMenuItem("Replace");
        
        //Meniul Quit
        JMenuItem exitItem = new JMenuItem("Exit");
        exitItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                System.exit(0);
            }
        });
        JMenuItem aboutItem = new JMenuItem("About");
        
        fileMenu.add(openItem);
        fileMenu.add(saveItem);
        fileMenu.add(closeItem);
        
        editMenu.add(cutItem);
        editMenu.add(copyItem);
        editMenu.add(pasteItem);
        editMenu.add(separator1);
        findMenu.add(findItem);
        findMenu.add(replaceItem);
        editMenu.add(findMenu);
        editMenu.add(new JCheckBox("Bifa"));
        quitMenu.add(exitItem);
        quitMenu.add(aboutItem);
        
        add(fileMenu);
        add(editMenu);
        add(quitMenu);
    }
    
}
