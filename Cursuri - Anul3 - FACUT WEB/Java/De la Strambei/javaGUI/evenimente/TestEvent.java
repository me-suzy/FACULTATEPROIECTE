/*
 * Intermitent.java
 *
 * Created on May 13, 2004, 9:32 AM
 */

package javaGUI.evenimente;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/**
 *
 * @author  strimbeic
 */
class Intermitent extends JFrame {
  public Intermitent () {
    super("Intermitenta");
    JButton button = new JButton("Schimba");
    // Stabilesc fond rosu si font albastru
    button.setBackground(Color.red);
    button.setForeground(Color.blue);
    // Creez un obiect capabil sa trateze evenimente
    Comutator control = new Comutator();
    // Inregistrez obiectul creat anterior ca destinatie pentru evenimentele
    // generate de buton
    button.addActionListener(control);
    Container cp = this.getContentPane();
    // Adaug butonul la containerul JFrame prin intermediul content pane-ului sau
    cp.add(button, BorderLayout.CENTER);
    this.setSize(300, 200);
    // Afisez JFrame-ul
    this.setVisible(true);
  }
}

// Creez obiectul care receptioneaza si trateaza evenimentele butonului
// si fiindca este inregistrat prin metoda addActionListener, va
// receptiona evenimente din categoria ActionEvent, deci va fi obligat
// sa implementeze interfata ActionListener
class Comutator implements ActionListener{
// Interfata ActionListener obliga implementarea
// metodei actionPerformed(ActionEvent)
  public void actionPerformed(ActionEvent e){
// Tratarea evenimentului inseamna schimbarea colorii fondului
// cu cea a fontului, si invers
    Component sursa = (Component)e.getSource();
    Color prima = sursa.getForeground();
    sursa.setForeground(sursa.getBackground());
    sursa.setBackground(prima);
  }
}

// Clasa TestEvent va "produce" fereastra/cadrul Intermitent
// prin instantiere
public class TestEvent {
  public static void main(String[] args) {
    Intermitent i = new Intermitent();
  }
}

