"Filed out from Dolphin Smalltalk 7"!

Core.Tests.LocaleTest subclass: #'Core.Tests.SmalltalkLocaleTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Core.Tests.SmalltalkLocaleTest guid: (Core.GUID fromString: '{0a445b92-78d1-4c9c-a3f4-7be49f0c2932}')!
Core.Tests.SmalltalkLocaleTest comment: ''!
!Core.Tests.SmalltalkLocaleTest categoriesForClass!Unclassified! !
!Core.Tests.SmalltalkLocaleTest methodsFor!

defaultSubject
	^Locale smalltalk!

testDisplayFloatOn
	| subject |
	subject := self defaultSubject.
	{{Float infinity. 'Float.Infinity'}.
		{Float negativeInfinity. 'Float.NegativeInfinity'}.
		{Float nan. 'Float.NaN'}.
		{Float fmax. '1.7976931348623157e308'}.
		{Float fmin. '5.0e-324'}.
		{0.0. '0.0'}.
		{-0.0. '-0.0'}.
		{1.25. '1.25'}.
		{-1.25. '-1.25'}.
		{123456.7. '123456.7'}.
		{-123456.7. '-123456.7'}.
		{1234567.8. '1.2345678e6'}.
		{-1234567.8. '-1.2345678e6'}.
		{0.1. '0.1'}.
		{0.0001. '0.0001'}.
		{-0.0001. '-0.0001'}.
		{0.00001. '1.0e-5'}.
		{-0.00001. '-1.0e-5'}} do: 
				[:each |
				| actual |
				actual := each first displayString: subject.
				self assert: actual equals: each second]! !
!Core.Tests.SmalltalkLocaleTest categoriesFor: #defaultSubject!helpers!private! !
!Core.Tests.SmalltalkLocaleTest categoriesFor: #testDisplayFloatOn!public! !

