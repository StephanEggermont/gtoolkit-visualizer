calculating
calculateBounds: aNode bounds: bounds positions: aPositionsDict
	| newBounds nodeX nodeY nodeWidth nodeHeight |
	nodeX := (aPositionsDict at: aNode) x.
	nodeY := (aPositionsDict at: aNode) y.
	nodeWidth := aNode measuredBounds width.
	nodeHeight := aNode measuredBounds height.
	self flag: 'if you pass zero bounds at the beginning, you likely do not need the if at all'.
	newBounds := bounds isNil
		ifTrue: [ Bounds new
				x: nodeX;
				y: nodeY;
				width: nodeWidth;
				height: nodeHeight ]
		ifFalse: [ 
			self flag: 'instantiate BlBounds instead of Bounds'.
			Bounds new
				x: (bounds x min: nodeX);
				y: (bounds y min: nodeY);
				width: (bounds x + bounds width max: nodeX + nodeWidth);
				height: (bounds y + bounds height max: nodeY + nodeHeight) ].
	^ newBounds