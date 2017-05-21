"Filed out from Dolphin Smalltalk 7"!

AnnouncerTest subclass: #WeakAnnouncerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
WeakAnnouncerTest guid: (GUID fromString: '{26a69917-162e-4a6f-8383-df020cbf176f}')!
WeakAnnouncerTest comment: 'SUnit tests for weak announcements'!
!WeakAnnouncerTest categoriesForClass!Announcements-Tests-Core-Tests! !
!WeakAnnouncerTest methodsFor!

testNoWeakBlock
	"Blocks are never weak"

	| counter subscription|
	counter := 0.
	subscription := announcer subscribe: AnnouncementMockA do: [:ann | counter := counter + 1].

	MemoryManager current collectGarbage.
	announcer announce: AnnouncementMockA.
	self assert: counter = 1.

	subscription  makeWeak.

	MemoryManager current collectGarbage.
	announcer announce: AnnouncementMockA.
	self assert: counter = 2!

testWeakObject

testWeakSubscription
	| obj subscription |
	obj := Object new.
	subscription := (announcer 
				when: AnnouncementMockA
				send: #value
				to: obj) makeWeak.
	self assert: obj == subscription subscriber! !
!WeakAnnouncerTest categoriesFor: #testNoWeakBlock!public!testing! !
!WeakAnnouncerTest categoriesFor: #testWeakObject!public!testing! !
!WeakAnnouncerTest categoriesFor: #testWeakSubscription!public!testing! !
