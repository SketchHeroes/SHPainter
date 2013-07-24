package mx.controls.listClasses
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ListBaseSelectionData extends Object
   {
      public function ListBaseSelectionData(param1:Object, param2:int, param3:Boolean) {
         super();
         this.data=param1;
         this.index=param2;
         this.approximate=param3;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var nextSelectionData:ListBaseSelectionData;

      mx_internal var prevSelectionData:ListBaseSelectionData;

      public var approximate:Boolean;

      public var data:Object;

      public var index:int;
   }

}