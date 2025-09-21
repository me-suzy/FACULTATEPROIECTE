Ch09Update.vcx does not replace all of the sample code in chapter 9. It is merely an update to the custom TreeView, ListView and ImageCombo classes and the sample forms for these controls. There were a couple of problems with the original classes in the book:

The custom classes were first level sub-classes of the controls without an insulation layer. This means that if Microsoft comes out with an updated version of these controls and the reader wants to update the classes to use the more current version, they will lose all of the custom properties and methods in the custom classes. The updated versions of these classes have an insulation layer. 

The original code used an underscore to separate the words that make up the keys for the members of the collections. 

This was a bad idea because an underscore is a legal character in a file name. So, if the underscore is a part of the name of a file that is used to populate the custom TreeView, ListView or ImageCombo classes in the book, the code breaks. The updated version is modified to use an asterisk instead. Since this is not a legal character in a file name, the code no longer breaks. 
