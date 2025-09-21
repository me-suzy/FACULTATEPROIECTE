Ch10Update contains an update to the PrintDemo.scx form that uses the Windows Script Host to allow the user to select the Windows default printer. The problem with the original code occurs when there are network printers in the combo box. Because network printers begin with a backslash, they are disabled in the combo box and cannot be selected. The new version of the form resolves this problem.

