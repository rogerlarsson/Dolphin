"Filed out from Dolphin Smalltalk 7"!

Core.Tests.DolphinTest subclass: #'UI.Tests.ResourceIdentifierTest'
	instanceVariableNames: 'tempViewResource'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Tests.ResourceIdentifierTest guid: (Core.GUID fromString: '{1e647bf5-1b62-4e30-af83-80b9bfbe65ad}')!
UI.Tests.ResourceIdentifierTest comment: ''!
!UI.Tests.ResourceIdentifierTest categoriesForClass!Unclassified! !
!UI.Tests.ResourceIdentifierTest methodsFor!

setUp
	| shellView filer |
	super setUp.
	shellView := ShellView show.
	shellView model: {$a. 'abc'. 1. 16rFFFFFFFF. #($a #abc true nil 1.2)}.
	filer := STLOutFiler on: Array writeStream.
	filer nextPut: shellView.
	shellView destroy.
	tempViewResource := filer stream contents!

tempViewResource
	^tempViewResource!

testAssignResource
	| rid readBack |
	self assert: (self class respondsTo: #resource_Test_view) not.
	
	[rid := ResourceIdentifier class: self class name: 'Test view'.
	rid assign: self tempViewResource.
	self assert: (self class respondsTo: #resource_Test_view).
	readBack := rid resource.
	self assert: readBack equals: self tempViewResource]
			ensure: 
				[self class class removeSelector: #resource_Test_view ifAbsent: [].
				self assert: (self class respondsTo: #resource_Test_view) not]!

testDeserializeAll
	"Test's that all view resources are deserializable. The most common cause of breakage would
	be changing the layout of a class with serialized instances in resources without adding an
	appropriate STB conversion."

	"This will throw an  error if #stbVersion has not been incremented on a class with changed inst vars appearing in a resource."

	ResourceIdentifier allResourceIdentifiers do: [:each | each hiddenObjects]!

testResourceSelector
	| rid selector |
	rid := ResourceIdentifier class: self class name: 'Default view'.
	selector := rid class selectorFromName: rid name.
	self assert: selector identicalTo: #resource_Default_view.
	self assert: (rid class nameFromSelector: selector) equals: rid name.
	rid := ResourceIdentifier class: self class name: '1Default:view'.
	self assert: (rid class selectorFromName: rid name) identicalTo: #resource_1Defaultview! !
!UI.Tests.ResourceIdentifierTest categoriesFor: #setUp!private!unit tests! !
!UI.Tests.ResourceIdentifierTest categoriesFor: #tempViewResource!private!unit tests! !
!UI.Tests.ResourceIdentifierTest categoriesFor: #testAssignResource!public!unit tests! !
!UI.Tests.ResourceIdentifierTest categoriesFor: #testDeserializeAll!public!unit tests! !
!UI.Tests.ResourceIdentifierTest categoriesFor: #testResourceSelector!public!unit tests! !

