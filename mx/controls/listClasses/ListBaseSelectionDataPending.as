package mx.controls.listClasses
{
   import mx.core.mx_internal;
   import mx.collections.CursorBookmark;

   use namespace mx_internal;

   public class ListBaseSelectionDataPending extends Object
   {
      public function ListBaseSelectionDataPending(param1:Boolean, param2:int, param3:Array, param4:CursorBookmark, param5:int) {
         super();
         this.useFind=param1;
         this.index=param2;
         this.items=param3;
         this.bookmark=param4;
         this.offset=param5;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var bookmark:CursorBookmark;

      public var index:int;

      public var items:Array;

      public var offset:int;

      public var useFind:Boolean;
   }

}