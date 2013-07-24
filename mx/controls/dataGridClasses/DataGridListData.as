package mx.controls.dataGridClasses
{
   import mx.controls.listClasses.BaseListData;
   import mx.core.mx_internal;
   import mx.core.IUIComponent;

   use namespace mx_internal;

   public class DataGridListData extends BaseListData
   {
      public function DataGridListData(param1:String, param2:String, param3:int, param4:String, param5:IUIComponent, param6:int=0) {
         super(param1,param4,param5,param6,param3);
         this.dataField=param2;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var dataField:String;
   }

}