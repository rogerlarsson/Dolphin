"Filed out from Dolphin Smalltalk 7"!

STON.Tests.TestUser subclass: #'STON.Tests.TestUser3'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
STON.Tests.TestUser3 guid: (Core.GUID fromString: '{b5d23459-cf60-4402-97e1-6eba03cc0694}')!
STON.Tests.TestUser3 comment: 'STONTestUser3 extends STONTestUser but wants nil instance variables to be written'!
!STON.Tests.TestUser3 categoriesForClass!STON-Tests-Base! !
!STON.Tests.TestUser3 methodsFor!

stonShouldWriteNilInstVars
	^ true! !
!STON.Tests.TestUser3 categoriesFor: #stonShouldWriteNilInstVars!public!ston/core! !

!STON.Tests.TestUser3 class methodsFor!

stonAllInstVarNames
	^ #(username password enabled)!

stonName
	^ 'TestUser3'! !
!STON.Tests.TestUser3 class categoriesFor: #stonAllInstVarNames!public!ston/core! !
!STON.Tests.TestUser3 class categoriesFor: #stonName!public!ston/core! !

