﻿"Filed out from Dolphin Smalltalk 7"!

Core.Tests.DolphinTest subclass: #'External.Tests.StructureTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
External.Tests.StructureTest guid: (Core.GUID fromString: '{a9244232-e68c-4a65-bbf2-c8392aee459b}')!
External.Tests.StructureTest comment: 'SUnitBrowser openOnTestCase: self'!
!External.Tests.StructureTest categoriesForClass!Unclassified! !
!External.Tests.StructureTest methodsFor!

testCompileDefinition
	"Test that compiling structure fields defines the right set of accessors:
		- get selector for read-only fields
		- set selector for write-only fields
		- get and set selectors for normal fields
		- no selectors for filler fields."

	| subject |
	subject := Structure newAnonymousSubclass.
	subject class
		compile: 'defineFields
	self
		defineField: #a type: UINT_PTRField readOnly;
		defineField: #b type: DWORDField writeOnly;
		defineField: #c type: WORDField new;
		defineField: #d type: BYTEField filler'.
	subject compileDefinition.
	self assert: subject selectors asArray sort equals: #(#a #b: #c #c:).
	self assert: subject byteSize equals: 12!

testEquals
	| s1 s2 s3 s4 |
	s1 := FILETIME newPointer.
	s2 := FILETIME newPointer.
	self assert: s1 equals: s1.
	self assert: s1 equals: s2.
	s1 := FILETIME fromInteger: 1234.
	self deny: s1 equals: s2.
	self assert: s1 equals: s1.
	s3 := FILETIME fromAddress: s1 yourAddress.
	self assert: s3 equals: s3.
	self assert: s1 equals: s3.
	self deny: s2 equals: s3.
	self deny: s3 equals: s2.
	s2 := FILETIME fromInteger: 1234.
	self assert: s1 equals: s2.
	self assert: s2 equals: s1.
	self assert: s1 equals: s3.
	self assert: s3 equals: s1.
	self assert: s3 equals: s2.
	self assert: s2 equals: s3.
	s4 := FILETIME fromAddress: s2 yourAddress.
	self assert: s1 equals: s4.
	self assert: s4 equals: s1!

testExtendedErrorInfo
	"Tests that extended error info is accessed on failed external API calls through COM interfaces if the target object supports it."

	| script errorInfo error |
	script := Smalltalk.IScriptControl new.
	self assert: script supportsErrorInfo.
	errorInfo := [script eval: '1+2'] on: HRESULTError do: [:ex | ex errorInfo].
	self assert: errorInfo notNil.
	self assert: errorInfo source equals: 'ScriptControl'.
	self assert: errorInfo guid equals: Smalltalk.IScriptControl guid.
	script free.
	error := [script eval: '1+2'] on: HRESULTError do: [:ex | ex].
	self assertIsNil: error errorInfo.
	self assert: error hresult
		equals: (HRESULT fromPrimitiveFailureCode: _PrimitiveFailureCode.InvalidPointer)!

testIsNull
	| struct |
	self assert: FILETIME newPointer isNull.
	struct := FILETIME new.
	self assert: struct isNull not.
	struct bytes: 0.
	self assert: struct isNull.
	struct bytes: nil.
	self assert: struct isNull.
	struct bytes: Object new.
	self should: [struct isNull] raise: MessageNotUnderstood.
	struct bytes: ByteArray new.
	self assert: struct isNull not.
	struct bytes: External.Address new.
	self assert: struct isNull! !
!External.Tests.StructureTest categoriesFor: #testCompileDefinition!public!unit tests! !
!External.Tests.StructureTest categoriesFor: #testEquals!public!unit tests! !
!External.Tests.StructureTest categoriesFor: #testExtendedErrorInfo!public!unit tests! !
!External.Tests.StructureTest categoriesFor: #testIsNull!public!unit tests! !
