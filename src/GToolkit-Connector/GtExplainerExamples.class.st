Class {
	#name : #GtExplainerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Connector'
}

{ #category : #example }
GtExplainerExamples >> example [
	<gtExample>
	| container subject inspectorHeader editor inspectorView |
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	container explainer isExplanationHolder: true.
	subject := (42 gtViewsFor: GtPhlowView empty) asElementDo: [ :e | e ].
	subject forceLayout.
	inspectorHeader := subject phlow firstChildWithView.
	inspectorView := inspectorHeader viewContentElement phlow firstChildWithView.
	container addChild: subject.
	container addChild: (BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 30@30;
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #header);
		relocate: (container globalPointToLocal: (inspectorHeader localPointToGlobal: 10 @ 10))).
	container addChild: (BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 30@30;
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #view);
		relocate: (container globalPointToLocal: (inspectorView localPointToGlobal: 10 @ 10))).
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: self explanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	^ container
]

{ #category : #example }
GtExplainerExamples >> explanationText [
	<gtExample>
	| text |
	text := 
		'An inspector pane is made of several parts.

The ' asRopedText, 
		('header' asRopedText glamorousExplanationFor: #header),
		' shows the string representation of the inspected object.

The inspector shows multiple ' asRopedText,
		('views' asRopedText glamorousExplanationFor: #view),
		' that are specific to the object' asRopedText.
	^ text 
		glamorousRegularFont;
		foreground: Color black
]