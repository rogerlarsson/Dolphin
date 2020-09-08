﻿"Filed out from Dolphin Smalltalk 7"!

Core.SharedLookupTable variableSubclass: #'Core.SharedIdentityDictionary'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Core.SharedIdentityDictionary guid: (Core.GUID fromString: '{87b4c531-026e-11d3-9fd7-00a0cc3e4a32}')!
Core.SharedIdentityDictionary comment: ''!
!Core.SharedIdentityDictionary categoriesForClass!Collections-Unordered! !
!Core.SharedIdentityDictionary methodsFor!

findKeyOrNil: anObject 
	"Private - This method is a copy of IdentityDictionary>>findKeyOrNil:"

	| capacity index |
	capacity := self basicSize.
	index := self hash: anObject max: capacity.
	
	[| key |
	(key := self basicAt: index) isNil or: [key == anObject]] 
			whileFalse: [index := index \\ capacity + 1].
	^index!

hash: anObject max: anInteger
	^anObject identityHash \\ anInteger + 1!

keysClass
	"Answer the class of Collection to be used for collecting the keys of the receiver"

	^IdentitySet!

searchPolicy
	"Answer the receiver's <searchPolicy>."

	^SearchPolicy identity! !
!Core.SharedIdentityDictionary categoriesFor: #findKeyOrNil:!private!searching! !
!Core.SharedIdentityDictionary categoriesFor: #hash:max:!private!searching! !
!Core.SharedIdentityDictionary categoriesFor: #keysClass!constants!public! !
!Core.SharedIdentityDictionary categoriesFor: #searchPolicy!constants!public! !
