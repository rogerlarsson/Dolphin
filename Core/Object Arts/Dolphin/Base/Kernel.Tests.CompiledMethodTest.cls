"Filed out from Dolphin Smalltalk 7"!

Core.Tests.DolphinTest subclass: #'Kernel.Tests.CompiledMethodTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Kernel.Tests.CompiledMethodTest guid: (Core.GUID fromString: '{32df31e4-99ba-44fb-aaac-99e5dfe82c94}')!
Kernel.Tests.CompiledMethodTest comment: 'This is the unit test for the class CompiledMethod. Unit tests are a good way to exercise the functionality of your system in a repeatable and automatic manner. They are therefore recommended if you plan to release anything. For more information, see: 
	- http://www.c2.com/cgi/wiki?UnitTest
	- http://minnow.cc.gatech.edu/squeak/1547
	- the sunit class category'!
!Kernel.Tests.CompiledMethodTest categoriesForClass!Tests-Kernel-Methods! !
!Kernel.Tests.CompiledMethodTest methodsFor!

returnPlusOne: anInteger
	^anInteger + 1.!

returnTrue
	^true!

testIsQuick
	| method |
	method := self class compiledMethodAt: #returnTrue.
	self assert: method extraIndex equals: 2.
	method := self class compiledMethodAt: #returnPlusOne:.
	self deny: method extraIndex equals: 5!

testValueWithReceiverArguments
	| method value |
	method := self class compiledMethodAt: #returnTrue.
	self should: [method value: nil withArguments: #()] raise: Error.
	value := method value: self withArguments: #().
	self assert: value equals: true.
	method := self class compiledMethodAt: #returnPlusOne:.
	value := method value: self withArguments: #(1).
	self assert: value equals: 2! !
!Kernel.Tests.CompiledMethodTest categoriesFor: #returnPlusOne:!examples!public! !
!Kernel.Tests.CompiledMethodTest categoriesFor: #returnTrue!examples!public! !
!Kernel.Tests.CompiledMethodTest categoriesFor: #testIsQuick!public!testing / testing! !
!Kernel.Tests.CompiledMethodTest categoriesFor: #testValueWithReceiverArguments!public!testing / evaluating! !

