"Filed out from Dolphin Smalltalk 7"!

Kernel.StTagNode subclass: #'Kernel.StAnnotationNode'
	instanceVariableNames: 'selector'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Kernel.StAnnotationNode guid: (Core.GUID fromString: '{e65cb014-8373-4447-9994-f337d37f7544}')!
Kernel.StAnnotationNode comment: ''!
!Kernel.StAnnotationNode categoriesForClass!System-Compiler! !
!Kernel.StAnnotationNode methodsFor!

acceptVisitor: aProgramNodeVisitor
	^aProgramNodeVisitor visitAnnotationNode: self!

selector
	^selector!

selector: anObject
	selector := anObject! !
!Kernel.StAnnotationNode categoriesFor: #acceptVisitor:!public!visitor! !
!Kernel.StAnnotationNode categoriesFor: #selector!accessing!public! !
!Kernel.StAnnotationNode categoriesFor: #selector:!accessing!public! !

!Kernel.StAnnotationNode class methodsFor!

selector: aString
	^self new
		selector: aString;
		yourself! !
!Kernel.StAnnotationNode class categoriesFor: #selector:!accessing!public! !

