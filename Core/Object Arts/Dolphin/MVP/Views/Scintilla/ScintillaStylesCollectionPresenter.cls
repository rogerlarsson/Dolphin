﻿"Filed out from Dolphin Smalltalk 7"!

ValuePresenter subclass: #ScintillaStylesCollectionPresenter
	instanceVariableNames: 'collectionPresenter detailPresenter settingSelection'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ScintillaStylesCollectionPresenter guid: (GUID fromString: '{dfa721d9-7de6-4fe7-9998-18dd7b52c0c4}')!
ScintillaStylesCollectionPresenter comment: 'ScintillaStylesCollectionPresenter provides a master-detail presentation of a collection of <ScintillaTextStyle>s (e.g  those configured for a particular ScintillaView). It is composed of a <CollectionPresenter>, to present the list of styles, and a <ScintillaTextStylePresenter>, to present the detail view. A ScintillaStylesCollectionPresenter can be used to add new styles, and remove and modify existing styles, and as such is used for the #textStyles aspect of a <ScintillaView> when inspected with the Published Aspect Inspector, and also within the <ScintillaTextStylesDialog>. The latter is intended to allow for configuration of text styles in an end-user application that employs Scintilla.

Instance Variables:
	collectionPresenter	<CollectionPresenter>
	detailPresenter		<ScintillaTextStylePresenter>

'!
!ScintillaStylesCollectionPresenter categoriesForClass!MVP-Presenters!MVP-Resources-IDE Tools! !
!ScintillaStylesCollectionPresenter methodsFor!

addItem
	^collectionPresenter addItem!

applyDefaultStyle
	| style list |
	(collectionPresenter notNil and: [collectionPresenter isOpen]) ifFalse: [^self].
	list := collectionPresenter listPresenter view.
	style := self defaultStyle.
	list font: style font.
	style forecolor ifNotNil: [:colour | list forecolor: colour].
	style backcolor ifNotNil: [:colour | list backcolor: colour]!

createComponents
	"Private - Create the presenters contained by the receiver"

	super createComponents.
	collectionPresenter := self add: CollectionPresenter new name: 'styles'.
	collectionPresenter setAddItemBlock: [ScintillaTextStyle new].
	detailPresenter := self add: ScintillaTextStylePresenter new name: 'detail'!

createSchematicWiring
	"Create the trigger wiring for the receiver. At this stage the initialization
	is complete and the view is open"

	super createSchematicWiring.
	collectionPresenter 
		when: #selectionChanged
		send: #onSelectionChanged
		to: self.
	detailPresenter 
		when: #valueChanged
		send: #onStyleChanged
		to: self!

defaultStyle
	^detailPresenter defaultStyle!

defaultStyle: aScintillaTextStyle 
	"Set the default style to be used for style facets for which no setting is specified, i.e.
	this style specifies the style facets that will be inherited from the view settings
	Typically this will include the font and background color. These style facets are then
	overridden by first the #normal style, and then any specific style. "

	detailPresenter defaultStyle: aScintillaTextStyle.
	self applyDefaultStyle!

model: aValueModel
	"Set the model of the receiver to be aValueModel. We intercept a change
	notification so that the list selection can track this value."

	super model: aValueModel.
	self onValueChanged
!

normalStyle: aScintillaTextStyle 
	detailPresenter normalStyle: aScintillaTextStyle!

onSelectionChanged
	collectionPresenter selectionOrNil 
		ifNil: 
			[detailPresenter isEnabled: false.
			detailPresenter model value: detailPresenter normalStyle]
		ifNotNil: 
			[:selection | 
			detailPresenter model value: selection.
			detailPresenter isEnabled: true]!

onStyleChanged
	collectionPresenter selectionOrNil ifNotNil: [:sel | collectionPresenter listModel refresh: sel]!

