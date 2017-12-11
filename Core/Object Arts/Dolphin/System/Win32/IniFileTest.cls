"Filed out from Dolphin Smalltalk 7"!

DolphinTest subclass: #IniFileTest
	instanceVariableNames: 'iniFile'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
IniFileTest guid: (GUID fromString: '{5fc93855-8e32-4463-9906-50705ecb9acc}')!
IniFileTest comment: ''!
!IniFileTest categoriesForClass!Unclassified! !
!IniFileTest methodsFor!

fileResource
	^IniFileTestResource current!

makeEmptyIniFile
	^IniFile open: self fileResource emptyFile!

makeIniFile
	^IniFile open: self fileResource iniFile1!

makeModifiableIniFile
	iniFile := self fileResource fileLocator localFileSpecFor: self selector, '.ini'.
	File copy: self fileResource iniFile1 to: iniFile.
	^IniFile open: iniFile!

tearDown
	(iniFile notNil and: [File exists: iniFile]) ifTrue: [File delete: iniFile].
	^super tearDown!

testAdd
	| subject section newValues |
	subject := self makeModifiableIniFile.
	"Sanity check"
	newValues := LookupTable new
				at: 'Key1' put: 'Value1';
				at: '' put: 'Value2';
				at: 'Key3' put: '';
				yourself.
	self assert: (subject add: 'Section1' -> newValues) equals: newValues.
	section := subject at: 'Section1'.
	self assert: (section keys noDifference: newValues keys).
	self assert: (section values noDifference: newValues values).
	section add: 'Key1' -> 'Modified1'.
	section add: '' -> 'Modified2'.
	section add: 'Key4' -> 'Added'.
	self assert: (section keys noDifference: (newValues keys add: 'Key4'; yourself)).
	self assert: (section values noDifference: #('Modified1' 'Modified2' '' 'Added')).

	!

testAsByteArray
	| subject |
	subject := self makeIniFile.
	self should: [subject asByteArray] raise: Error!

testAt
	| subject anonymousSection values |
	subject := self makeIniFile.
	self assert: subject keys equals: #('Section1' 'S2' '3' '').
	values := subject values.
	self assert: (subject at: 'section1') equals: values first.
	self should: [subject at: 'section'] raise: NotFoundError.
	anonymousSection := subject at: ''.
	self assert: anonymousSection equals: values last.
	self assert: (anonymousSection at: '') equals: 'NoSectionNoKeyValue'.
	subject := self makeEmptyIniFile.
	self should: [subject at: ''] raise: NotFoundError!

testAtPut
	| subject section newValues |
	subject := self makeModifiableIniFile.
	"Sanity check"
	newValues := LookupTable new
				at: 'Key1' put: 'Value1';
				at: '' put: 'Value2';
				at: 'Key3' put: '';
				yourself.
	self assert: (subject at: 'Section1' put: newValues) equals: newValues.
	section := subject at: 'Section1'.
	self assert: (section keys noDifference: newValues keys).
	self assert: (section values noDifference: newValues values).
	section at: 'Key1' put: 'Modified1'.
	section at: '' put: 'Modified2'.
	section at: 'Key4' put: 'Added'.
	self assert: (section keys noDifference: (newValues keys add: 'Key4'; yourself)).
	self assert: (section values noDifference: #('Modified1' 'Modified2' '' 'Added')).

	!

testCollect
	| subject section collected |
	subject := self makeIniFile.
	collected := subject collect: [:each | each keys].
	self assert: collected isKindOf: LookupTable.
	self assert: (subject keys noDifference: collected keys).
	self assert: ((subject values collect: [:each | each keys]) noDifference: collected values).
	section := subject values first.
	collected := section collect: [:each | each].
	self assert: (section keys noDifference: collected keys).
	self assert: (section values noDifference: collected values)!

testIncludesKey
	| subject section1 anonymousSection |
	subject := self makeIniFile.
	#('Section1' 'S2' '3' '') do: [:each | self assert: (subject includesKey: each)].
	self deny: (subject includesKey: 'Section4').
	self deny: (subject includesKey: nil).
	section1 := subject at: 'Section1'.
	self assert: (section1 includesKey: 'S1Key1').
	self deny: (section1 includesKey: '').
	self deny: (section1 includesKey: 'S2Key1').
	self should: [section1 includesKey: nil] raise: Error.
	anonymousSection := subject at: ''.
	self assert: (anonymousSection includesKey: '')!

testIsEmpty
	| subject section |
	subject := self makeIniFile.
	self deny: subject isEmpty.
	section := subject values first.
	self deny: section isEmpty.
	section := subject values second.
	self assert: section isEmpty.
	subject := self makeEmptyIniFile.
	self assert: subject isEmpty!

testKeys
	| subject anonymousSection |
	subject := self makeIniFile.
	self assert: subject keys equals: #('Section1' 'S2' '3' '').
	anonymousSection := subject at: ''.
	self assert: anonymousSection keys equals: #('').
	subject := self makeEmptyIniFile.
	self assert: subject keys isEmpty!

testRemoveKey
	| subject section removed |
	subject := self makeModifiableIniFile.
	"Sanity check"
	self assert: subject keys equals: #('Section1' 'S2' '3' '').
	section := subject values first.
	removed := subject removeKey: 'Section1'.
	self assert: removed equals: section.
	self assert: subject keys equals: #('S2' '3' '').
	section := subject values last.
	removed := subject removeKey: ''.
	self assert: removed equals: section.
	self assert: subject keys equals: #('S2' '3').
	subject removeKey: 'S2'.
	subject removeKey: '3'.
	self assert: subject keys equals: #()!

testValues
	| subject sections keys |
	subject := self makeIniFile.
	sections := subject values.
	keys := sections collect: [:each | each name].
	self assert: keys equals: subject keys.
	self assert: keys equals: #('Section1' 'S2' '3' '').
	self assert: sections first values equals: #('S1Value1' 'S1Value2' '').
	self assert: sections second values isEmpty.
	self assert: sections third values equals: #('123').
	self assert: sections fourth values equals: #('NoSectionNoKeyValue').
	subject := self makeEmptyIniFile.
	self assert: subject values isEmpty! !
!IniFileTest categoriesFor: #fileResource!accessing!private! !
!IniFileTest categoriesFor: #makeEmptyIniFile!helpers!private! !
!IniFileTest categoriesFor: #makeIniFile!helpers!private! !
!IniFileTest categoriesFor: #makeModifiableIniFile!helpers!private! !
!IniFileTest categoriesFor: #tearDown!public!running! !
!IniFileTest categoriesFor: #testAdd!public!unit tests! !
!IniFileTest categoriesFor: #testAsByteArray!public!unit tests! !
!IniFileTest categoriesFor: #testAt!public!unit tests! !
!IniFileTest categoriesFor: #testAtPut!public!unit tests! !
!IniFileTest categoriesFor: #testCollect!public!unit tests! !
!IniFileTest categoriesFor: #testIncludesKey!public!unit tests! !
!IniFileTest categoriesFor: #testIsEmpty!public!unit tests! !
!IniFileTest categoriesFor: #testKeys!public!unit tests! !
!IniFileTest categoriesFor: #testRemoveKey!public!unit tests! !
!IniFileTest categoriesFor: #testValues!public!unit tests! !

!IniFileTest class methodsFor!

resources
	^{IniFileTestResource}! !
!IniFileTest class categoriesFor: #resources!accessing!public! !
