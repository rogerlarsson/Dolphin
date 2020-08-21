"Filed out from Dolphin Smalltalk 7"!

UI.Tests.LayoutManagerTest subclass: #'UI.Tests.BorderLayoutTest'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
UI.Tests.BorderLayoutTest guid: (Core.GUID fromString: '{67c32a2b-adf6-4987-95fa-c9bb9b7a4e9c}')!
UI.Tests.BorderLayoutTest comment: ''!
!UI.Tests.BorderLayoutTest categoriesForClass!Unclassified! !
!UI.Tests.BorderLayoutTest methodsFor!

layoutManagerClass
	^BorderLayout!

testResourceBrowserPreview
	"#1758"

	| resourceId resourceView resources |
	resourceId := ResourceIdentifier class: Smalltalk.ResourceBrowser name: 'Default view'.
	resourceView := 
			[Smalltalk developmentSystem loadViewResource: resourceId resource inContext: View desktop]
					on: Error
					do: [:x | ].
	resourceView notNil
				ifTrue: 
					[resourceView invalidateLayoutDeeply.
					Bitmap fromView: resourceView]
				ifFalse: [Error icon].
	resources := resourceView viewNamed: 'resources'.
	self assert: (resources viewNamed: 'resources') extent x equals: resources extent x.
	resourceView destroy! !
!UI.Tests.BorderLayoutTest categoriesFor: #layoutManagerClass!private!unit tests! !
!UI.Tests.BorderLayoutTest categoriesFor: #testResourceBrowserPreview!public!unit tests! !

