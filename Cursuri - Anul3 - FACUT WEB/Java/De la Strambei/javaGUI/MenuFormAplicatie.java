/*
 * MenuForm.java
 *
 * Created on 10 mai 2003, 14:56
 */

/**
 * 1.Fa-ti panourile
 * 2.Fa-ti meniurile
 * 3.Creeaza fereastra principala a aplicatiei
 * 4.Lanseaza formarele tranzactionale astfel:
 *  - selectie optiune/meniu sau alt element de lansare
 *  - instantiaza un JFrame, JInternalFrame, JDialog
 *  - adauga drept getContentPane() panourile construite initial
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
public class MenuFormAplicatie extends JFrame{
//public class MenuForm extends JDesktopPane{
    JDesktopPane pane = new JDesktopPane();
    JLayeredPane jlpane = new JLayeredPane();    
    /** Creates a new instance of MenuForm */
    public MenuFormAplicatie() {
        JMenuBar baraMenu = new JMenuBar();
        JMenu fileMenu = new JMenu("File");
        JMenu editMenu = new JMenu("Edit");
        JMenu quitMenu = new JMenu("Quit");
        
        // Meniul File: Open, Save, Close
        JMenuItem openItem = new JMenuItem("Open");
//        openItem.addActionListener(new ActionListener(){
//            public void actionPerformed(ActionEvent e){
//                JInternalFrame form2 = new FormIntern();
//                jlpane.add(form2);
//                jlpane.repaint();
//                //pane.add(form2);
//                form2.show();
//                jlpane.repaint();
//            }
//        });        
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
        exitItem.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                System.exit(0);
            }
        });
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
        editMenu.add(new JCheckBox("Bifa"));
        quitMenu.add(exitItem);
        quitMenu.add(aboutItem);
        
        baraMenu.add(fileMenu);
        baraMenu.add(editMenu);
        baraMenu.add(quitMenu);
        
        this.getRootPane().setJMenuBar(baraMenu);
        
        pane.add(jlpane);
        
        this.getContentPane().add(pane, BorderLayout.CENTER);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setSize(400, 300);
        JDialog dialog = new JDialog();
        
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        }catch(Exception ex){
            System.out.println("Nu pot afisa look and feel-ul !");
        }         
        new MenuFormAplicatie().setVisible(true);
    }
    
}

