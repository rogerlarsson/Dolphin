"Filed out from Dolphin Smalltalk 7"!

STON.Tests.TestUser subclass: #'STON.Tests.TestUser2'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
STON.Tests.TestUser2 guid: (Core.GUID fromString: '{2b83d7a9-b33a-4c5e-a872-6a271dcf9f7e}')!
STON.Tests.TestUser2 comment: 'STONTestUser2 extends STONTestUser with explicit implementations of #fromSton: and #stonOn:'!
!STON.Tests.TestUser2 categoriesForClass!STON-Tests-Base! !
!STON.Tests.TestUser2 methodsFor!

fromSton: stonReader
	stonReader parseMapDo: [ :key :value |
		key = #username ifTrue: [ username := value ].
		key = #password ifTrue: [ password := value ].
		key = #enabled ifTrue: [ enabled := value ] ]
	!

stonOn: stonWriter	
	stonWriter writeObject: self streamMap: [ :dictionary |
		dictionary
			at: #username put: username;
			at: #password put: password;
			at: #enabled put: enabled ]! !
!STON.Tests.TestUser2 categoriesFor: #fromSton:!public!ston/core! !
!STON.Tests.TestUser2 categoriesFor: #stonOn:!public!ston/core! !

!STON.Tests.TestUser2 class methodsFor!

stonName
	^ #TestUser2! !
!STON.Tests.TestUser2 class categoriesFor: #stonName!public!ston/core! !

