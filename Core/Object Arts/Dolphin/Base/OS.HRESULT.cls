﻿"Filed out from Dolphin Smalltalk 7"!

External.Integer subclass: #'OS.HRESULT'
	instanceVariableNames: ''
	classVariableNames: 'Facilities Fail'
	imports: #(#{OS.Win32Constants} #{OS.Win32Errors} #{OS.FacilityCodes})
	classInstanceVariableNames: ''
	classConstants: {
		'FACILITY_NT_BIT' -> 16r10000000
	}!
OS.HRESULT guid: (Core.GUID fromString: '{87b4c5ae-026e-11d3-9fd7-00a0cc3e4a32}')!
OS.HRESULT comment: ''!
!OS.HRESULT categoriesForClass!External-Data-Unstructured! !
!OS.HRESULT methodsFor!

asSignedInteger
	"Answer the signed 32-bit <Integer> value of the receiver."

	^bytes sdwordAtOffset: 0!

asUnsignedInteger
	"Answer the unsigned 32-bit <Integer> value of the receiver."

	^bytes dwordAtOffset: 0!

displayOn: aPuttableStream
	"Append to the <puttableStream> argument a String whose characters are a representation of the receiver that an end-user might want to see."

	"Implementation note: We have to reduce the provided Locale to its primary because the system message text is only available in a limited range of languages, and for most locale's the FormatMessage from system operation will fail."

	| buf len flags hModule code lcid |
	buf := Utf16String newFixed: 255.
	flags := ##(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS).
	code := self asInteger.
	hModule := (code allMask: FACILITY_NT_BIT)
				ifTrue: 
					[flags := flags bitOr: FORMAT_MESSAGE_FROM_HMODULE.
					code := code bitAnd: ##(FACILITY_NT_BIT bitInvert).
					NTLibrary default asParameter asInteger].
	lcid := aPuttableStream locale primary lcid.
	
	[len := KernelLibrary default
				formatMessage: flags
				lpSource: hModule
				dwMessageId: code
				dwLanguageId: lcid
				lpBuffer: buf
				nSize: buf size + 1
				arguments: 0.
	len == 0 and: [lcid ~~ 0]]
			whileTrue: 
				["If it fails for the primary of the supplied Locale, try with default"
				lcid := 0].
	len == 0
		ifTrue: 
			[aPuttableStream
				nextPutAll: 'Unrecognised ';
				nextPutAll: (self isNtStatus ifTrue: ['NTSTATUS'] ifFalse: ['HRESULT']);
				nextPutAll: ' - ';
				nextPutAll: (self asUnsignedInteger printStringRadix: 16)]
		ifFalse: 
			["Windows appends trailing line delimiter, and breaks up the text into lines too, 
			so we remove them."
			((buf resize: len) lines reject: [:each | each isEmpty])
				do: [:each | aPuttableStream nextPutAll: each]
				separatedBy: [aPuttableStream space]]!

errorCode
	"Answer the Win32 status code extracted from the receiver's code."

	^self asUnsignedInteger maskClear: ##(8191 bitShift: 16)!

facility
	"Answer a string describing the facility of the receiver's HRESULT code."

	^Facilities at: self facilityCode ifAbsent: ['Unknown facility']!

facilityCode
	"Answer the Win32 facility code extracted from the receiver's code.

		#define HRESULT_FACILITY(hr)  (((hr) >> 16) & 0x1fff)"

	^(bytes wordAtOffset: 2) bitAnd: 16r1FFF!

failed
	"Answer whether the receiver represents the result of a failed operation
	(named for compatibility with the C/C++ FAILED macro)."

	^(bytes at: 4) anyMask: 16r80!

isNtStatus
	"Answer whether the receiver represents an NTSTATUS code."

	"Equivalent to:
		^self asUnsignedInteger allMask: FACILITY_NT_BIT"

	^(bytes at: 4) allMask: 16r10!

isSeverityError
	"Answer whether the receiver is a SEVERITY_ERROR code."

	^self severity == SEVERITY_ERROR!

printOn: aStream
	"Append a debug textual representation of the receiver to aStream."

	aStream
		basicPrint: self;
		nextPutAll: '(0x'.
	self asUnsignedInteger printOn: aStream base: 16 showRadix: false.
	aStream
		nextPutAll: ' - ';
		display: self;
		nextPut: $)!

severity
	"Answer the severity of the HRESULT (1 for errors, otherwise 0)."

	^(bytes at: 4) bitShift: -7!

statusCode
	"Answer the Win32 status code extracted from the receiver.

		#define HRESULT_CODE(hr)	((hr) & 0xFFFF)"

	^bytes wordAtOffset: 0!

succeeded
	"Answer whether the receiver represents the result of a successful operation
	(named for compatibility with the C/C++ SUCCEEDED macro)."

	^self failed not!

unsignedValue: anUnsigned
	"Set the receiver's value field to the value of the unsigned positive
	integer, anUnsigned."

	bytes dwordAtOffset: 0 put: anUnsigned!

value
	"Answer the <Integer> value of the receiver's 'value' field."

	^bytes sdwordAtOffset: _OffsetOf_value!

value: anInteger
	"Set the receiver's 'value' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: _OffsetOf_value put: anInteger! !
