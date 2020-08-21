"Filed out from Dolphin Smalltalk 7"!

External.Structure subclass: #'External.Size'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
External.Size guid: (Core.GUID fromString: '{6dbb8332-abe3-4ac8-9388-e209e560e8a3}')!
External.Size isNonInstantiable: true!
External.Size comment: '`SizeStructure` is the abstract class of structures representing a 2-dimensional extent. There are concrete subclasses for different types of width and height values used by different APIs.'!
!External.Size categoriesForClass!Win32-Structs! !
!External.Size methodsFor!

asObject
	"Answer a suitable Smalltalk object to represent the receiver's value, in this case
	a <Point>."

	^self asPoint!

asPoint
	"Answer a suitable Smalltalk object to represent the receiver's value, in this case
	a <Point>."

	^self width @ self height!

height
	^self subclassResponsibility!

height: anObject
	self subclassResponsibility!

width
	^self subclassResponsibility!

width: anObject
	self subclassResponsibility!

x
	^self width!

y
	^self height! !
!External.Size categoriesFor: #asObject!converting!public! !
!External.Size categoriesFor: #asPoint!converting!public! !
!External.Size categoriesFor: #height!accessing!public! !
!External.Size categoriesFor: #height:!accessing!public! !
!External.Size categoriesFor: #width!accessing!public! !
!External.Size categoriesFor: #width:!accessing!public! !
!External.Size categoriesFor: #x!accessing!public! !
!External.Size categoriesFor: #y!accessing!public! !

!External.Size class methodsFor!

fromPoint: aPoint 
	"Answer a new instance of the receiver representing the magnitude of aPoint."

	^self width: aPoint x height: aPoint y!

icon
	"Answer a suitable iconic representation for the receiver."

	^Graphics.Icon fromId: 'extent.ico'!

width: cx height: cy
	^self new
		width: cx;
		height: cy;
		yourself! !
!External.Size class categoriesFor: #fromPoint:!instance creation!public! !
!External.Size class categoriesFor: #icon!constants!public! !
!External.Size class categoriesFor: #width:height:!instance creation!public! !

