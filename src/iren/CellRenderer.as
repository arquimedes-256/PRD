package iren
{
	import flash.display.Graphics;
	
	import spark.components.Label;
	
	public class CellRenderer extends Label {
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void { 
			super.updateDisplayList(unscaledWidth, unscaledHeight); 
			var g:Graphics = graphics;
			g.clear();
			/*
			for each(var object:Object in arrayCollection) {
				if (object.rowIndex == 0) { //or whatever your conditions are
					g.beginFill(0xFFFFC0); 
					g.drawRect(0, 0, unscaledWidth, unscaledHeight);
					g.endFill(); 
				}
			} */
		} 
	} 
}