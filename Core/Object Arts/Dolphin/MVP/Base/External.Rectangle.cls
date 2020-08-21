"Filed out from Dolphin Smalltalk 7"!

External.Structure subclass: #'External.Rectangle'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
External.Rectangle guid: (Core.GUID fromString: '{e552b3f7-8653-46d4-b764-1e59cf1c15f7}')!
External.Rectangle isNonInstantiable: true!
External.Rectangle comment: '`RectangleStructure` is the abstract class of structures representing rectangular geometries. There are concrete subclasses for different types of position and extent values.'!
!External.Rectangle categoriesForClass!Win32-Structs! !
!External.Rectangle methodsFor!

area
	"Answer the area of the receiver; the product of width and height."

	^self width * self height!

asObject
	"Answer a suitable Smalltalk object to represent the receiver's value, in this case
	a <Rectangle>."

	^self asRectangle
!

asRectangle
	"Answer a new Rectangle that matches the receiver."

	^Graphics.Rectangle origin: self topLeft corner: self bottomRight!

bottom
	^self subclassResponsibility!

bottom: anObject
	self subclassResponsibility!

bottomRight
	"Answer a Point representing the bottom right position of the receiver."

	^self right @ self bottom!

center
	"Answer a <Point> representing the position of the centre of the receiver."

	^self centerX @ self centerY!

centerX
	"Answer the x-coordinate of the point at the receiver's centre. Used in conjunction with
	#centerX:"

	^(self left + self right) // 2!

centerY
	"Answer the y-coordinate of the point at the receiver's centre. Used in conjunction with
	#centerY:"

	^(self top + self bottom) // 2!

extent
	"Answer a Point representing the extent of the receiver. The x coordinate 
	is the width and the y coordinate is the height."

	^self width @ self height!

extent: newExtent
	"Set the extent of the receiver to aPoint. (The origin remains the same and
	the corner stays in the same quadrant it was in relative to the origin point.
	If aPoint contains any negative value, the result is undefined)."

	self right: self left + newExtent x.
	self bottom: self top + newExtent y!

height
	"Answer the height of the receiver."

	^self bottom - self top!

left
	^self subclassResponsibility!

left: anObject
	self subclassResponsibility!

origin
	"Answer the Point at the top left corner of the receiver"

	^self topLeft
!

right
	^self subclassResponsibility!

right: anObject
	self subclassResponsibility!

top
	^self subclassResponsibility!

top: anObject
	self subclassResponsibility!

topLeft
	"Answer a Point representing the top left position of the receiver."

	^self left @ self top!

width
	"Answer the width of the receiver."

	^self right - self left! !
!External.Rectangle categoriesFor: #area!accessing!public! !
!External.Rectangle categoriesFor: #asObject!converting!public! !
!External.Rectangle categoriesFor: #asRectangle!converting!public! !
!External.Rectangle categoriesFor: #bottom!accessing!public! !
!External.Rectangle categoriesFor: #bottom:!accessing!public! !
!External.Rectangle categoriesFor: #bottomRight!accessing!public! !
!External.Rectangle categoriesFor: #center!accessing!public! !
!External.Rectangle categoriesFor: #centerX!accessing!public! !
!External.Rectangle categoriesFor: #centerY!accessing!public! !
!External.Rectangle categoriesFor: #extent!accessing!public! !
!External.Rectangle categoriesFor: #extent:!accessing!public! !
!External.Rectangle categoriesFor: #height!accessing!public! !
!External.Rectangle categoriesFor: #left!accessing!public! !
!External.Rectangle categoriesFor: #left:!accessing!public! !
!External.Rectangle categoriesFor: #origin!accessing!public! !
!External.Rectangle categoriesFor: #right!accessing!public! !
!External.Rectangle categoriesFor: #right:!accessing!public! !
!External.Rectangle categoriesFor: #top!accessing!public! !
!External.Rectangle categoriesFor: #top:!accessing!public! !
!External.Rectangle categoriesFor: #topLeft!accessing!public! !
!External.Rectangle categoriesFor: #width!accessing!public! !

!External.Rectangle class methodsFor!

extent: aPoint
	^self
		left: 0
		top: 0
		width: aPoint x
		height: aPoint y!

fromRectangle: aRectangle
	"Answer a new instance of the receiver instantiated from the Smalltalk
	Rectangle, aRectangle."

	self == aRectangle class ifTrue: [^aRectangle].
	^self 
		left: aRectangle left
		top: aRectangle top
		right: aRectangle right
		bottom: aRectangle bottom
!

icon
	"Answer a suitable iconic representation for the receiver."

	^Graphics.Rectangle icon!

left: left top: top right: right bottom: bottom
	^self subclassResponsibility!

left: left top: top width: width height: height
	"Answer a new instance of the receiver with the specified position
	and dimensions."

	^self 
		left: left
		top: top
		right: left+width
		bottom: top+height
!

origin: originPoint extent: extentPoint
	"Answer a new instance of the receiver with the specified origin and extent"

	^self
		left: originPoint x
		top: originPoint y
		width: extentPoint x
		height: extentPoint y! !
!External.Rectangle class categoriesFor: #extent:!instance creation!public! !
!External.Rectangle class categoriesFor: #fromRectangle:!instance creation!public! !
!External.Rectangle class categoriesFor: #icon!constants!public! !
!External.Rectangle class categoriesFor: #left:top:right:bottom:!instance creation!public! !
!External.Rectangle class categoriesFor: #left:top:width:height:!instance creation!public! !
!External.Rectangle class categoriesFor: #origin:extent:!instance creation!public! !

