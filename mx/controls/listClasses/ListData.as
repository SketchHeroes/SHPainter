package mx.controls.listClasses
{
   import mx.core.mx_internal;
   import mx.core.IUIComponent;

   use namespace mx_internal;

   public class ListData extends BaseListData
   {
      public function ListData(param1:String, param2:Class, param3:String, param4:String, param5:IUIComponent, param6:int=0, param7:int=0) {
         super(param1,param4,param5,param6,param7);
         this.icon=param2;
         this.labelField=param3;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var icon:Class;

      public var labelField:String;
   }

}