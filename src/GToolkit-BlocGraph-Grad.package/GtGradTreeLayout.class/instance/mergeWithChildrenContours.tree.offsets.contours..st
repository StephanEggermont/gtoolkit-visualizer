calculating
mergeWithChildrenContours: aNodeElement tree: aDFSTree offsets: anOffsetsDict contours: aContoursDict
	| total width firstChild | 
	
	firstChild := (aDFSTree at: aNodeElement) first.
	aContoursDict at: aNodeElement put: (aContoursDict at: firstChild).
	width := (firstChild measuredBounds width) + (2 * self nodeDistance).
	total := width.
		
	(aDFSTree at: aNodeElement) do: [ :child | 

		child = firstChild
			ifFalse: [
				| d |

				d := self mergeContours: aNodeElement child: child contours: aContoursDict.
				anOffsetsDict at: child put: 0@(width + d).
				GtGradTreeLayoutOffsetSetSignal new
									node: aNodeElement; 
									offsetX: 0; 
									offsetY: width + d;
									emit.
			
				width := (child measuredBounds width) + (2 * self nodeDistance).
				total := total + width + d.
		].
	].

	^ total
	