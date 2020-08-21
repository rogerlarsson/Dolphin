"Filed out from Dolphin Smalltalk 7"!

External.Structure subclass: #'External.Point'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
External.Point guid: (Core.GUID fromString: '{5a0c3f56-8db8-4509-8563-3affe77805b2}')!
External.Point isNonInstantiable: true!
External.Point comment: '`PointStructure` is the abstract class of structures representing positions in a 2-dimensional space. There are concrete subclasses for different types of co-ordinate value.'!
!External.Point categoriesForClass!External-Data-Structured! !
!External.Point methodsFor!

asDword
	"Answer the receiver in a form suitable for passing or returning 
	as a 32-bit value (i.e. a 32-bit integer)."

	^(DWORD fromPoint: self) value!

asObject
	"Answer a suitable Smalltalk object to represent the receiver's value, in this case
	a <Point>."

	^self asPoint!

asPoint
	"Answer a Point created that matches the receiver"

	^self x @ self y!

asUIntPtr
	"Answer the receiver in a form suitable for passing or returning 
	as a  machine-word sized (32 or 64-bit) value."

	^self asPoint asUIntPtr!

value
	"Answer the receiver's value field as an equivalent Smalltalk object (a <Point>)."

	^self asPoint!

value: aPoint
	"Set the value buffered by the receiver to aPoint."

	self
		x: aPoint x;
		y: aPoint y!

x
	^self subclassResponsibility!

x: anObject
	self subclassResponsibility!

y
	^self subclassResponsibility!

y: anObject
	self subclassResponsibility! !
!External.Point categoriesFor: #asDword!converting!public! !
!External.Point categoriesFor: #asObject!converting!public! !
!External.Point categoriesFor: #asPoint!converting!public! !
!External.Point categoriesFor: #asUIntPtr!converting!public! !
!External.Point categoriesFor: #value!accessing!public! !
!External.Point categoriesFor: #value:!accessing!public! !
!External.Point categoriesFor: #x!accessing!public! !
!External.Point categoriesFor: #x:!accessing!public! !
!External.Point categoriesFor: #y!accessing!public! !
!External.Point categoriesFor: #y:!accessing!public! !

!External.Point class methodsFor!

fromPoint: aPoint
	"Answer a new instance of the receiver representing aPoint."
	
	^self x: aPoint x y: aPoint y!

getFieldNames
	^#(#x #y)!

icon
	"Answer a suitable iconic representation for the receiver."

	^Graphics.Point icon!

x: x y: y
	"Answer a new instance of the receiver representing the Point whose 
	cartesian coordinates are the arguments."

	^self basicNew
		x: x;
		y: y;
		yourself! !
!External.Point class categoriesFor: #fromPoint:!instance creation!public! !
!External.Point class categoriesFor: #getFieldNames!constants!private! !
!External.Point class categoriesFor: #icon!constants!development!public! !
!External.Point class categoriesFor: #x:y:!instance creation!public! !