!OS.HRESULT categoriesFor: #asSignedInteger!converting!public! !
!OS.HRESULT categoriesFor: #asUnsignedInteger!converting!public! !
!OS.HRESULT categoriesFor: #displayOn:!displaying!public! !
!OS.HRESULT categoriesFor: #errorCode!accessing!public! !
!OS.HRESULT categoriesFor: #facility!accessing!public! !
!OS.HRESULT categoriesFor: #facilityCode!accessing!public! !
!OS.HRESULT categoriesFor: #failed!public!testing! !
!OS.HRESULT categoriesFor: #isNtStatus!public!testing! !
!OS.HRESULT categoriesFor: #isSeverityError!public!testing! !
!OS.HRESULT categoriesFor: #printOn:!displaying!public! !
!OS.HRESULT categoriesFor: #severity!accessing!public! !
!OS.HRESULT categoriesFor: #statusCode!accessing!public! !
!OS.HRESULT categoriesFor: #succeeded!public!testing! !
!OS.HRESULT categoriesFor: #unsignedValue:!accessing!public! !
!OS.HRESULT categoriesFor: #value!**compiled accessors**!public! !
!OS.HRESULT categoriesFor: #value:!**compiled accessors**!public! !

!OS.HRESULT class methodsFor!

decodePrimitiveFailureCode: anInteger
	"Private - Answer an <integer> instantiated from the NTSTATUS/HRESULT code packed into a primitive failure code.
	The VM packs such codes into a SmallInteger primitive failure code by stripping out bit 27, which is not used."

	^((anInteger bitShift: 1) bitAnd: -16r10000000) bitOr: (anInteger bitAnd: 16r7FFFFFF)!

defineFields
	"Define the fields of the ExternalInteger 'structure'. ExternalInteger subclasses
	have a single value."

	self defineField: #value type: SDWORDField new beOverride!

fail
	"Answer the generic failure HRESULT."

	^Fail!

fromPrimitiveFailureCode: anInteger
	"Answer a new instance of the receiver representing the packed-HRESULT primitive failure code, anInteger.
	Packed HRESULT codes are created by the VM to pack a 32-bit HRESULT into a 31-bit SmallInteger by dropping an unused bit (27)."

	^self new value: (self decodePrimitiveFailureCode: anInteger)!

fromUnsignedInteger: anUnsignedInteger
	"Answer a new instance of the receiver with contents copied from anInteger"

	^self new unsignedValue: anUnsignedInteger!

initialize
	"Private - Initialize the receiver's class variables.
		self initialize
	"

	Fail := self fromInteger: E_FAIL.
	Facilities := LookupTable new.
	FacilityCodes bindingsDo: [:each | self registerFacility: each value name: each key].
	self registerFacility: FACILITY_NT_BIT >> 16 name: 'NTSTATUS'!

notImplemented
	"Answer the 'not implemented' HRESULT."

	^self fromInteger: E_NOTIMPL!

ntStatusCode: anInteger
	"Make and answer an HRESULT from the NT status code, anInteger."

	^self fromUnsignedInteger: (anInteger bitOr: FACILITY_NT_BIT)!

ok
	"Answer the 'OK' HRESULT."

	^self fromInteger: S_OK!

registerFacility: anInteger name: aString 
	"Register the specified facility code name for the specified facility code"

	Facilities at: anInteger put: aString!

severity: sev facility: fac code: code
	"Private - Make and answer an HRESULT from the arguments."

	^self fromUnsignedInteger: (
		((sev bitAnd: 1) bitShift: 31) bitOr:
			(((fac bitAnd: 16r1FFF) bitShift: 16) bitOr: (code bitAnd: 16rFFFF)))
!

status: code facility: fac
	"Private - Make and answer an HRESULT from the arguments."

	^self severity: SEVERITY_ERROR facility: fac code: code!

unregisterFacility: anInteger 
	"Unregister the specified facility code name for the specified facility code"

	Facilities removeKey: anInteger ifAbsent: []!

win32Error: anInteger 
	^self 
		severity: SEVERITY_ERROR
		facility: FACILITY_WIN32
		code: anInteger! !
!OS.HRESULT class categoriesFor: #decodePrimitiveFailureCode:!private!utilities! !
!OS.HRESULT class categoriesFor: #defineFields!public!template definition! !
!OS.HRESULT class categoriesFor: #fail!constants!instance creation!public! !
!OS.HRESULT class categoriesFor: #fromPrimitiveFailureCode:!instance creation!public! !
!OS.HRESULT class categoriesFor: #fromUnsignedInteger:!instance creation!public! !
!OS.HRESULT class categoriesFor: #initialize!development!initializing!private! !
!OS.HRESULT class categoriesFor: #notImplemented!constants!instance creation!public! !
!OS.HRESULT class categoriesFor: #ntStatusCode:!instance creation!public! !
!OS.HRESULT class categoriesFor: #ok!constants!instance creation!public! !
!OS.HRESULT class categoriesFor: #registerFacility:name:!public! !
!OS.HRESULT class categoriesFor: #severity:facility:code:!instance creation!private! !
!OS.HRESULT class categoriesFor: #status:facility:!instance creation!private! !
!OS.HRESULT class categoriesFor: #unregisterFacility:!public! !
!OS.HRESULT class categoriesFor: #win32Error:!instance creation!public! !