onValueChanged
	"Private - The value has been changed in the receiver's model. Transfer the value to the
	listModel"

	collectionPresenter model: self model.
	collectionPresenter listModel searchPolicy: SearchPolicy equality.
	(self model value detect: [:each | each name == #normal] ifNone: []) 
		ifNotNil: [:normal | self normalStyle: normal]!

onViewOpened
	super onViewOpened.
	collectionPresenter selectionOrNil: (self model value lookup: 1)! !
!ScintillaStylesCollectionPresenter categoriesFor: #addItem!commands!public! !
!ScintillaStylesCollectionPresenter categoriesFor: #applyDefaultStyle!private!updating! !
!ScintillaStylesCollectionPresenter categoriesFor: #createComponents!initializing!private! !
!ScintillaStylesCollectionPresenter categoriesFor: #createSchematicWiring!initializing!public! !
!ScintillaStylesCollectionPresenter categoriesFor: #defaultStyle!accessing!public! !
!ScintillaStylesCollectionPresenter categoriesFor: #defaultStyle:!accessing!public! !
!ScintillaStylesCollectionPresenter categoriesFor: #model:!accessing!public! !
!ScintillaStylesCollectionPresenter categoriesFor: #normalStyle:!accessing!public! !
!ScintillaStylesCollectionPresenter categoriesFor: #onSelectionChanged!event handling!private! !
!ScintillaStylesCollectionPresenter categoriesFor: #onStyleChanged!event handling!private! !
!ScintillaStylesCollectionPresenter categoriesFor: #onValueChanged!event handling!private! !
!ScintillaStylesCollectionPresenter categoriesFor: #onViewOpened!event handling!public! !

!ScintillaStylesCollectionPresenter class methodsFor!

customDraw: aNMLVCUSTOMDRAW 
	| style |
	style := aNMLVCUSTOMDRAW item.
	style fontName isNil 
		ifTrue: 
			[| font |
			font := aNMLVCUSTOMDRAW font.
			style restyleFont: font]
		ifFalse: [aNMLVCUSTOMDRAW font: style font].
	style forecolor ifNotNil: [:color | aNMLVCUSTOMDRAW forecolor: color].
	style backcolor ifNotNil: [:color | aNMLVCUSTOMDRAW backcolor: color]!

defaultModel
	^OrderedCollection with: ScintillaTextStyle normal!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.ContainerView) 34 15 nil nil 34 2 8 1409286144 131073 416 nil nil nil 5 nil nil nil 416 788230 ##(Smalltalk.BorderLayout) 17 11 nil nil nil 410 ##(Smalltalk.ContainerView) 34 15 nil 416 34 2 8 1140850688 131073 512 nil nil nil 5 nil nil nil 512 482 1 1 410 ##(Smalltalk.StaticText) 34 16 nil 512 34 2 8 1140850944 1 592 nil nil nil 5 nil nil nil 592 nil 8 1883797456 852486 ##(Smalltalk.NullConverter) nil nil nil 983302 ##(Smalltalk.MessageSequence) 138 144 34 2 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 328198 ##(Smalltalk.Point) 1 1 818 321 39 592 770 #text: 34 1 8 '&Style Name:' 592 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 160 0 0 0 19 0 0 0] 8 #() 818 193 193 nil 27 nil nil nil 410 ##(Smalltalk.ListView) 34 45 nil 512 34 2 8 1140936781 1025 992 590662 2 ##(Smalltalk.ListModel) 138 144 8 #() nil 1310726 ##(Smalltalk.IdentitySearchPolicy) 327686 ##(Smalltalk.Color) #default nil 5 nil nil nil 992 nil 8 1883852064 459270 ##(Smalltalk.Message) #displayString 8 #() nil 1049926 1 ##(Smalltalk.IconImageManager) nil nil nil nil nil nil 138 144 34 1 920646 5 ##(Smalltalk.ListViewColumn) 8 '' 313 #left 1202 #displayString 1232 1202 #<= 8 #() nil nil 992 nil 3 nil 787814 3 ##(Smalltalk.BlockClosure) 0 nil 1180966 ##(Smalltalk.CompiledExpression) 3 1 ##(Smalltalk.UndefinedObject) 8 'doIt' 8 '[:each | ScintillaStylesCollectionPresenter customDraw: each]' 8 #[31 105 45 17 177 106] 721414 ##(Smalltalk.Association) #ScintillaStylesCollectionPresenter ##(Smalltalk.ScintillaStylesCollectionPresenter) #customDraw: 1424 7 257 nil #report 1104 nil 133217 nil 1 nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil 706 138 144 34 1 770 #createAt:extent: 34 2 818 1 39 818 321 685 992 914 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 19 0 0 0 160 0 0 0 105 1 0 0] 8 #() 976 nil 35 170 192 34 2 992 8 'list' nil 706 138 144 34 1 770 #createAt:extent: 34 2 818 1 1 818 321 723 512 914 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 160 0 0 0 105 1 0 0] 34 2 592 992 976 nil 27 410 ##(Smalltalk.ReferenceView) 34 14 nil 416 34 2 8 1140850688 131073 1920 nil nil nil 5 nil nil nil 1920 1180230 1 ##(Smalltalk.ResourceIdentifier) ##(Smalltalk.ScintillaTextStylePresenter) #resource_Default_view nil 706 138 144 34 1 770 #createAt:extent: 34 2 818 337 1 818 501 723 1920 914 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 168 0 0 0 0 0 0 0 162 1 0 0 105 1 0 0] 1104 976 nil 27 170 192 34 4 1920 8 'detail' 512 8 'styles' 590342 ##(Smalltalk.Rectangle) 818 1 1 818 1 1 706 138 144 34 2 770 #createAt:extent: 34 2 818 7039 21 818 837 723 416 770 #text: 34 1 8 'Text Styles' 416 914 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 191 13 0 0 10 0 0 0 97 15 0 0 115 1 0 0] 34 2 512 1920 976 nil 27 )!

resource_Developer_view
	"Answer the literal data from which the 'Developer view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Developer_view)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.ContainerView) 34 15 nil nil 34 2 8 1409286144 131073 416 nil nil nil 5 nil nil nil 416 788230 ##(Smalltalk.BorderLayout) 17 11 nil nil nil 410 ##(Smalltalk.ContainerView) 34 15 nil 416 34 2 8 1140850688 131073 512 nil nil nil 5 nil nil nil 512 482 1 1 410 ##(Smalltalk.ReferenceView) 34 14 nil 512 34 2 8 1140850688 131073 592 nil nil nil 5 nil nil nil 592 1180230 1 ##(Smalltalk.ResourceIdentifier) ##(Smalltalk.Toolbar) #resource_List_tools nil 983302 ##(Smalltalk.MessageSequence) 138 144 34 2 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 328198 ##(Smalltalk.Point) 1 1 802 321 51 592 754 #text: 34 1 8 'toolbar' 592 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 160 0 0 0 25 0 0 0] 8 #() 802 193 193 nil 27 nil nil nil 410 ##(Smalltalk.ListView) 34 45 nil 512 34 2 8 1140936781 1 976 590662 2 ##(Smalltalk.ListModel) 138 144 944 nil 1310726 ##(Smalltalk.IdentitySearchPolicy) 327686 ##(Smalltalk.Color) #default nil 5 265030 4 ##(Smalltalk.Menu) nil true 34 4 984134 2 ##(Smalltalk.CommandMenuItem) 1 1180998 4 ##(Smalltalk.CommandDescription) #moveFirst 8 'Move to &First' 1 1 nil nil nil 1202 1 1234 #moveUp 8 'Move to &Previous' 1 1 nil nil nil 1202 1 1234 #moveDown 8 'Move to &Next' 1 1 nil nil nil 1202 1 1234 #moveLast 8 'Move to &Last' 1 1 nil nil nil 8 '' nil 1 nil nil nil nil nil nil nil 976 nil 8 1883852064 459270 ##(Smalltalk.Message) #displayString 8 #() nil 1049926 1 ##(Smalltalk.IconImageManager) nil nil nil nil nil nil 138 144 34 1 920646 5 ##(Smalltalk.ListViewColumn) 8 '' 313 #left 1458 #displayString 1488 1458 #<= 8 #() nil nil 976 nil 3 nil 787814 3 ##(Smalltalk.BlockClosure) 0 nil 1180966 ##(Smalltalk.CompiledExpression) 3 1 ##(Smalltalk.UndefinedObject) 8 'doIt' 8 '[:each | ScintillaStylesCollectionPresenter customDraw: each]' 8 #[31 105 45 17 177 106] 721414 ##(Smalltalk.Association) #ScintillaStylesCollectionPresenter ##(Smalltalk.ScintillaStylesCollectionPresenter) #customDraw: 1680 7 257 nil #report 944 nil 133217 nil 1 nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil 690 138 144 34 2 754 #createAt:extent: 34 2 802 1 51 802 321 783 976 754 #contextMenu: 34 1 1168 976 898 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 25 0 0 0 160 0 0 0 160 1 0 0] 8 #() 960 nil 35 170 192 34 2 976 8 'list' nil 690 138 144 34 1 754 #createAt:extent: 34 2 802 1 1 802 321 833 512 898 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 160 0 0 0 160 1 0 0] 34 2 592 976 960 nil 27 410 ##(Smalltalk.ReferenceView) 34 14 nil 416 34 2 8 1140850688 131073 2208 nil nil nil 5 nil nil nil 2208 658 ##(Smalltalk.ScintillaTextStylePresenter) #resource_Developer_view nil 690 138 144 34 1 754 #createAt:extent: 34 2 802 337 1 802 501 833 2208 898 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 168 0 0 0 0 0 0 0 162 1 0 0 160 1 0 0] 944 960 nil 27 170 192 34 4 2208 8 'detail' 512 8 'styles' 590342 ##(Smalltalk.Rectangle) 802 1 1 802 1 1 690 138 144 34 2 754 #createAt:extent: 34 2 802 7039 21 802 837 833 416 754 #text: 34 1 8 'Text Styles' 416 898 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 191 13 0 0 10 0 0 0 97 15 0 0 170 1 0 0] 34 2 512 2208 960 nil 27 )! !
!ScintillaStylesCollectionPresenter class categoriesFor: #customDraw:!helpers!public! !
!ScintillaStylesCollectionPresenter class categoriesFor: #defaultModel!models!public! !
!ScintillaStylesCollectionPresenter class categoriesFor: #resource_Default_view!public!resources-views! !
!ScintillaStylesCollectionPresenter class categoriesFor: #resource_Developer_view!public!resources-views! !

