"Filed out from Dolphin Smalltalk 7"!

DolphinTest subclass: #LocaleTest
	instanceVariableNames: 'savedLocale'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''
	classConstants: {}!
LocaleTest guid: (GUID fromString: '{85b9dbfa-a1e2-46f3-ae44-d016f209b03b}')!
LocaleTest isAbstract: true!
LocaleTest comment: ''!
!LocaleTest categoriesForClass!Unclassified! !
!LocaleTest methodsFor!

defaultSubject
	^self subclassResponsibility!

setUp
	super setUp.
	savedLocale := Locale userDefault.
	"Deliberately switch to another default locale to catch any reliance on Locale specific dependencies in the test"
	Locale userDefault: (Locale named: 'hi-IN')!

tearDown
	savedLocale ifNotNil: [Locale userDefault: savedLocale. savedLocale := nil].
	super tearDown!

testPrimary
	"Sad, but true"

	self assert: (Locale named: 'en-GB') primary equals: (Locale named: 'en-US').
	self assert: (Locale named: 'fr-CA') primary equals: (Locale named: 'fr-FR').
	self assert: Locale invariant primary equals: Locale invariant.
	self assert: (Locale lcid: WinNlsConstants.LOCALE_CUSTOM_DEFAULT) primary
		equals: Locale userDefault primary.
	self assert: Locale smalltalk primary equals: (Locale named: 'en-US')!

testPrintDateTimeOnFormat
	| subject now expected |
	now := DateAndTime
				year: 2019
				day: 97
				hour: 18
				minute: 26
				second: 21 + (827 / 1000).
	subject := self defaultSubject.
	expected := '6:26 ', subject pmDesignator, ' (and 21.827 seconds) on Sunday, 7 of April 2019 somewhere'.
	{now. now asParameter. TimeStamp fromDateAndTime: now} do: 
			[:each |
			| actual |
			actual := String streamContents: 
							[:s |
							subject
								printDateTime: each
								on: s
								format: 'h:mm tt (an\d ssffffff \secon\d\s) on dddd, d ''of'' MMMM yyyy ''somewhere'''].
			self assert: actual equals: expected]!

testPrintDurationOnFormat
	| subject actual |
	subject := self defaultSubject.
	actual := String streamContents: 
					[:s |
					subject
						printDuration: 1.75 hours
						on: s
						format: '+hh:mm'].
	self assert: actual equals: '+01:45'.
	actual := String streamContents: 
					[:s |
					subject
						printDuration: -1.75 hours
						on: s
						format: '+hh:mm'].
	self assert: actual equals: '-01:45'.
	actual := String streamContents: 
					[:s |
					subject
						printDuration: 12.1 hours
						on: s
						format: '-hh:mm'].
	self assert: actual equals: '12:06'.
	actual := String streamContents: 
					[:s |
					subject
						printDuration: -12.1 hours
						on: s
						format: '+hh:mm'].
	self assert: actual equals: '-12:06'! !
!LocaleTest categoriesFor: #defaultSubject!helpers!private! !
!LocaleTest categoriesFor: #setUp!private!running! !
!LocaleTest categoriesFor: #tearDown!private!running! !
!LocaleTest categoriesFor: #testPrimary!public! !
!LocaleTest categoriesFor: #testPrintDateTimeOnFormat!public! !
!LocaleTest categoriesFor: #testPrintDurationOnFormat!public!unit tests! !

