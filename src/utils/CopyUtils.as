package utils
{
	import flash.events.Event;
	import flash.system.System;
	
	import mx.controls.Alert;

	public class CopyUtils
	{
		public function CopyUtils()
		{
			
		}
		public function onCopy(evt:Event):void
		{
			switch (evt.type) {
				case "copy":  {
					if (evt.currentTarget.selectedItems.length>0) {
						var str:String = "";
						Alert.show("copiou");
						for each (var itemObj:Object in evt.currentTarget.selectedItems) {
							for each (var col:Object in evt.currentTarget.columns) {
								str += itemObj[col.dataField]+"\t";
							}
							str += "\n";
						}
						System.setClipboard(str);
					}
					break;
				}
				default:  {
					break;
				}
			}
		}
	}
}