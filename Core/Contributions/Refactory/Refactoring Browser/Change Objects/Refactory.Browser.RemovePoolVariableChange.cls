"Filed out from Dolphin Smalltalk 7"!

Refactory.Browser.RefactoryVariableChange subclass: #'Refactory.Browser.RemovePoolVariableChange'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Refactory.Browser.RemovePoolVariableChange guid: (Core.GUID fromString: '{dc8b3bc9-6d9d-4e17-aa32-596044261886}')!
Refactory.Browser.RemovePoolVariableChange comment: ''!
!Refactory.Browser.RemovePoolVariableChange categoriesForClass!Refactory-Change Objects! !
!Refactory.Browser.RemovePoolVariableChange methodsFor!

asUndoOperation
	^AddNamespaceImportChange add: variable to: self changeClass!

changeObject
	| dictionary |
	dictionary := variable isString 
				ifTrue: [variable asQualifiedReference value]
				ifFalse: [variable].
	^dictionary!

changesFileTemplate
	^'<1p> <2s> <3s>'!

changeString
	^'Remove pool variable named, <1s>, from <2s>' expandMacrosWith: self variable
		with: self displayClassName!

changeSymbol
	^#removeSharedPool:!

printOn: aStream 
	aStream
		nextPutAll: self displayClassName;
		nextPutAll: ' removeSharedPool: ';
		nextPutAll: self variable;
		nextPut: $!!!

variable
	^variable isString
		ifTrue: [variable]
		ifFalse: [Smalltalk keyAtValue: variable ifAbsent: [self error: 'Cannot find value']]! !
!Refactory.Browser.RemovePoolVariableChange categoriesFor: #asUndoOperation!converting!public! !
!Refactory.Browser.RemovePoolVariableChange categoriesFor: #changeObject!private! !
!Refactory.Browser.RemovePoolVariableChange categoriesFor: #changesFileTemplate!constants!private! !
!Refactory.Browser.RemovePoolVariableChange categoriesFor: #changeString!printing!public! !
!Refactory.Browser.RemovePoolVariableChange categoriesFor: #changeSymbol!private! !
!Refactory.Browser.RemovePoolVariableChange categoriesFor: #printOn:!printing!public! !
!Refactory.Browser.RemovePoolVariableChange categoriesFor: #variable!accessing!private! !

