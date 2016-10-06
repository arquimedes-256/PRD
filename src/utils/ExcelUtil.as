package utils
{
	
	import com.as3xls.xls.Cell;
	
	import com.as3xls.xls.ExcelFile;
	
	import com.as3xls.xls.Sheet;
	
	import com.as3xls.xls.style.XFormat;
	
	import flash.net.FileReference;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ICollectionView;
	
	import mx.collections.IViewCursor;
	
	import mx.controls.AdvancedDataGrid;
	
	import mx.controls.Alert;
	
	import mx.controls.DataGrid;
	
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumnGroup;
	
	import mx.controls.dataGridClasses.DataGridColumn;
	
	public class ExcelUtil
		
	{
		
		public static
		function dataGridToExcel(dataGrid: DataGrid, filename: String): void
			
		{
			
			var sheet: Sheet = new Sheet();
			
			sheet.resize((dataGrid.dataProvider as ICollectionView).length + 1, dataGrid.columns.length + 1);
			
			for (var i: int = 0; i < dataGrid.columns.length; i++) {
				
				sheet.setCell(0, i, "="+(dataGrid.columns[i] as DataGridColumn).headerText);
				
			}
			
			var cursor: IViewCursor = dataGrid.dataProvider.createCursor();
			
			var rowCount: int = 1;
			
			while (!cursor.afterLast)
				
			{
				
				for (var j: int = 0; j < dataGrid.columns.length; j++)
					
				{
					
					var col: DataGridColumn = dataGrid.columns[j] as DataGridColumn;
					
					if (col.itemToLabel(cursor.current) == null) {
						
						sheet.setCell(rowCount, j, "");
						
					} else {
						
						sheet.setCell(rowCount, j, col.itemToLabel(cursor.current));
						
					}
					
				}
				
				rowCount++;
				
				cursor.moveNext();
				
			}
			
			var xls: ExcelFile = new ExcelFile();
			
			xls.sheets.addItem(sheet);
			
			var bytes: ByteArray = xls.saveToByteArray();
			
			var fileReference: FileReference = new FileReference();
			
			fileReference.save(bytes, filename.replace(/[\\:*?"<>|%@\/]/g, ""));
			
		}
		
		public static
		function advancedDataGridToExcel(dataGrid: AdvancedDataGrid, filename: String): void
			
		{
			
			var sheet: Sheet = new Sheet();
			
			sheet.resize((dataGrid.dataProvider as ICollectionView).length + 1, dataGrid.columns.length + 1);
			
			/*for(var i:int = 0; i < dataGrid.groupedColumns.length; i++) {
			
			sheet.setCell(0, i, (dataGrid.columns[i] as AdvancedDataGridColumn).headerText);
			
			}*/
			
			var i: int = 0;
			
			var j: int = 1;
			
			for each(var column: AdvancedDataGridColumn in dataGrid.groupedColumns)
			
			{
				
				// if the column is not visible or the header text is not defined (e.g., a column used for a graphic),
				
				if (!column.visible || !column.headerText)
					
					continue;
				
				// depending on whether the current column is a group or not, export the data differently
				
				if (column is AdvancedDataGridColumnGroup)
					
				{
					
					sheet.setCell(0, j, column.headerText);
					
					j = j + 2;
					
					for each(var subColumn: AdvancedDataGridColumn in (column as AdvancedDataGridColumnGroup).children)
					
					{
						
						if (!subColumn.visible || !subColumn.headerText)
							
							continue;
						
						sheet.setCell(1, i++, subColumn.headerText);
						
					}
					
				} else
					
				{
					var f:int = i++;
					sheet.setCell(1, f, column.headerText);
					
				}
				
			}
			
			var cursor: IViewCursor = dataGrid.dataProvider.createCursor();
			
			var rowCount: int = 2;
			
			while (!cursor.afterLast)
				
			{	
				for (j = 0; j < dataGrid.columns.length; j++)	
				{
					var col: AdvancedDataGridColumn = dataGrid.columns[j] as AdvancedDataGridColumn;
					if (col.itemToLabel(cursor.current) == null) 
					{
						sheet.setCell(rowCount, j, "");
					} 
					else 
					{
						sheet.setCell(rowCount, j, col.itemToLabel(cursor.current));
					}
				}
				
				rowCount++;
				
				cursor.moveNext();
				
			}
			
			var xls: ExcelFile = new ExcelFile();
			
			xls.sheets.addItem(sheet);
			
			var bytes: ByteArray = xls.saveToByteArray();
			
			try {
				
				var fileReference: FileReference = new FileReference();
				
				fileReference.save(bytes, filename.replace(/[\\:*?"<>|%@\/]/g, ""));
				
			} catch (e: Error) {
				
				Alert.show(""+e.message, "Error Message");
				
			}
			
		}
		
	}
	
}