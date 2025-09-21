*** Get an object to test with
oTestObj = CREATEOBJECT( "form" )
oTestObj.Name = 'TestForm'
oTestObj.AddObject( 'cmd1', "CommandButton" )

*** What does _VFP tell us:
ACTIVATE SCREEN 
? _VFP.Objects.Count           && 1
? _VFP.Objects.Item[1].Name    && "testform"

*** How about _Screen
? _Screen.Objects.Count        && 1
? _Screen.Objects.Item[1].Name && ERROR!

*** And the form
? oTestObj.Objects.Count        && 1
? oTestObj.Objects.Item[1].Name && ERROR!

RELEASE oTestObj
