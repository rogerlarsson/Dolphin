"Filed out from Dolphin Smalltalk 7"!

External.Scalar subclass: #'External.Integer'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
External.Integer guid: (Core.GUID fromString: '{87b4c594-026e-11d3-9fd7-00a0cc3e4a32}')!
External.Integer isNonInstantiable: true!
External.Integer comment: 'ExternalInteger is an abstract class of ExternalStructures to represent machine native integer formats. Various subclasses are defined to represent the signed and unsigned forms with varying numbers of bits:

8-bit
	signed	SBYTE
	unsigned	BYTE
16-bit
	signed	SWORD
	unsigned	WORD
32-bit
	signed	SDWORD
	unsigned	DWORD
64-bit
	signed	LARGE_INTEGER
	unsigned	ULARGE_INTEGER
'!
!External.Integer categoriesForClass!External-Data-Unstructured! !
!External.Integer methodsFor!

asInteger
	"Answer the Integer value of the receiver, signed or
	unsigned depending on the subclass"

	^self value!

asSignedInteger
	"Answer the signed <Integer> value of the receiver."

	^self subclassResponsibility!

asString
	"Answer the String representation of the receiver."

	^self asInteger displayString!

asUIntPtr
	"Answer the receiver in a form suitable for passing/returning as a Windows LRESULT
	(32 or 64-bit, depending on host OS) return value. The default is self (which will cause the
	default window proc. of the window to be called for most objects other than Integers when
	used as a return value)."

	^self value!

asUnsignedInteger
	"Answer the unsigned <Integer> value of the receiver.
	This can be useful where unsigned values are stored in signed values."

	^self subclassResponsibility!

hash
	"Answer the SmallInteger hash value for the receiver."

	^self value hash!

isNull
	"Answer whether the receiver is Null (i.e. equal to 0). 
	This message is useful way of testing for NULL pointers or handles."

	^super isNull or: [self value == 0]! !
!External.Integer categoriesFor: #asInteger!converting!public! !
!External.Integer categoriesFor: #asSignedInteger!converting!public! !
!External.Integer categoriesFor: #asString!converting!public! !
!External.Integer categoriesFor: #asUIntPtr!converting!public! !
!External.Integer categoriesFor: #asUnsignedInteger!converting!public! !
!External.Integer categoriesFor: #hash!comparing!public! !
!External.Integer categoriesFor: #isNull!public!testing! !

!External.Integer class methodsFor!

decompileDefinition
	"Don't allow the receiver and its subclasses to be decompiled since they are
	required by fundamental aspects of the system such as streaming"
	!

defineTemplate
	"Initialize the receiver class' structure template."

	super defineTemplate.
	alignment := self elementSize!

fromInteger: anInteger
	"Answer a new instance of the receiver with contents copied from anInteger"

	^self new value: anInteger!

newInstanceAspect: aSymbol class: aspectClass 
	"Private - Answer a new <Aspect> of the class, aspectClass, and with name, aSymbol, 
    	which is appropriate for representing aspects of the receiver's type."

	^aspectClass integer: aSymbol! !
!External.Integer class categoriesFor: #decompileDefinition!public! !
!External.Integer class categoriesFor: #defineTemplate!public!template definition! !
!External.Integer class categoriesFor: #fromInteger:!instance creation!public! !
!External.Integer class categoriesFor: #newInstanceAspect:class:!adapters!private! !

