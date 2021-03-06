﻿"Filed out from Dolphin Smalltalk 7"!

IUnknown subclass: #IEnumXXXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
IEnumXXXX guid: (IID fromString: '{87B4C59F-026E-11D3-9FD7-00A0CC3E4A32}')!
IEnumXXXX isAbstract: true!
IEnumXXXX comment: ''!
!IEnumXXXX categoriesForClass!COM-Interfaces! !
!IEnumXXXX methodsFor!

batchSize
	"Answer the number of elements to retrive per hit. 
	Implementation Note: By default we retrieve 32 at a time to cut down the
	number of calls across the interface, but you may find that some IEnumXXXX
	implementations don't work correctly for more than one item at a time
	because VB only asks for one each time. If that is the case and a For..Each
	seems to work in VB, then try overriding this to answer 1. On the other hand
	if each Next call is very expensive (i.e. it is remote) then one can override
	to increase the batch size)."

	^32!

Clone: clone
	"Private - Invoke the IEnumXXXX::Clone() interface function."

	<virtual stdcall: hresult 7 lppvoid>
	^self invalidCall: _failureCode!

collect: transformer
	"Evaluate the <monadicValuable> argument, transformer, for each of the 
	receiver's elements in the order defined by the receiver's implementation of #do:.
	Answer a new <sequencedReadableCollection> containing the values returned by 
	transformer on each evaluation."

	| answer |
	answer := OrderedCollection new.
	self do: [ :each | answer addLast: (transformer value: each) ].
	^answer
!

contents
	"Answer a <sequencedReadableCollection> containing all of the elements of the 
	receiver." 

	self reset.	
	^self upToEnd!

copy
	"Answer a new enumerator of the same class as the receiver enumerating
	over the same elements."

	| clone |
	clone := super copy.
	clone beNullPointer.
	self Clone: clone.
	^clone!

do: operation
	"Evaluate the <monadicValuable> argument, transformer, for each element 
	in the receiver's stream of elements."

	self reset.
	^self upToEndDo: operation!

elementClass
	"Private - Answer the class of element enumerated by the receiver."

	^self class elementClass!

errorEndOfStream
	"Raise an error to the effect that an attempt was made to read off the
	end of the collection over which the receiver is streaming."

	^Stream endOfStreamSignal signal: self!

newElement
	"Private - Answer a new, empty, object to hold an element enumerated from the receiver."

	^self elementClass newBuffer!

newElements: count
	"Private - Answer a new, empty, <ExternalArray> of sufficient size to hold <integer>, count, elements
	enumerated from the receiver."

	^StructureArray length: count elementClass: self elementClass!

next
	"Answer the next element from the receiver.	 
	Raise an EndOfStream exception if there are no more elements."

	| element |
	element := self nextAvailable.
	^element ifNil: [self errorEndOfStream]!

next: anInteger
	"Answer a collection of the next anInteger elements from the receiver.
	Raise an EndOfStream exception if anInteger elements are not available."

	| elements |
	elements := self nextAvailable: anInteger.
	^elements size = anInteger
		ifTrue: [elements]
		ifFalse: [self errorEndOfStream]!

Next: next rgelt: rgelt pceltFetched: pceltFetched
	"Private - Invoke the IEnumXXXX::Next() interface function."

	<virtual stdcall: hresult 4 dword lpvoid dword*>
	^self invalidCall: _failureCode!

nextAvailable
	"Answer the next element from the receiver, or nil if there are
	no more elements."

	| element fetched |
	element := self newElement.
	fetched := DWORDBytes new.
	self Next: 1 rgelt: element pceltFetched: fetched.
	^fetched asInteger == 1
		ifTrue: [element]!

nextAvailable: anInteger 
	"Answer a collection of the next anInteger elements from the receiver,
	or as many as remain if fewer."

	| elements fetched |
	elements := self newElements: anInteger.
	fetched := DWORDBytes new.
	self 
		Next: anInteger
		rgelt: elements
		pceltFetched: fetched.
	^elements length: fetched asInteger!

position: offset
	"Set the current position of the receiver in the enumeration.
	Note that the argument is a zero-based offset from the start of the stream.
	Raise a BoundsError if the specified index is out of bounds.
	Implementation Note: IEnums allow one to seek to one position past the last
	element, and #nextAvailable will then answer nil. This is not 100% compatible 
	with the normal PositionableStream behavior. Since it is necessary to reposition
	within the stream by skipping to the start of the enumeration and then moving to
	the absolute position, performance for random access will vary depending on
	the underlying implementation of the enumeration."

	self reset.
	(offset == 0 or: [self skip: offset]) 
		ifFalse: [self errorSubscriptBounds: offset]!

printContentsOn: aStream
	| tooMany |
	tooMany := aStream position + #() maxPrint.
	self do: 
			[:each | 
			aStream position > tooMany 
				ifTrue: 
					[aStream nextPutAll: '... etc ...'.
					^self].
			aStream print: each]!

reset
	"Reset the receiver to the beginning of the 'stream'. Answer the receiver."

	self Reset!

