"Filed out from Dolphin Smalltalk 7"!

StTagNode subclass: #StAnnotationNode
	instanceVariableNames: 'selector'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
StAnnotationNode guid: (GUID fromString: '{e65cb014-8373-4447-9994-f337d37f7544}')!
StAnnotationNode comment: ''!
!StAnnotationNode categoriesForClass!System-Compiler! !
!StAnnotationNode methodsFor!

acceptVisitor: aProgramNodeVisitor
	^aProgramNodeVisitor visitAnnotationNode: self!

selector
	^selector!

selector: anObject
	selector := anObject! !
!StAnnotationNode categoriesFor: #acceptVisitor:!public!visitor! !
!StAnnotationNode categoriesFor: #selector!accessing!public! !
!StAnnotationNode categoriesFor: #selector:!accessing!public! !

!StAnnotationNode class methodsFor!

selector: aString
	^self new
		selector: aString;
		yourself! !
!StAnnotationNode class categoriesFor: #selector:!accessing!public! !

