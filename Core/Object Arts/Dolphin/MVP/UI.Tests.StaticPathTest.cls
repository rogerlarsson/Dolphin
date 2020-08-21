"Filed out from Dolphin Smalltalk 7"!

UI.Tests.PresenterTest subclass: #'UI.Tests.StaticPathTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Tests.StaticPathTest guid: (Core.GUID fromString: '{50b65118-29ff-4b14-b17a-56e21a6fefca}')!
UI.Tests.StaticPathTest comment: ''!
!UI.Tests.StaticPathTest categoriesForClass!Unclassified! !
!UI.Tests.StaticPathTest methodsFor!

classToTest
	^StaticPath!

testLayout
	| preferredExtent actualExtent displayedText |
	presenter model value: 'c:\program files\dir1\dir2\dir3\dir4\file.txt'.
	preferredExtent := presenter calculateExtent.
	actualExtent := presenter extent.
	"If this fires test won't work because there isn't enough text to require ellipses"
	self assert: actualExtent x < preferredExtent x.
	displayedText := presenter getWindowText.
	self deny: (displayedText indexOfSubCollection: '...') identicalTo: 0.
	presenter topShell extent: (presenter topShell calcExtentFromClientExtent: preferredExtent).
	presenter ensureLayoutValid.
	displayedText := presenter getWindowText.
	self assert: (displayedText indexOfSubCollection: '...') identicalTo: 0! !
!UI.Tests.StaticPathTest categoriesFor: #classToTest!helpers!private! !
!UI.Tests.StaticPathTest categoriesFor: #testLayout!public!unit tests! !