Reset
	"Private - Invoke the IEnumXXXX::Reset() interface function."

	<virtual stdcall: hresult 6>
	^self invalidCall: _failureCode!

select: discriminator
	"Evaluate the <monadicValuable> argument, discriminator, for each of the receiver's elements.
	Answer a new <sequencedReadableCollection> containing only those elements for which 
	the discriminator evaluates to true."

	| answer |
	answer := OrderedCollection new.
	self do: [:each | (discriminator value: each) ifTrue: [answer addLast: each]].
	^answer
!

skip: anInteger
	"Advance the receiver's position in the stream by anInteger elements.
	Answer whether the request was successful (e.g. an attempt to advance beyond the
	end of the enumeration will answer false).
	Implementation Note: Only advancement is possible (Skip() takes an unsigned argument.
	In order to perform negative skips we would have to reset the current position and
	reset, then skip forward as appropriate).
	This is not 100% compatible with PositionableStream>>skip: as it cannot skip backwards
	and does not handle attempts to skip beyond the end of the stream in the same way."

	^(self Skip: anInteger) == S_OK!

Skip: skip
	"Private - Invoke the IEnumXXXX::Skip() interface function."

	<virtual stdcall: hresult 5 dword>
	^self invalidCall: _failureCode!

upToEnd
	"Answer a collection consisting of the remaining elements in the receiver (i.e. from the current
	position to the end)."

	| elements |
	elements := OrderedCollection new.
	self upToEndDo: [:e | elements addLast: e].
	^elements!

upToEndDo: operation
	"Private - Evaluate the <monadicValuable> argument, transformer, for 
	each of the remaining elements of the receiver.
	Implementation Note: To reduce round trips to the server object, the elements
	are fetched in blocks of <N> at a time, where N is configurable. Note that we
	stop enumerating when the object returns fewer elements than we ask for, since
	it seems that some objects have a bug whereby they will restart the enumerator
	after having read off the end. See #batchSize for further information."

	| count |
	count := self batchSize.
	
	[| elems |
	elems := self nextAvailable: count.
	elems do: [:e | operation value: e].
	elems size < count] 
			whileFalse! !
!IEnumXXXX categoriesFor: #batchSize!constants!public! !
!IEnumXXXX categoriesFor: #Clone:!COM Interfaces-IEnumXXXX!primitives!private! !
!IEnumXXXX categoriesFor: #collect:!enumerating!public! !
!IEnumXXXX categoriesFor: #contents!accessing!public! !
!IEnumXXXX categoriesFor: #copy!copying!public! !
!IEnumXXXX categoriesFor: #do:!enumerating!public! !
!IEnumXXXX categoriesFor: #elementClass!constants!private! !
!IEnumXXXX categoriesFor: #errorEndOfStream!exceptions!public! !
!IEnumXXXX categoriesFor: #newElement!helpers!private! !
!IEnumXXXX categoriesFor: #newElements:!helpers!private! !
!IEnumXXXX categoriesFor: #next!accessing!public! !
!IEnumXXXX categoriesFor: #next:!accessing!public! !
!IEnumXXXX categoriesFor: #Next:rgelt:pceltFetched:!COM Interfaces-IEnumXXXX!primitives!private! !
!IEnumXXXX categoriesFor: #nextAvailable!accessing!public! !
!IEnumXXXX categoriesFor: #nextAvailable:!accessing!public! !
!IEnumXXXX categoriesFor: #position:!positioning!public! !
!IEnumXXXX categoriesFor: #printContentsOn:!printing!private! !
!IEnumXXXX categoriesFor: #reset!positioning!public! !
!IEnumXXXX categoriesFor: #Reset!COM Interfaces-IEnumXXXX!primitives!private! !
!IEnumXXXX categoriesFor: #select:!enumerating!public! !
!IEnumXXXX categoriesFor: #skip:!positioning!public! !
!IEnumXXXX categoriesFor: #Skip:!COM Interfaces-IEnumXXXX!primitives!private! !
!IEnumXXXX categoriesFor: #upToEnd!accessing!public! !
!IEnumXXXX categoriesFor: #upToEndDo:!helpers!private! !

IEnumXXXX methodProtocol: #IEnumXXXX attributes: #() selectors: #(#Clone: #Next:rgelt:pceltFetched: #Reset #Skip:)!

!IEnumXXXX class methodsFor!

defineFunctions
	"Define the vtable for the IEnumXXXX interface. The vtable is common, but
	the type of element enumerated is different for each subclass.

		IEnumXXXX compileFunctions
	"	

	self
		defineFunction: #Next:rgelt:pceltFetched: 
			argumentTypes: 'dword void* dword*';
		defineFunction: #Skip: 
			argumentTypes: 'dword';
		defineFunction: #Reset;
		defineFunction: #Clone: 
			argumentTypes: 'void**'
!

elementClass
	"Private - Answer the class of element enumerated by the receiver."

	^self subclassResponsibility
! !
!IEnumXXXX class categoriesFor: #defineFunctions!initializing!public! !
!IEnumXXXX class categoriesFor: #elementClass!constants!private! !

