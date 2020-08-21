"Filed out from Dolphin Smalltalk 7"!

Core.Tests.LocaleTest subclass: #'OS.Tests.WindowsLocaleTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
OS.Tests.WindowsLocaleTest guid: (Core.GUID fromString: '{1cc6ee0d-11ce-44fd-940d-7126f73516ba}')!
OS.Tests.WindowsLocaleTest comment: ''!
!OS.Tests.WindowsLocaleTest categoriesForClass!Unclassified! !
!OS.Tests.WindowsLocaleTest methodsFor!

defaultSubject
	^Locale named: 'en-GB'!

testDisplayFloatOn
	| info subject |
	{{Locale named: 'en-GB'.
			{{Float infinity. '∞'}.
				{Float negativeInfinity. '-∞'}.
				{Float nan. 'NaN'}.
				{0.0. '0.00'}.
				{-0.0. '0.00'}.
				{1.25. '1.25'}.
				{-1.25. '-1.25'}.
				{0.095. '0.10'}.
				{-0.095. '-0.10'}.
				{0.0009. '0.00'}.
				{-0.0009. '0.00'}.
				{Float fmax.
					'179,769,313,486,231,600,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000.00'}.
				{Float fmin. '0.00'}.
				{123456.789. '123,456.79'}.
				{-123456.789. '-123,456.79'}.
				{1234567.89. '1,234,567.89'}.
				{-1234567.89. '-1,234,567.89'}}}.
		{Locale named: 'es-ES_tradnl'.
			{{Float infinity. 'Infinito'}.
				{Float negativeInfinity. '-Infinito'}.
				{Float nan. 'NeuN'}.
				{0.0. '0,00'}.
				{0.0. '0,00'}.
				{1.25. '1,25'}.
				{-1.25. '-1,25'}.
				{0.095. '0,10'}.
				{-0.095. '-0,10'}.
				{-0.605. '-0,61'}.
				{0.0001. '0,00'}.
				{-0.0001. '0,00'}.
				{Float fmax.
					'179.769.313.486.231.600.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000,00'}.
				{Float fmin. '0,00'}.
				{123456.7. '123.456,70'}.
				{-123456.7. '-123.456,70'}.
				{1234567.89. '1.234.567,89'}.
				{-1234567.89. '-1.234.567,89'}}}}
			do: 
				[:each |
				| actual |
				subject := each first.
				each second do: 
						[:pair |
						actual := pair first displayString: subject.
						self assert: actual equals: pair second]].
	"Switch to a locale with a different decimal separator and representations for Nan, Infinity, etc."
	"Different negative number mode (2)"
	subject := Locale named: 'hr-HR'.
	self assert: (-0.0 displayString: subject) equals: '0,00'.
	self assert: (-1.25 displayString: subject) equals: '- 1,25'.
	self assert: (-0.0001 displayString: subject) equals: '0,00'.
	self assert: (-123456789.123456789 displayString: subject) equals: '- 123.456.789,12'.
	"Negative infinity does not seem to be represented consistently with respect to the normal negative sign conventions in this locale. The value is direct from Windows"
	self assert: (Float negativeInfinity displayString: subject) equals: '-∞'.

	"Different negative number mode (3)"
	subject := Locale named: 'fa-IR'.
	self assert: (-0.0 displayString: subject) equals: '0/00'.
	self assert: (-1.25 displayString: subject) equals: '1/25-'.
	self assert: (-0.0001 displayString: subject) equals: '0/00'.
	self assert: (-123456789.123456789 displayString: subject) equals: '123,456,789/12-'.
	"Ditto re: Negative infinity, which is supplied by Windows with an inconsistent representation."
	self assert: (Float negativeInfinity displayString: subject) equals: '-∞'.

	"Fake up the other modes - zero is bracketed"
	subject := Locale named: 'en-US'.
	info := subject instVarNamed: 'info'.
	info at: NlsConstants.LOCALE_INEGNUMBER put: 0.
	self assert: (-0.0 displayString: subject) equals: '0.00'.
	self assert: (-1.25 displayString: subject) equals: '(1.25)'.
	self assert: (-0.0001 displayString: subject) equals: '0.00'.
	self assert: (-123456789.123456789 displayString: subject) equals: '(123,456,789.12)'.

	"Mode 4 is trailing minus after space"
	subject := Locale named: 'en-US'.
	(subject instVarNamed: 'info') at: NlsConstants.LOCALE_INEGNUMBER put: 4.
	self assert: subject negativeNumberMode equals: 4.
	self assert: (-0.0 displayString: subject) equals: '0.00'.
	self assert: (-1.25 displayString: subject) equals: '1.25 -'.
	self assert: (-0.0001 displayString: subject) equals: '0.00'.
	self assert: (-123456789.123456789 displayString: subject) equals: '123,456,789.12 -'!

testEnglishName
	#('smalltalk' 'English' 'en-US' 'English' 'en-GB' 'English' 'es-ES_tradnl' 'Spanish' 'cy-GB' 'Welsh' 'es-AR' 'Spanish')
		pairsDo: [:lcid :language | self assert: (Locale named: lcid) englishLanguageName equals: language]! !
!OS.Tests.WindowsLocaleTest categoriesFor: #defaultSubject!helpers!private! !
!OS.Tests.WindowsLocaleTest categoriesFor: #testDisplayFloatOn!public!unit tests! !
!OS.Tests.WindowsLocaleTest categoriesFor: #testEnglishName!public!unit tests! !

