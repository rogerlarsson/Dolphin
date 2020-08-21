"Filed out from Dolphin Smalltalk 7"!

Core.Tests.DolphinTest subclass: #'Core.Tests.LocaleTest'
	instanceVariableNames: 'savedLocale'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Core.Tests.LocaleTest guid: (Core.GUID fromString: '{85b9dbfa-a1e2-46f3-ae44-d016f209b03b}')!
Core.Tests.LocaleTest isNonInstantiable: true!
Core.Tests.LocaleTest comment: ''!
!Core.Tests.LocaleTest categoriesForClass!Unclassified! !
!Core.Tests.LocaleTest methodsFor!

defaultSubject
	^self subclassResponsibility!

setUp
	super setUp.
	savedLocale := Locale userDefault.
	"Deliberately switch to another default locale to catch any reliance on Locale specific dependencies in the test"
	Locale userDefault: (Locale named: 'hi-IN')!

tearDown
	savedLocale
		ifNotNil: 
			[Locale userDefault: savedLocale.
			savedLocale := nil].
	super tearDown!

testPrimary
	"Sad, but true"

	self assert: (Locale named: 'en-GB') primary equals: (Locale named: 'en-US').
	self assert: (Locale named: 'fr-CA') primary equals: (Locale named: 'fr-FR').
	self assert: Locale invariant primary equals: Locale invariant.
	self assert: (Locale lcid: OS.NlsConstants.LOCALE_CUSTOM_DEFAULT) primary
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
	expected := '6:26 ' , subject pmDesignator
				, ' (and 21.827 seconds) on Sunday, 7 of April 2019 somewhere'.
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
!Core.Tests.LocaleTest categoriesFor: #defaultSubject!helpers!private! !
!Core.Tests.LocaleTest categoriesFor: #setUp!private!running! !
!Core.Tests.LocaleTest categoriesFor: #tearDown!private!running! !
!Core.Tests.LocaleTest categoriesFor: #testPrimary!public! !
!Core.Tests.LocaleTest categoriesFor: #testPrintDateTimeOnFormat!public! !
!Core.Tests.LocaleTest categoriesFor: #testPrintDurationOnFormat!public!unit tests! !

