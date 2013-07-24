package mx.controls.listClasses
{
   import mx.core.mx_internal;
   import mx.collections.CursorBookmark;

   use namespace mx_internal;

   public class ListBaseSelectionPending extends Object
   {
      public function ListBaseSelectionPending(param1:Boolean, param2:int, param3:Object, param4:Boolean, param5:CursorBookmark, param6:CursorBookmark, param7:int) {
         super();
         this.incrementing=param1;
         this.index=param2;
         this.stopData=param3;
         this.transition=param4;
         this.placeHolder=param5;
         this.bookmark=param6;
         this.offset=param7;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var bookmark:CursorBookmark;

      public var incrementing:Boolean;

      public var index:int;

      public var offset:int;

      public var placeHolder:CursorBookmark;

      public var stopData:Object;

      public var transition:Boolean;
   }

}