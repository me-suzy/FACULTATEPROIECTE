/*
 * MainMenuBar.java
 *
 * Created on 29 mai 2003, 17:39
 */

package Menus;
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
    public MainMenuBar() {
        JMenu fileMenu = new JMenu("File");
        JMenu editMenu = new JMenu("Edit");
        JMenu quitMenu = new JMenu("Quit");
        
        // Meniul File: Open, Save, Close
        JMenuItem openItem = new JMenuItem("Open");        
        JMenuItem saveItem = new JMenuItem("Save");
        JMenuItem closeItem = new JMenuItem("Close");
        
        //Meniul Edit: Cut, Copy, Paste, Find (Find, Replace)
        JMenuItem cutItem = new JMenuItem("Cut");
        
        JMenuItem copyItem = new JMenuItem("Copy");
        copyItem.setAccelerator(KeyStroke.getKeyStroke('C', 
            Toolkit.getDefaultToolkit().getMenuShortcutKeyMask(), false));
        copyItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                JOptionPane.showMessageDialog(null, "A fost selectata optiunea \"" + 
                    e.getActionCommand() + "\"");
            }
        });
        copyItem.setMnemonic('C');
        
        JMenuItem pasteItem = new JMenuItem("Paste");
        JSeparator separator1 = new JSeparator();
        JMenu findMenu = new JMenu("Find");
        
        JMenuItem findItem = new JMenuItem("Find");
        findItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                JOptionPane.showMessageDialog(null, "A fost selectata optiunea \"" + 
                    e.getActionCommand() + "\"");
                JMenuItem item = (JMenuItem)e.getSource();
                item.setEnabled(false);
            }
        });
        JMenuItem replaceItem = new JMenuItem("Replace");
        
        //Meniul Quit
        JMenuItem exitItem = new JMenuItem("Exit");
        JMenuItem aboutItem = new JMenuItem("About");
        
        openItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                FormularAplicatie frm = new FormularAplicatie();
                frm.setWindowType(FormularAplicatie.MODAL);
                frm.activate();                
            }
        });
        saveItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                FormularAplicatie frm = new FormularAplicatie();
                frm.setWindowType(FormularAplicatie.MODELESS);
                frm.activate();                    
            }
        });
        
        
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
        editMenu.add(new JCheckBoxMenuItem("Bifa"));
        quitMenu.add(exitItem);
        quitMenu.add(aboutItem);
        
        add(fileMenu);
        add(editMenu);
        add(quitMenu);
    }
}
