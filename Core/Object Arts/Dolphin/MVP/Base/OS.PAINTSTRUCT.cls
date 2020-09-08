﻿"Filed out from Dolphin Smalltalk 7"!

OS.Win32Structure subclass: #'OS.PAINTSTRUCT'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_fErase' -> 16r4.
		'_OffsetOf_fIncUpdate' -> 16r1C.
		'_OffsetOf_fRestore' -> 16r18.
		'_OffsetOf_hdc' -> 16r0.
		'_OffsetOf_rcPaint' -> 16r8.
		'_OffsetOf_rgbReserved' -> 16r20
	}!
OS.PAINTSTRUCT guid: (Core.GUID fromString: '{87b4c605-026e-11d3-9fd7-00a0cc3e4a32}')!
OS.PAINTSTRUCT comment: ''!
!OS.PAINTSTRUCT categoriesForClass!External-Data-Structured-Win32! !
!OS.PAINTSTRUCT methodsFor!

fErase
	"Answer the <Boolean> value of the receiver's 'fErase' field."

	^(bytes dwordAtOffset: _OffsetOf_fErase) asBoolean!

rcPaint
	"Answer the <RECT> value of the receiver's 'rcPaint' field."

	^RECT fromAddress: bytes yourAddress + _OffsetOf_rcPaint! !
!OS.PAINTSTRUCT categoriesFor: #fErase!**compiled accessors**!public! !
!OS.PAINTSTRUCT categoriesFor: #rcPaint!**compiled accessors**!public! !

!OS.PAINTSTRUCT class methodsFor!

defineFields
	"Define the Win32 PAINTSTRUCT structure.
		PAINTSTRUCT compileDefinition
	"

	self
		defineField: #hdc type: DWORDField readOnly beUncompiled;
		defineField: #fErase type: BOOLField readOnly;
		defineField: #rcPaint type: (StructureField type: RECT) beReadOnly;
		defineField: #fRestore type: BOOLField filler;
		defineField: #fIncUpdate type: BOOLField filler;
		defineField: #rgbReserved type: (ArrayField type: ByteArray length: 32) beFiller
	"Help file wrongly species 16 bytes, header file says 32"!

getFieldNames
	^#(#hdc #fErase #rcPaint)! !
!OS.PAINTSTRUCT class categoriesFor: #defineFields!public!template definition! !
!OS.PAINTSTRUCT class categoriesFor: #getFieldNames!**compiled accessors**!constants!private! !
