"Filed out from Dolphin Smalltalk 7"!

Core.Tests.DolphinTest subclass: #'Refactory.Browser.AddMethodChangeTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Refactory.Browser.AddMethodChangeTest guid: (Core.GUID fromString: '{08457a65-10d4-409d-93df-440bce0fac93}')!
Refactory.Browser.AddMethodChangeTest comment: ''!
!Refactory.Browser.AddMethodChangeTest categoriesForClass!Unclassified! !
!Refactory.Browser.AddMethodChangeTest methodsFor!

changeClass
	^DolphinAddMethodChange!

testPrintOn
	| change |
	change := self changeClass
				compile: 'isAbstract ^false'
				in: Refactory.Browser.AddMethodChangeTest class
				classified: 'testing'.
	self assert: change printString readStream nextLine
		equals: '!!AddMethodChangeTest class methodsFor: ''testing''!!'.
	#'1593'.
	change protocols: #().
	self assertIsNil: change protocol.
	self assert: change printString readStream nextLine
		equals: '!!AddMethodChangeTest class methodsFor: ''''!!'! !
!Refactory.Browser.AddMethodChangeTest categoriesFor: #changeClass!public!unit tests! !
!Refactory.Browser.AddMethodChangeTest categoriesFor: #testPrintOn!public!unit tests! !

