"Filed out from Dolphin Smalltalk 7"!

External.Structure subclass: #'External.Scalar'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_value' -> 16r0
	}!
External.Scalar guid: (Core.GUID fromString: '{704554ca-46f7-49b2-92df-edcbe398040a}')!
External.Scalar isNonInstantiable: true!
External.Scalar comment: ''!
!External.Scalar categoriesForClass!External-Data-Structured! !
!External.Scalar methodsFor!

= anObject
	"Answer whether the receiver is equivalent to anObject."

	^anObject = self value!

displayOn: aPuttableStream
	"Append to the <puttableStream> argument a String whose characters are a representation of the receiver that an end-user might want to see."

	(self isNull ifFalse: [self value]) displayOn: aPuttableStream!

value
	"Answer the receiver's value as a Smalltalk object of the appropriate scalar type for the subclass."

	^self subclassResponsibility!

value: anObject
	"Set the receiver's value field to the value of anObject."

	^self subclassResponsibility! !
!External.Scalar categoriesFor: #=!comparing!public! !
!External.Scalar categoriesFor: #displayOn:!printing!public! !
!External.Scalar categoriesFor: #value!converting!public! !
!External.Scalar categoriesFor: #value:!public! !

!External.Scalar class methodsFor!

defineFields
	self defineField: #value type: (FillerField byteSize: 0)!

getFieldNames
	^#(#value)! !
!External.Scalar class categoriesFor: #defineFields!public!template definition! !
!External.Scalar class categoriesFor: #getFieldNames!constants!private! !

